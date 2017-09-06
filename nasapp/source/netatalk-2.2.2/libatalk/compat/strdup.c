/*
 * $Id: strdup.c,v 1.1.1.1 2012/04/24 02:28:26 thki81 Exp $
 */

#ifdef HAVE_CONFIG_H
#include "config.h"
#endif /* HAVE_CONFIG_H */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef ultrix
char *strdup(const char *string)
{
  char *new;
  
  if (new = (char *) malloc(strlen(string) + 1))
    strcpy(new, string);

  return new;
}
#endif /* ultrix */
