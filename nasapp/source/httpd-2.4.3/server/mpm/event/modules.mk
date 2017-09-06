mod_mpm_event.la: event.slo fdqueue.slo pod.slo
	$(SH_LINK) -rpath $(libexecdir) -module -avoid-version event.lo fdqueue.lo pod.lo $(MOD_MPM_EVENT_LDADD)
DISTCLEAN_TARGETS = modules.mk
static =
shared = mod_mpm_event.la
