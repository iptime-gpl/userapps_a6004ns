#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <getopt.h>
#include <ctype.h>

#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#include <xtables.h>
#include <linux/netfilter/xt_dstmatch.h>


/* Function which prints out usage message. */
static void
help(void)
{
	printf(
"Destination IP address  options:\n"
"[!] --name  name       IP pool filename\n"
"\n");
}

#if 0
#define s struct xt_dstmatch_info
static struct xt_option_entry x6_opts[] = {
	{ .name = "name", .id = 1, .type = XTTYPE_STRING, .flags = XTOPT_MAND | XTOPT_INVERT | XTOPT_PUT, XTOPT_POINTER(s, name) },
	XTOPT_TABLEEND,
};
#else
static struct option opts[] = {
        { .name = "name", .has_arg = true, .val = '1' },
	XT_GETOPT_TABLEEND,
};
#endif

/* Initialize the match. */
static void dstmatch_init(struct xt_entry_match *m)
{
}

struct dstmatch_entry
{
	char sip[16];
	char eip[16];
};
#define MAX_ENTRY 	1000
static struct dstmatch_entry dmentry[MAX_ENTRY];

static int compare_ip(struct dstmatch_entry *e1, struct dstmatch_entry *e2)
{
	unsigned int ip1, ip2;

	ip1 = ntohl(inet_addr(e1->sip));
	ip2 = ntohl(inet_addr(e2->sip));

	return ((ip1 == ip2) ? 0 : (ip1 > ip2) ? 1 : -1);

}

static int sort_dstmatch(char *name)
{
	FILE *fp;
	char fname[128], fbuf[128], buffer[128], *ipstr;
	int i, idx = 0;
	int rc = 0;

	
	sprintf(fname,"/etc/dstmatch/%s", name);
	fp = fopen(fname, "r");
	if (fp)
	{
		memset(&dmentry[0], 0, sizeof(struct dstmatch_entry)*MAX_ENTRY);
		while (fgets(fbuf, 128, fp))
		{
			ipstr = strchr(fbuf, '\r');
			if (ipstr) *ipstr = 0x0;
			ipstr = strchr(fbuf, '\n');
			if (ipstr) *ipstr = 0x0;
			ipstr = strchr(fbuf, ' ');
			if (ipstr) *ipstr = 0x0;

			strcpy(buffer, fbuf);
			ipstr = strtok(buffer, "~");

			if (!ipstr || !xtables_numeric_to_ipaddr(ipstr))
				continue;

			strcpy(dmentry[idx].sip, ipstr);

			ipstr = strtok(NULL, "~");

			if (!ipstr)
				strcpy(dmentry[idx].eip, dmentry[idx].sip);
			else if (xtables_numeric_to_ipaddr(ipstr))
				strcpy(dmentry[idx].eip, ipstr);
			else
				continue;

			if (++idx >= MAX_ENTRY) break;	
		}	
		fclose(fp);

		qsort(&dmentry[0], idx, sizeof(struct dstmatch_entry), (const void *)compare_ip);


		fp = fopen(fname, "w");
		if (fp)
		{
			for (i=0; i<idx; i++)
				fprintf(fp, "%s~%s\n", dmentry[i].sip, dmentry[i].eip);
			fclose(fp);
		}
		rc = 1;
	}

	return rc;
}

static void parse_string(const char *str, struct xt_dstmatch_info *info)
{
        if (strlen(str) <= IPT_DSTMATCH_NAME_LEN) {
                strcpy(info->name, str);
                return;
        }
        xtables_error(PARAMETER_PROBLEM, "STRING too long \"%s\"", str);
}

static int
dstmatch_parse(int c, char **argv, int invert, unsigned int *flags, const void *entry, struct xt_entry_match **match)
{
        struct xt_dstmatch_info *dstmatchinfo = (struct xt_dstmatch_info *)(*match)->data;

        switch (c) {
        case '1':
                parse_string(optarg, dstmatchinfo);
                if (invert)
                        dstmatchinfo->invert = 1;

                dstmatchinfo->options = 0;
                *flags = 1;
                if (!strcmp(argv[3], "-I") || !strcmp(argv[3], "-A"))
                        return (sort_dstmatch(dstmatchinfo->name));
                else
                        return 1;

        default:
                return 0;
        }
        return 1;
}


static void final_check(unsigned int flags)
{
        if (!flags)
                xtables_error(PARAMETER_PROBLEM,
                           "DSTIP match: You must specify `--name'");
}

#if 0
static void dstmatch_x6_parse(struct xt_option_call *cb)
{
	struct xt_dstmatch_info *info = (struct xt_dstmatch_info *)cb->data;

	printf("dstmatch_x6_parse(%s) \n", info->name);
	xtables_option_parse(cb);
	switch (cb->entry->id) {
	case 1:
		if (cb->invert)
			info->invert = 1;
		info->options = 0;
		//if (!strcmp(cb->arg[3], "-I") || !strcmp(cb->arg[3], "-A"))
		//	sort_dstmatch(info->name);
		break;
	default:
		break;
	}
	printf("dstmatch_x6_parse2 (%s) \n", info->name);
}

static void final_x6_check(struct xt_fcheck_call *cb)
{
	return;
}
#endif

static void print_dstmatch(const char *name)
{
	printf(" %s ", name);
}

/* Prints out the matchinfo. */
static void dstmatch_print(const void *ip, struct xt_entry_match *match, int numeric)
{
	struct xt_dstmatch_info *info = (struct xt_dstmatch_info *)match->data;

	printf("dstmatch %s", info->invert?"!":"");
	print_dstmatch(info->name);
}

/* Saves the union ipt_matchinfo in parsable form to stdout. */
static void dstmatch_save(const void *ip, const struct xt_entry_match *match)
{
	const struct xt_dstmatch_info *info =  (const struct xt_dstmatch_info *)match->data;

	printf("--name %s", info->invert?"!":"");
	print_dstmatch(info->name);
}

static struct xtables_match dstmatch = { 
		.name           = "dstmatch",
		.family         = NFPROTO_UNSPEC,
		.version        = XTABLES_VERSION,
		.size           = XT_ALIGN(sizeof(struct xt_dstmatch_info)),
		.userspacesize  = XT_ALIGN(sizeof(struct xt_dstmatch_info)),
		.help           = help,
		.init           = dstmatch_init,
		.print          = dstmatch_print,
		.save           = dstmatch_save,
#if 0
		.x6_parse       = dstmatch_x6_parse,
		.x6_fcheck      = final_x6_check,
                .x6_options     = x6_opts,
#else
		.parse          = dstmatch_parse,
		.final_check    = final_check,
                .extra_opts     = opts,
#endif
};

void _init(void)
{
	xtables_register_match(&dstmatch);
}
