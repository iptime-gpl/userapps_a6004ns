/*
 * $Id: list.h,v 1.1.1.1 2012/04/24 02:28:29 thki81 Exp $
 *
 * Copyright (c) 1990,1992 Regents of The University of Michigan.
 * All Rights Reserved. See COPYRIGHT.
 */

struct list {
    void	*l_data;
    struct list	*l_next,
		*l_prev;
};
