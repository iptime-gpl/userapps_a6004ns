./configure --host=arm-uclibc-linux --target=arm-uclibc-linux --build=i686-pc-linux \
	--prefix=/home/bcmac/userapps/nasapp \
	CFLAGS="-g -O2 -DEFM_ITUNES105_PATCH -I${RootDir}/include -I/home/bcmac/userapps/nasapp/source/libid3tag-0.15.0b/ -I/home/bcmac/userapps/nasapp/source/gdbm-1.8.3" \
	LDFLAGS="-L/home/bcmac/userapps/nasapp/source/libid3tag-0.15.0b/.libs -L/home/bcmac/userapps/nasapp/source/gdbm-1.8.3/.libs -lpthread -lgdbm -lid3tag -lz" \

sed 's/\/\* #undef SETPGRP_VOID \*\//#define SETPGRP_VOID 1/' config.h > config.1
mv config.1 config.h
