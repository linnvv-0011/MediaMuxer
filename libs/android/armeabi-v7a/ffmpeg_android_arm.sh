#!/bin/bash

#----------------------------------------------------------------------
# common and android toolchain definition
#----------------------------------------------------------------------
ANDROID_SRC=`pwd`/ffmpeg-2.7.2
ANDROID_OUT=`pwd`/build/arm

ANDROID_TOOLCHAIN=/home/linux1/workspace/tools/toolchain/arm
SYSROOT=/home/linux1/workspace/tools/toolchain/arm/sysroot/

export PATH=$ANDROID_TOOLCHAIN/bin:$PATH

#----------------------------------------------------------------------
# configuration flags.
#----------------------------------------------------------------------
CFLAGS="-O3 -Wall -mthumb -pipe -fpic -fasm 			\
		-finline-limit=300 -ffast-math 					\
		-fstrict-aliasing -Werror=strict-aliasing 		\
		-fmodulo-sched -fmodulo-sched-allow-regmoves	\
		-Wno-psabi -Wa,--noexecstack 					\
		-DANDROID -DNDEBUG"

FFMPEG_FLAGS="--target-os=linux 						\
			  --arch=arm 								\
			  --enable-cross-compile 					\
			  --cross-prefix=arm-linux-androideabi- 	\
			  --sysroot=$SYSROOT						\
			  --enable-static							\
			  --disable-shared							\
			  --enable-gpl								\
			  --enable-version3							\
			  --disable-programs						\
			  --disable-ffplay 							\
			  --disable-ffprobe							\
			  --disable-ffserver						\
			  --enable-ffmpeg							\
			  --disable-doc								\
			  --disable-txtpages						\
			  --disable-htmlpages						\
			  --disable-manpages						\
			  --disable-podpages						\
			  --enable-network							\
			  --enable-avdevice 						\
			  --enable-avfilter 						\
			  --enable-avresample 						\
			  --enable-swresample 						\
			  --enable-decoders 						\
			  --enable-encoders 						\
			  --enable-hwaccels							\
			  --enable-muxers							\
			  --enable-demuxers							\
			  --enable-parsers							\
			  --enable-filters							\
			  --enable-protocols						\
			  --prefix=$ANDROID_OUT"					


EXTRA_CFLAGS="-march=armv7-a -mfpu=neon -mfloat-abi=softfp -mvectorize-with-neon-quad"
EXTRA_LDFLAGS="-Wl,--fix-cortex-a8"

#----------------------------------------------------------------------
# delete previous build and create new.
#----------------------------------------------------------------------
if [ -d $ANDROID_OUT ]; then
	rm -rf $ANDROID_OUT
fi
mkdir -p $ANDROID_OUT
  
#----------------------------------------------------------------------
# config & build
#----------------------------------------------------------------------
cd $ANDROID_SRC

./configure $FFMPEG_FLAGS --extra-cflags="$CFLAGS $EXTRA_CFLAGS" --extra-ldflags="$EXTRA_LDFLAGS" | tee $ANDROID_OUT/configuration.txt
cp config.* $ANDROID_OUT

make clean
make -j4 || exit 1
make install || exit 1

