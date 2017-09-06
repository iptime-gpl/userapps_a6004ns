/*-
 * See the file LICENSE for redistribution information.
 *
 * Copyright (c) 1996, 2011 Oracle and/or its affiliates.  All rights reserved.
 *
 * $Id: crypto_stub.c,v 1.1.1.1 2012/04/24 01:43:04 thki81 Exp $
 */

#include "db_config.h"

#include "db_int.h"

/*
 * __crypto_region_init --
 *	Initialize crypto.
 *
 *
 * !!!
 * We don't put this stub file in the crypto/ directory of the distribution
 * because that entire directory is removed for non-crypto distributions.
 *
 * PUBLIC: int __crypto_region_init __P((ENV *));
 */
int
__crypto_region_init(env)
	ENV *env;
{
	REGENV *renv;
	REGINFO *infop;
	int ret;

	infop = env->reginfo;
	renv = infop->primary;
	MUTEX_LOCK(env, renv->mtx_regenv);
	ret = !(renv->cipher_off == INVALID_ROFF);
	MUTEX_UNLOCK(env, renv->mtx_regenv);

	if (ret == 0)
		return (0);

	__db_errx(env, DB_STR("0040",
"Encrypted environment: library build did not include cryptography support"));
	return (DB_OPNOTSUP);
}
