#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <errno.h>

#include "upnpreplyparse.h"
#include "getifaddr.h"
#include "minissdp.h"
#include "codelength.h"

// DLAN directory
#include "minidlnapath.h"
#include "utils.h"
#include "log.h"

/* SSDP ip/port */
#define SSDP_PORT (1900)
#define SSDP_MCAST_ADDR ("239.255.255.250")

#define MINIDLNA_SERVER_STRING  OS_VERSION " DLNADOC/1.50 UPnP/1.0 MiniDLNA/1.0"

static const char * const known_service_types[] =
{
	uuidvalue,
	"upnp:rootdevice",
	"urn:schemas-upnp-org:device:MediaServer:",
	"urn:schemas-upnp-org:service:ContentDirectory:",
	"urn:schemas-upnp-org:service:ConnectionManager:",
	"urn:microsoft.com:service:X_MS_MediaReceiverRegistrar:",
	0
};

static void
_usleep(long usecs)
{
	struct timespec sleep_time;

	sleep_time.tv_sec = 0;
	sleep_time.tv_nsec = usecs * 1000;
	nanosleep(&sleep_time, NULL);
}

/* not really an SSDP "announce" as it is the response
 * to a SSDP "M-SEARCH" */
void
DLNA_SendSSDPAnnounce2(int s, struct sockaddr_in sockname, int st_no,
                  const char * host, unsigned short port)
{
	int l, n;
	char buf[512];
	/*
	 * follow guideline from document "UPnP Device Architecture 1.0"
	 * uppercase is recommended.
	 * DATE: is recommended
	 * SERVER: OS/ver UPnP/1.0 minidlna/1.0
	 * - check what to put in the 'Cache-Control' header 
	 * */
	char   szTime[30];
	time_t tTime = time(NULL);
	strftime(szTime, 30,"%a, %d %b %Y %H:%M:%S GMT" , gmtime(&tTime));

	l = snprintf(buf, sizeof(buf), "HTTP/1.1 200 OK\r\n"
		"CACHE-CONTROL: max-age=%u\r\n"
		"DATE: %s\r\n"
		"ST: %s%s\r\n"
		"USN: %s%s%s%s\r\n"
		"EXT:\r\n"
		"SERVER: " MINIDLNA_SERVER_STRING "\r\n"
		"LOCATION: http://%s:%u" ROOTDESC_PATH "\r\n"
		"Content-Length: 0\r\n"
		"\r\n",
		(runtime_vars.notify_interval<<1)+10,
		szTime,
		known_service_types[st_no], (st_no>1?"1":""),
		uuidvalue, (st_no>0?"::":""), (st_no>0?known_service_types[st_no]:""), (st_no>1?"1":""),
		host, (unsigned int)port);
	//DEBUG DPRINTF(E_DEBUG, L_SSDP, "Sending M-SEARCH response:\n%s", buf);
	n = sendto(s, buf, l, 0,
	           (struct sockaddr *)&sockname, sizeof(struct sockaddr_in) );
	if(n < 0)
	{
		DPRINTF(E_ERROR, L_SSDP, "sendto(udp): %s\n", strerror(errno));
	}
}

static void
SendSSDPNotifies(int s, const char * host, unsigned short port,
                 unsigned int lifetime)
{
	struct sockaddr_in sockname;
	int l, n, dup, i=0;
	char bufr[512];

	memset(&sockname, 0, sizeof(struct sockaddr_in));
	sockname.sin_family = AF_INET;
	sockname.sin_port = htons(SSDP_PORT);
	sockname.sin_addr.s_addr = inet_addr(SSDP_MCAST_ADDR);

	for( dup=0; dup<2; dup++ )
	{
		if( dup )
			_usleep(200000);
		i=0;
		while(known_service_types[i])
		{
			l = snprintf(bufr, sizeof(bufr), 
					"NOTIFY * HTTP/1.1\r\n"
					"HOST:%s:%d\r\n"
					"CACHE-CONTROL:max-age=%u\r\n"
					"LOCATION:http://%s:%d" ROOTDESC_PATH"\r\n"
					"SERVER: " MINIDLNA_SERVER_STRING "\r\n"
					"NT:%s%s\r\n"
					"USN:%s%s%s%s\r\n"
					"NTS:ssdp:alive\r\n"
					"\r\n",
					SSDP_MCAST_ADDR, SSDP_PORT,
					lifetime,
					host, port,
					known_service_types[i], (i>1?"1":""),
					uuidvalue, (i>0?"::":""), (i>0?known_service_types[i]:""), (i>1?"1":"") );
			if(l>=sizeof(bufr))
			{
				DPRINTF(E_WARN, L_SSDP, "SendSSDPNotifies(): truncated output\n");
				l = sizeof(bufr);
			}
			//DEBUG DPRINTF(E_DEBUG, L_SSDP, "Sending NOTIFY:\n%s", bufr);
			n = sendto(s, bufr, l, 0,
				(struct sockaddr *)&sockname, sizeof(struct sockaddr_in) );
			if(n < 0)
			{
				DPRINTF(E_ERROR, L_SSDP, "sendto(udp_notify=%d, %s): %s\n", s, host, strerror(errno));
			}
			i++;
		}
	}
}

void
DLNA_SendSSDPNotifies2(int * sockets,
                  unsigned short port,
                  unsigned int lifetime)
{
	int i;
	DPRINTF(E_DEBUG, L_SSDP, "Sending SSDP notifies\n");
	for(i=0; i<n_lan_addr; i++)
	{
		SendSSDPNotifies(sockets[i], lan_addr[i].str, port, lifetime);
	}
}

static void
ParseUPnPClient(char *location)
{
	char buf[8192];
	struct sockaddr_in dest;
	int s, n, do_headers = 0, nread = 0;
	struct timeval tv;
	char *addr, *path, *port_str;
	long port = 80;
	char *off = NULL, *p;
	int content_len = sizeof(buf);
	struct NameValueParserData xml;
	int client;
	enum client_types type = 0;
	uint32_t flags = 0;
	char *model, *serial, *name;

	if (strncmp(location, "http://", 7) != 0)
		return;
	path = location + 7;
	port_str = strsep(&path, "/");
	if (!path)
		return;
	addr = strsep(&port_str, ":");
	if (port_str)
	{
		port = strtol(port_str, NULL, 10);
		if (!port)
			port = 80;
	}

	memset(&dest, '\0', sizeof(dest));
	if (!inet_aton(addr, &dest.sin_addr))
		return;
	/* Check if the client is already in cache */
	dest.sin_family = AF_INET;
	dest.sin_port = htons(port);

	s = socket(PF_INET, SOCK_STREAM, 0);
	if( s < 0 )
		return;

	tv.tv_sec = 0;
	tv.tv_usec = 500000;
	setsockopt(s, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
	setsockopt(s, SOL_SOCKET, SO_SNDTIMEO, &tv, sizeof(tv));

	if( connect(s, (struct sockaddr*)&dest, sizeof(struct sockaddr_in)) < 0 )
		goto close;

	n = snprintf(buf, sizeof(buf), "GET /%s HTTP/1.0\r\n"
	                               "HOST: %s:%ld\r\n\r\n",
	                               path, addr, port);
	if( write(s, buf, n) < 1 )
		goto close;

	while( (n = read(s, buf+nread, sizeof(buf)-nread-1)) > 0 )
	{
		nread += n;
		buf[nread] = '\0';
		n = nread;
		p = buf;

		while( !off && n-- > 0 )
		{
			if(p[0]=='\r' && p[1]=='\n' && p[2]=='\r' && p[3]=='\n')
			{
				off = p + 4;
				do_headers = 1;
			}
			p++;
		}
		if( !off )
			continue;

		if( do_headers )
		{
			p = buf;
			if( strncmp(p, "HTTP/", 5) != 0 )
				goto close;
			while(*p != ' ' && *p != '\t') p++;
			/* If we don't get a 200 status, ignore it */
			if( strtol(p, NULL, 10) != 200 )
				goto close;
			if( (p = strcasestr(p, "Content-Length:")) )
				content_len = strtol(p+15, NULL, 10);
			do_headers = 0;
		}
		if( buf + nread - off >= content_len )
			break;
	}
close:
	close(s);
	if( !off )
		return;
	nread -= off - buf;
	ParseNameValue(off, nread, &xml);
	model = GetValueFromNameValueList(&xml, "modelName");
	serial = GetValueFromNameValueList(&xml, "serialNumber");
	name = GetValueFromNameValueList(&xml, "friendlyName");
	if( model )
	{
		DPRINTF(E_DEBUG, L_SSDP, "Model: %s\n", model);
		if( strstr(model, "Roku SoundBridge") )
		{
			type = ERokuSoundBridge;
			flags |= FLAG_MS_PFS;
			flags |= FLAG_AUDIO_ONLY;
			flags |= FLAG_MIME_WAV_WAV;
		}
		else if( strcmp(model, "Samsung DTV DMR") == 0 && serial )
		{
			DPRINTF(E_DEBUG, L_SSDP, "Serial: %s\n", serial);
			/* The Series B I saw was 20081224DMR.  Series A should be older than that. */
			if( atoi(serial) > 20081200 )
			{
				type = ESamsungSeriesB;
				flags |= FLAG_SAMSUNG;
				flags |= FLAG_DLNA;
				flags |= FLAG_NO_RESIZE;
			}
		}
		else
		{
			if( name && (strcmp(name, "marantz DMP") == 0) )
			{
				type = EMarantzDMP;
				flags |= FLAG_DLNA;
				flags |= FLAG_MIME_WAV_WAV;
			}
		}
	}
	ClearNameValueList(&xml);
	if( !type )
		return;
	/* Add this client to the cache if it's not there already. */
	client = SearchClientCache(dest.sin_addr, 1);
	if( client < 0 )
	{
		for( client=0; client<CLIENT_CACHE_SLOTS; client++ )
		{
			if( clients[client].addr.s_addr )
				continue;
			clients[client].addr = dest.sin_addr;
#if 0
			get_remote_mac(dest.sin_addr, clients[client].mac);
			DPRINTF(E_DEBUG, L_SSDP, "Added client [%d/%s/%02X:%02X:%02X:%02X:%02X:%02X] to cache slot %d.\n",
			                         type, inet_ntoa(clients[client].addr),
			                         clients[client].mac[0], clients[client].mac[1], clients[client].mac[2],
			                         clients[client].mac[3], clients[client].mac[4], clients[client].mac[5], client);
#endif
			break;
		}
	}
	clients[client].type = type;
	clients[client].flags = flags;
	clients[client].age = time(NULL);
}

/* ProcessSSDPRequest()
 * process SSDP M-SEARCH requests and responds to them */
void
DLNA_ProcessSSDPRequest(int s, unsigned short port)
{
	int n;
	char bufr[1500];
	socklen_t len_r;
	struct sockaddr_in sendername;
	int i;
	char *st = NULL, *mx = NULL, *man = NULL, *mx_end = NULL;
	int man_len = 0;
	len_r = sizeof(struct sockaddr_in);

	n = recvfrom(s, bufr, sizeof(bufr)-1, 0,
	             (struct sockaddr *)&sendername, &len_r);
	if(n < 0)
	{
		DPRINTF(E_ERROR, L_SSDP, "recvfrom(udp): %s\n", strerror(errno));
		return;
	}
	bufr[n] = '\0';

	if(memcmp(bufr, "NOTIFY", 6) == 0)
	{
		char *loc = NULL, *srv = NULL, *nts = NULL, *nt = NULL;
		int loc_len = 0;
		//DEBUG DPRINTF(E_DEBUG, L_SSDP, "Received SSDP notify:\n%.*s", n, bufr);
		for(i=0; i < n; i++)
		{
			if( bufr[i] == '*' )
				break;
		}
		if( !strcasestr(bufr+i, "HTTP/1.1") )
		{
			return;
		}
		while(i < n)
		{
			while((i < n - 2) && (bufr[i] != '\r' || bufr[i+1] != '\n'))
				i++;
			i += 2;
			if(strncasecmp(bufr+i, "SERVER:", 7) == 0)
			{
				srv = bufr+i+7;
				while(*srv == ' ' || *srv == '\t') srv++;
			}
			else if(strncasecmp(bufr+i, "LOCATION:", 9) == 0)
			{
				loc = bufr+i+9;
				while(*loc == ' ' || *loc == '\t') loc++;
				while(loc[loc_len]!='\r' && loc[loc_len]!='\n') loc_len++;
			}
			else if(strncasecmp(bufr+i, "NTS:", 4) == 0)
			{
				nts = bufr+i+4;
				while(*nts == ' ' || *nts == '\t') nts++;
			}
			else if(strncasecmp(bufr+i, "NT:", 3) == 0)
			{
				nt = bufr+i+3;
				while(*nt == ' ' || *nt == '\t') nt++;
			}
		}
		if( !loc || !srv || !nt || !nts || (strncmp(nts, "ssdp:alive", 10) != 0) ||
		    (strncmp(nt, "urn:schemas-upnp-org:device:MediaRenderer", 41) != 0) )
		{
			return;
		}
		loc[loc_len] = '\0';
		if( (strncmp(srv, "Allegro-Software-RomPlug", 24) == 0) || /* Roku */
		    (strstr(loc, "SamsungMRDesc.xml") != NULL) || /* Samsung TV */
		    (strstrc(srv, "DigiOn DiXiM", '\r') != NULL) ) /* Marantz Receiver */
		{
			/* Check if the client is already in cache */
			i = SearchClientCache(sendername.sin_addr, 1);
			if( i >= 0 )
			{
				if( clients[i].type < EStandardDLNA150 &&
				    clients[i].type != ESamsungSeriesA )
				{
					clients[i].age = time(NULL);
					return;
				}
			}
			ParseUPnPClient(loc);
		}
		return;
	}
	else
	{
		DPRINTF(E_WARN, L_SSDP, "Unknown udp packet received from %s:%d\n",
		       inet_ntoa(sendername.sin_addr), ntohs(sendername.sin_port));
	}
}

/* This will broadcast ssdp:byebye notifications to inform 
 * the network that UPnP is going down. */
int
DLNA_SendSSDPGoodbye(int * sockets, int n_sockets)
{
	struct sockaddr_in sockname;
	int n, l;
	int i, j;
	char bufr[512];

	memset(&sockname, 0, sizeof(struct sockaddr_in));
	sockname.sin_family = AF_INET;
	sockname.sin_port = htons(SSDP_PORT);
	sockname.sin_addr.s_addr = inet_addr(SSDP_MCAST_ADDR);

	for(j=0; j<n_sockets; j++)
	{
		for(i=0; known_service_types[i]; i++)
		{
			l = snprintf(bufr, sizeof(bufr),
			             "NOTIFY * HTTP/1.1\r\n"
			             "HOST:%s:%d\r\n"
			             "NT:%s%s\r\n"
			             "USN:%s%s%s%s\r\n"
			             "NTS:ssdp:byebye\r\n"
			             "\r\n",
			             SSDP_MCAST_ADDR, SSDP_PORT,
			             known_service_types[i], (i>1?"1":""),
			             uuidvalue, (i>0?"::":""), (i>0?known_service_types[i]:""), (i>1?"1":"") );
			//DEBUG DPRINTF(E_DEBUG, L_SSDP, "Sending NOTIFY:\n%s", bufr);
			n = sendto(sockets[j], bufr, l, 0,
			           (struct sockaddr *)&sockname, sizeof(struct sockaddr_in) );
			if(n < 0)
			{
				DPRINTF(E_ERROR, L_SSDP, "sendto(udp_shutdown=%d): %s\n", sockets[j], strerror(errno));
				return -1;
			}
		}
	}
	return 0;
}
