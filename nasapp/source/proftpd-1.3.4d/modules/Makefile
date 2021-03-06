

top_builddir=..
top_srcdir=..
srcdir=.

GLUE_MODULE_OBJS=mod_core.o mod_xfer.o mod_auth_unix.o  mod_auth.o mod_ls.o mod_log.o mod_site.o mod_delay.o mod_facts.o mod_ident.o mod_codeconv.o mod_df.o mod_lang.o
LTDLINCL=
SHARED_CFLAGS=-DPR_SHARED_MODULE
SHARED_LDFLAGS=-avoid-version -export-dynamic -module


include ../Make.rules

.SUFFIXES: .la

.PHONY: ""

all:
	@echo "Running make from top level directory."
	cd .. && $(MAKE) all

Makefile: Makefile.in ../config.status
	cd ../ && ./config.status

# Special instructions for mod_dso, to include the libltdl headers
mod_dso.o: mod_dso.c
	$(CC) $(CPPFLAGS) $(LTDLINCL) $(CFLAGS) -c mod_dso.c

.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $<

.c.la:
	$(LIBTOOL) --mode=compile --tag=CC $(CC) $(CPPFLAGS) $(CFLAGS) $(SHARED_CFLAGS) -c $*.c
	$(LIBTOOL) --mode=link --tag=CC $(CC) -o $@ -rpath $(LIBEXECDIR) $(LDFLAGS) $(SHARED_LDFLAGS) $*.lo `cat $(top_srcdir)/modules/$*.c | grep '$$Libraries:' | sed -e 's/^.*\$$Libraries: \(.*\)\\$$/\1/'`

module_glue.c: module_glue.c.tmpl $(STATIC_MODULE_OBJS)
	srcdir=$(srcdir) $(srcdir)/glue.sh $(GLUE_MODULE_OBJS)

shared: $(SHARED_MODULE_OBJS)
	@dirs="$(SHARED_MODULE_DIRS)"; \
	for dir in $$dirs; do \
		(cd $(top_srcdir)/$$dir/ && $(MAKE) shared); \
	done

static: $(STATIC_MODULE_OBJS) module_glue.o
	@dirs="$(STATIC_MODULE_DIRS)"; \
	for dir in $$dirs; do \
		module=`echo "$$dir" | sed -e 's/^.*\///'`; \
		(cd $(top_srcdir)/$$dir/ && $(MAKE) static); \
		cp $(top_srcdir)/$$dir/$$module.o .; \
	done

install:
	test -z "$(SHARED_MODULE_OBJS)" || $(LIBTOOL) --mode=install --tag=CC $(INSTALL_BIN) $(SHARED_MODULE_OBJS) $(DESTDIR)$(LIBEXECDIR)
	@dirs="$(SHARED_MODULE_DIRS) $(STATIC_MODULE_DIRS)"; \
	for dir in $$dirs; do \
		(cd $(top_srcdir)/$$dir/ && $(MAKE) install); \
	done

clean:
	$(RM) *.a *.o module_glue.c
	$(LIBTOOL) --mode=clean $(RM) $(SHARED_MODULE_OBJS)
	$(LIBTOOL) --mode=clean $(RM) `echo $(SHARED_MODULE_OBJS) | sed 's/\.la$\/.lo/g'`
	@dirs="$(SHARED_MODULE_DIRS) $(STATIC_MODULE_DIRS)"; \
	for dir in $$dirs; do \
		(cd $(top_srcdir)/$$dir/ && $(MAKE) clean); \
	done

depend:
	$(RM) module_glue.c
	makedepend $(CPPFLAGS) -Y *.c 2>/dev/null
	makedepend $(CPPFLAGS) -Y -fMakefile.in *.c 2>/dev/null
# DO NOT DELETE

mod_auth.o: ../include/conf.h ../include/version.h ../config.h
mod_auth.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_auth.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_auth.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_auth.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_auth.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_auth.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_auth.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_auth.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_auth.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_auth.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_auth.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_auth.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_auth.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_auth.o: ../include/session.h ../include/event.h ../include/var.h
mod_auth.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_auth.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_auth.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_auth.o: ../include/tpl.h ../include/privs.h
mod_auth_file.o: ../include/conf.h ../include/version.h ../config.h
mod_auth_file.o: ../include/default_paths.h ../include/options.h
mod_auth_file.o: ../include/pool.h ../include/str.h ../include/table.h
mod_auth_file.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_auth_file.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_auth_file.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_auth_file.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_auth_file.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_auth_file.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_auth_file.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_auth_file.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_auth_file.o: ../include/parser.h ../include/xferlog.h
mod_auth_file.o: ../include/scoreboard.h ../include/data.h
mod_auth_file.o: ../include/display.h ../include/libsupp.h
mod_auth_file.o: ../include/glibc-glob.h ../include/fsio.h
mod_auth_file.o: ../include/mkhome.h ../include/ctrls.h ../include/session.h
mod_auth_file.o: ../include/event.h ../include/var.h ../include/throttle.h
mod_auth_file.o: ../include/trace.h ../include/encode.h ../include/compat.h
mod_auth_file.o: ../include/proctitle.h ../include/pidfile.h ../include/env.h
mod_auth_file.o: ../include/pr-syslog.h ../include/memcache.h
mod_auth_file.o: ../include/tpl.h
mod_auth_pam.o: ../include/conf.h ../include/version.h ../config.h
mod_auth_pam.o: ../include/default_paths.h ../include/options.h
mod_auth_pam.o: ../include/pool.h ../include/str.h ../include/table.h
mod_auth_pam.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_auth_pam.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_auth_pam.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_auth_pam.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_auth_pam.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_auth_pam.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_auth_pam.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_auth_pam.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_auth_pam.o: ../include/parser.h ../include/xferlog.h
mod_auth_pam.o: ../include/scoreboard.h ../include/data.h
mod_auth_pam.o: ../include/display.h ../include/libsupp.h
mod_auth_pam.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_auth_pam.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_auth_pam.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_auth_pam.o: ../include/encode.h ../include/compat.h
mod_auth_pam.o: ../include/proctitle.h ../include/pidfile.h ../include/env.h
mod_auth_pam.o: ../include/pr-syslog.h ../include/memcache.h ../include/tpl.h
mod_auth_pam.o: ../include/privs.h
mod_auth_unix.o: ../include/conf.h ../include/version.h ../config.h
mod_auth_unix.o: ../include/default_paths.h ../include/options.h
mod_auth_unix.o: ../include/pool.h ../include/str.h ../include/table.h
mod_auth_unix.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_auth_unix.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_auth_unix.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_auth_unix.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_auth_unix.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_auth_unix.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_auth_unix.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_auth_unix.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_auth_unix.o: ../include/parser.h ../include/xferlog.h
mod_auth_unix.o: ../include/scoreboard.h ../include/data.h
mod_auth_unix.o: ../include/display.h ../include/libsupp.h
mod_auth_unix.o: ../include/glibc-glob.h ../include/fsio.h
mod_auth_unix.o: ../include/mkhome.h ../include/ctrls.h ../include/session.h
mod_auth_unix.o: ../include/event.h ../include/var.h ../include/throttle.h
mod_auth_unix.o: ../include/trace.h ../include/encode.h ../include/compat.h
mod_auth_unix.o: ../include/proctitle.h ../include/pidfile.h ../include/env.h
mod_auth_unix.o: ../include/pr-syslog.h ../include/memcache.h
mod_auth_unix.o: ../include/tpl.h ../include/privs.h
mod_cap.o: ../lib/libcap/include/sys/capability.h ../include/conf.h
mod_cap.o: ../include/version.h ../config.h ../include/default_paths.h
mod_cap.o: ../include/options.h ../include/pool.h ../include/str.h
mod_cap.o: ../include/table.h ../include/proftpd.h ../include/class.h
mod_cap.o: ../include/netacl.h ../include/support.h ../include/sets.h
mod_cap.o: ../include/dirtree.h ../include/expr.h ../include/filter.h
mod_cap.o: ../include/netio.h ../include/modules.h ../include/regexp.h
mod_cap.o: ../include/stash.h ../include/auth.h ../include/response.h
mod_cap.o: ../include/timers.h ../include/inet.h ../include/child.h
mod_cap.o: ../include/netaddr.h ../include/cmd.h ../include/bindings.h
mod_cap.o: ../include/help.h ../include/feat.h ../include/ftp.h
mod_cap.o: ../include/log.h ../include/parser.h ../include/xferlog.h
mod_cap.o: ../include/scoreboard.h ../include/data.h ../include/display.h
mod_cap.o: ../include/libsupp.h ../include/glibc-glob.h ../include/fsio.h
mod_cap.o: ../include/mkhome.h ../include/ctrls.h ../include/session.h
mod_cap.o: ../include/event.h ../include/var.h ../include/throttle.h
mod_cap.o: ../include/trace.h ../include/encode.h ../include/compat.h
mod_cap.o: ../include/proctitle.h ../include/pidfile.h ../include/env.h
mod_cap.o: ../include/pr-syslog.h ../include/memcache.h ../include/tpl.h
mod_cap.o: ../include/privs.h
mod_core.o: ../include/conf.h ../include/version.h ../config.h
mod_core.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_core.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_core.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_core.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_core.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_core.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_core.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_core.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_core.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_core.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_core.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_core.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_core.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_core.o: ../include/session.h ../include/event.h ../include/var.h
mod_core.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_core.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_core.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_core.o: ../include/tpl.h ../include/privs.h
mod_ctrls.o: ../include/conf.h ../include/version.h ../config.h
mod_ctrls.o: ../include/default_paths.h ../include/options.h
mod_ctrls.o: ../include/pool.h ../include/str.h ../include/table.h
mod_ctrls.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_ctrls.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_ctrls.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_ctrls.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_ctrls.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_ctrls.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_ctrls.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_ctrls.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_ctrls.o: ../include/parser.h ../include/xferlog.h ../include/scoreboard.h
mod_ctrls.o: ../include/data.h ../include/display.h ../include/libsupp.h
mod_ctrls.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_ctrls.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_ctrls.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_ctrls.o: ../include/encode.h ../include/compat.h ../include/proctitle.h
mod_ctrls.o: ../include/pidfile.h ../include/env.h ../include/pr-syslog.h
mod_ctrls.o: ../include/memcache.h ../include/tpl.h ../include/privs.h
mod_ctrls.o: ../include/mod_ctrls.h
mod_delay.o: ../include/conf.h ../include/version.h ../config.h
mod_delay.o: ../include/default_paths.h ../include/options.h
mod_delay.o: ../include/pool.h ../include/str.h ../include/table.h
mod_delay.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_delay.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_delay.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_delay.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_delay.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_delay.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_delay.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_delay.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_delay.o: ../include/parser.h ../include/xferlog.h ../include/scoreboard.h
mod_delay.o: ../include/data.h ../include/display.h ../include/libsupp.h
mod_delay.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_delay.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_delay.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_delay.o: ../include/encode.h ../include/compat.h ../include/proctitle.h
mod_delay.o: ../include/pidfile.h ../include/env.h ../include/pr-syslog.h
mod_delay.o: ../include/memcache.h ../include/tpl.h ../include/privs.h
mod_dso.o: ../include/conf.h ../include/version.h ../config.h
mod_dso.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_dso.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_dso.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_dso.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_dso.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_dso.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_dso.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_dso.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_dso.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_dso.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_dso.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_dso.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_dso.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_dso.o: ../include/session.h ../include/event.h ../include/var.h
mod_dso.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_dso.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_dso.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_dso.o: ../include/tpl.h ../include/mod_ctrls.h ../lib/libltdl/ltdl.h
mod_facl.o: ../include/conf.h ../include/version.h ../config.h
mod_facl.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_facl.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_facl.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_facl.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_facl.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_facl.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_facl.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_facl.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_facl.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_facl.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_facl.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_facl.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_facl.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_facl.o: ../include/session.h ../include/event.h ../include/var.h
mod_facl.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_facl.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_facl.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_facl.o: ../include/tpl.h
mod_facts.o: ../include/conf.h ../include/version.h ../config.h
mod_facts.o: ../include/default_paths.h ../include/options.h
mod_facts.o: ../include/pool.h ../include/str.h ../include/table.h
mod_facts.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_facts.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_facts.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_facts.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_facts.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_facts.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_facts.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_facts.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_facts.o: ../include/parser.h ../include/xferlog.h ../include/scoreboard.h
mod_facts.o: ../include/data.h ../include/display.h ../include/libsupp.h
mod_facts.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_facts.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_facts.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_facts.o: ../include/encode.h ../include/compat.h ../include/proctitle.h
mod_facts.o: ../include/pidfile.h ../include/env.h ../include/pr-syslog.h
mod_facts.o: ../include/memcache.h ../include/tpl.h ../include/privs.h
mod_ident.o: ../include/conf.h ../include/version.h ../config.h
mod_ident.o: ../include/default_paths.h ../include/options.h
mod_ident.o: ../include/pool.h ../include/str.h ../include/table.h
mod_ident.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_ident.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_ident.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_ident.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_ident.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_ident.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_ident.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_ident.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_ident.o: ../include/parser.h ../include/xferlog.h ../include/scoreboard.h
mod_ident.o: ../include/data.h ../include/display.h ../include/libsupp.h
mod_ident.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_ident.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_ident.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_ident.o: ../include/encode.h ../include/compat.h ../include/proctitle.h
mod_ident.o: ../include/pidfile.h ../include/env.h ../include/pr-syslog.h
mod_ident.o: ../include/memcache.h ../include/tpl.h
mod_lang.o: ../include/conf.h ../include/version.h ../config.h
mod_lang.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_lang.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_lang.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_lang.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_lang.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_lang.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_lang.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_lang.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_lang.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_lang.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_lang.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_lang.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_lang.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_lang.o: ../include/session.h ../include/event.h ../include/var.h
mod_lang.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_lang.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_lang.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_lang.o: ../include/tpl.h
mod_log.o: ../include/conf.h ../include/version.h ../config.h
mod_log.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_log.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_log.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_log.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_log.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_log.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_log.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_log.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_log.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_log.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_log.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_log.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_log.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_log.o: ../include/session.h ../include/event.h ../include/var.h
mod_log.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_log.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_log.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_log.o: ../include/tpl.h ../include/privs.h
mod_ls.o: ../include/conf.h ../include/version.h ../config.h
mod_ls.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_ls.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_ls.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_ls.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_ls.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_ls.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_ls.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_ls.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_ls.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_ls.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_ls.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_ls.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_ls.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_ls.o: ../include/session.h ../include/event.h ../include/var.h
mod_ls.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_ls.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_ls.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_ls.o: ../include/tpl.h
mod_memcache.o: ../include/conf.h ../include/version.h ../config.h
mod_memcache.o: ../include/default_paths.h ../include/options.h
mod_memcache.o: ../include/pool.h ../include/str.h ../include/table.h
mod_memcache.o: ../include/proftpd.h ../include/class.h ../include/netacl.h
mod_memcache.o: ../include/support.h ../include/sets.h ../include/dirtree.h
mod_memcache.o: ../include/expr.h ../include/filter.h ../include/netio.h
mod_memcache.o: ../include/modules.h ../include/regexp.h ../include/stash.h
mod_memcache.o: ../include/auth.h ../include/response.h ../include/timers.h
mod_memcache.o: ../include/inet.h ../include/child.h ../include/netaddr.h
mod_memcache.o: ../include/cmd.h ../include/bindings.h ../include/help.h
mod_memcache.o: ../include/feat.h ../include/ftp.h ../include/log.h
mod_memcache.o: ../include/parser.h ../include/xferlog.h
mod_memcache.o: ../include/scoreboard.h ../include/data.h
mod_memcache.o: ../include/display.h ../include/libsupp.h
mod_memcache.o: ../include/glibc-glob.h ../include/fsio.h ../include/mkhome.h
mod_memcache.o: ../include/ctrls.h ../include/session.h ../include/event.h
mod_memcache.o: ../include/var.h ../include/throttle.h ../include/trace.h
mod_memcache.o: ../include/encode.h ../include/compat.h
mod_memcache.o: ../include/proctitle.h ../include/pidfile.h ../include/env.h
mod_memcache.o: ../include/pr-syslog.h ../include/memcache.h ../include/tpl.h
mod_memcache.o: ../include/privs.h
mod_site.o: ../include/conf.h ../include/version.h ../config.h
mod_site.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_site.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_site.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_site.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_site.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_site.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_site.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_site.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_site.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_site.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_site.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_site.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_site.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_site.o: ../include/session.h ../include/event.h ../include/var.h
mod_site.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_site.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_site.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_site.o: ../include/tpl.h
mod_xfer.o: ../include/conf.h ../include/version.h ../config.h
mod_xfer.o: ../include/default_paths.h ../include/options.h ../include/pool.h
mod_xfer.o: ../include/str.h ../include/table.h ../include/proftpd.h
mod_xfer.o: ../include/class.h ../include/netacl.h ../include/support.h
mod_xfer.o: ../include/sets.h ../include/dirtree.h ../include/expr.h
mod_xfer.o: ../include/filter.h ../include/netio.h ../include/modules.h
mod_xfer.o: ../include/regexp.h ../include/stash.h ../include/auth.h
mod_xfer.o: ../include/response.h ../include/timers.h ../include/inet.h
mod_xfer.o: ../include/child.h ../include/netaddr.h ../include/cmd.h
mod_xfer.o: ../include/bindings.h ../include/help.h ../include/feat.h
mod_xfer.o: ../include/ftp.h ../include/log.h ../include/parser.h
mod_xfer.o: ../include/xferlog.h ../include/scoreboard.h ../include/data.h
mod_xfer.o: ../include/display.h ../include/libsupp.h ../include/glibc-glob.h
mod_xfer.o: ../include/fsio.h ../include/mkhome.h ../include/ctrls.h
mod_xfer.o: ../include/session.h ../include/event.h ../include/var.h
mod_xfer.o: ../include/throttle.h ../include/trace.h ../include/encode.h
mod_xfer.o: ../include/compat.h ../include/proctitle.h ../include/pidfile.h
mod_xfer.o: ../include/env.h ../include/pr-syslog.h ../include/memcache.h
mod_xfer.o: ../include/tpl.h ../include/privs.h
