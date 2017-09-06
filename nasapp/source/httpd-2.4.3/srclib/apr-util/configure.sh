CROSS_COMPILE=arm-mv5sft-linux-gnueabi

./configure --host=${CROSS_COMPILE} --target=${CROSS_COMPILE} --build=i686-pc-linux \
		   CC=${CROSS_COMPILE}-gcc \
		   --with-apr=${TOP_SRC}/apr-1.4.6/install \
		   --prefix=`pwd`/install \
