/*
 * $Id: session.h,v 1.1.1.1 2012/04/24 02:28:29 thki81 Exp $
 */

#ifndef PAPD_SESSION_H
#define PAPD_SESSION_H 1

#include <atalk/atp.h>

int session( ATP atp, struct sockaddr_at *sat );

#endif /* PAPD_SESSION_H */
