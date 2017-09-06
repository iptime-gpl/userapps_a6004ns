/*
 * $Id: printcap.h,v 1.1.1.1 2012/04/24 02:28:29 thki81 Exp $
 */

#ifndef PAPD_PRINTCAP_H
#define PAPD_PRINTCAP_H 1

#include <sys/cdefs.h>

int getprent ( register char *, register char *, register int );
int pnchktc ( char * );
int pgetflag ( char * );
void endprent ( void );
int pgetent ( char *, char *, char * );
int pgetnum ( char * );
int pnamatch ( char * );

#endif /* PAPD_PRINTCAP_H */
