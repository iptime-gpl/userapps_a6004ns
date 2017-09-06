/*
 * $Id: updcrc.h,v 1.1.1.1 2012/04/24 02:28:31 thki81 Exp $
 */

#ifndef _UPDCRC_H
#define _UPDCRC_H 1

#define W	16	/* bits in CRC:16	16	16	*/

    /* data type that holds a W-bit unsigned integer */
#if W <= 16
#  define WTYPE	unsigned short
#else /* W <= 16 */
#  define WTYPE   u_int32_t
#endif /* W <= 16 */

WTYPE updcrc(WTYPE icrc, unsigned char *icp, int icnt);

#endif /* _UPDCRC_H */
