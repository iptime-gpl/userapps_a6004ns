#ifndef _IPT_DSTMATCH_H
#define _IPT_DSTMATCH_H

#include <linux/types.h>


#define IPT_DSTMATCH_NAME_LEN	32 

struct xt_dstmatch_info {
    char name[IPT_DSTMATCH_NAME_LEN];
    __u32  options;
    __u32 invert;
};

#endif
