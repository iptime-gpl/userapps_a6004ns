mod_mpm_prefork.la: prefork.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version prefork.lo
DISTCLEAN_TARGETS = modules.mk
static =
shared = mod_mpm_prefork.la
