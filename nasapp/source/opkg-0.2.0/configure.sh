SOURCE_PATH=/home/`whoami`/MarvellNas/source
CROSS_COMPILE=arm-mv5sft-linux-gnueabi

./configure --host=${CROSS_COMPILE} --target=${CROSS_COMPILE} --build=i686-pc-linux \
		   PKG_CONFIG_PATH=${TOP_ROOT}/lib/pkgconfig \
		   CPPFLAGS="-I${TOP_ROOT}/include" \
		   CFLAGS="-DEFM_PATCH" \
		   LDFLAGS="-L${TOP_ROOT}/lib -L${TOP_SRC}/base-devel.v2/efmlib/src -L${TOP_SRC}/glib-1.2.10/.libs" \
		   LIBS="-lefm -lglib" \
		   --enable-static=yes \
		   --enable-shared=no \
		   --enable-gpg=no \
		   --enable-ssl-curl=no \
		   --with-opkglockfile=/var/run/opkg.lock \
		   --prefix=`pwd`/install
