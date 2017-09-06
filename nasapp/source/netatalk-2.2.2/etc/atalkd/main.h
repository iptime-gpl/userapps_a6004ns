/*
 * $Id: main.h,v 1.1.1.1 2012/04/24 02:28:29 thki81 Exp $
 */

#ifndef ATALKD_MAIN_H
#define ATALKD_MAIN_H

#include <sys/cdefs.h>
#include "config.h"

extern int transition;
extern int stabletimer, newrtmpdata;

int ifconfig ( const char *, unsigned long, struct sockaddr_at * );
void setaddr ( struct interface *, u_int8_t, u_int16_t,
        u_int8_t, u_int16_t, u_int16_t );
void bootaddr ( struct interface * );
void dumpconfig ( struct interface * );

#ifdef linux
int ifsetallmulti ( const char *, int);
#endif

#endif /* ATALKD_MAIN_H */
