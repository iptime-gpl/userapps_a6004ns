/*
 * $Id: multicast.h,v 1.1.1.1 2012/04/24 02:28:29 thki81 Exp $
 *
 * Copyright (c) 1990,1997 Regents of The University of Michigan.
 * All Rights Reserved. See COPYRIGHT.
 */

#ifndef ATALKD_MULTICAST_H
#define ATALKD_MULTICAST_H 1

#include <sys/cdefs.h>
#include "zip.h"

int addmulti (const char *, const unsigned char *);
int zone_bcast (struct ziptab *);

#endif /* atalkd/multicast.h */
