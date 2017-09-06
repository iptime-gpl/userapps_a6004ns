SOURCE_PATH=/home/`whoami`/MarvellNas/source
CROSS_COMPILE=arm-mv5sft-linux-gnueabi
ToolChainPrefix="/opt/sdk/targets/arm-mv5sft-linux-gnueabi/cross/bin/arm-mv5sft-linux-gnueabi-"
ToolChainBin="/opt/sdk/targets/arm-mv5sft-linux-gnueabi/cross/bin/"
ToolChainInclude="/opt/sdk/targets/arm-mv5sft-linux-gnueabi/cross/arm-mv5sft-linux-gnueabi/sys-root/usr/include"
ToolChainLib="/opt/sdk/targets/arm-mv5sft-linux-gnueabi/cross/arm-mv5sft-linux-gnueabi/sys-root/usr/lib"

./configure --host=${CROSS_COMPILE} --target=${CROSS_COMPILE} --build=i686-pc-linux \
		   CC=${CROSS_COMPILE}-gcc \
		   CPPFLAGS="-I`pwd`/include -I${TOP_ROOT}/include -I`pwd`/srclib/apr/include -I`pwd`/srclib/apr-util/include -I${ToolChainInclude}" \
		   LDFLAGS="-L${TOP_ROOT}/lib -L`pwd`/srclib/apr/.libs -L`pwd`/srclib/apr-util/.libs -L${ToolChainLib} -lpthread" \
		   --with-included-apr=static \
		   --with-pcre=${TOP_ROOT} \
		   ac_cv_file__dev_zero=yes \
		   ac_cv_func_setpgrp_void=yes \
		   apr_cv_process_shared_works=no \
		   apr_cv_tcp_nodelay_with_cork=no \
		   ac_cv_sizeof_struct_iovec=8 \
		   apr_cv_mutex_robust_shared=no \
		   apr_cv_mutex_recursive=yes \
		   --enable-modules=most \
		   --enable-ssl \
		   --enable-session \
		   --enable-session-cookie \
		   --enable-log-debug \
		   --with-mpm=prefork \
		   --enable-mpms-shared=all \
		   --enable-unixd \
		   --enable-so \
		   --enable-auth-form \
		   --enable-auth-digest \
		   --with-libxml2=${TOP_ROOT} \
