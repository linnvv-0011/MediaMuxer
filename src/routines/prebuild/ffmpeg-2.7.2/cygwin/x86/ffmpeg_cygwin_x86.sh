#!/bin/bash

#----------------------------------------------------------------------
# common and android toolchain definition
#----------------------------------------------------------------------
SRC_DIR=`pwd`/ffmpeg-2.7.2
OUT_DIR=`pwd`/build/x86

#SYSROOT=/c/TDM-GCC-32

#----------------------------------------------------------------------
# configuration flags.
#----------------------------------------------------------------------
FFMPEG_FLAGS="--enable-static							\
			  --disable-shared							\
			  --enable-gpl								\
			  --enable-version3							\
			  --enable-w32threads						\
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
			  --prefix=$OUT_DIR"	
			  		  


#----------------------------------------------------------------------
# delete previous build and create new.
#----------------------------------------------------------------------
if [ -d $OUT_DIR ]; then
	rm -rf $OUT_DIR
fi
mkdir -p $OUT_DIR
  
#----------------------------------------------------------------------
# config & build
#----------------------------------------------------------------------
cd $SRC_DIR

./configure $FFMPEG_FLAGS | tee $OUT_DIR/configuration.txt
cp config.* $OUT_DIR

make clean
make -j4 || exit 1
make install || exit 1
