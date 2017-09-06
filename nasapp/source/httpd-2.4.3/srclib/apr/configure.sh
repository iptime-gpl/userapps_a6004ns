CROSS_COMPILE=arm-mv5sft-linux-gnueabi

./configure --host=${CROSS_COMPILE} --target=${CROSS_COMPILE} --build=i686-pc-linux \
		   CC=${CROSS_COMPILE}-gcc \
		   ac_cv_file__dev_zero=yes \
		   ac_cv_func_setpgrp_void=yes \
		   apr_cv_process_shared_works=no \
		   apr_cv_tcp_nodelay_with_cork=no \
		   ac_cv_sizeof_struct_iovec=8 \
		   apr_cv_mutex_robust_shared=no \
		   apr_cv_mutex_recursive=yes \
		   --prefix=`pwd`/install \
