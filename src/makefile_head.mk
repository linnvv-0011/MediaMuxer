# -----------------------------------------------------------------------------------------
# This library is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
#
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the GNU Lesser General Public License for more details.
#
# This file should not be modified generally.
#
# Copyright (c) 2015-2016, linnvv_0011@163.com  All rights reserved.
# -----------------------------------------------------------------------------------------

# ------------------------------------------------------------------------
# platform releated definitions
PLATFORM 	:= android
#PLATFORM 	:= cygwin

#CPU_ARCH 	:= x86
CPU_ARCH 	:= armeabi-v7a

# ------------------------------------------------------------------------
# define some necessary output directories, such as output library directory etc.
MEDIA_MUX_OUT_DEP_DIR			:= $(project_root)/_out/dep
MEDIA_MUX_OUT_OBJ_DIR			:= $(project_root)/_out/obj
MEDIA_MUX_OUT_LIB_DIR			:= $(project_root)/_out/lib
MEDIA_MUX_OUT_BIN_DIR			:= $(project_root)/_out/bin

# ------------------------------------------------------------------------
# about toolchain, flags, etc. 
ifeq ($(PLATFORM), android)
ifndef ANDROID_TOOL_CHAIN_PATH
	tmp := $(error "ANDROID_TOOL_CHAIN_PATH not defined, must defined this path")
endif
ifeq ($(CPU_ARCH), armeabi-v7a)
MEDIA_MUX_TOOL_CHAIN_PREFIX		:= $(ANDROID_TOOL_CHAIN_PATH)/arm/bin/arm-linux-androideabi-
else
	tmp := $(error "$(PLATFORM) $(CPU_ARCH) not supported")
endif
endif

MEDIA_MUX_TOOL_CHAIN_C99 		:= $(MEDIA_MUX_TOOL_CHAIN_PREFIX)gcc
MEDIA_MUX_TOOL_CHAIN_CPP		:= $(MEDIA_MUX_TOOL_CHAIN_PREFIX)g++
MEDIA_MUX_TOOL_CHAIN_AR			:= $(MEDIA_MUX_TOOL_CHAIN_PREFIX)ar
MEDIA_MUX_TOOL_CHAIN_STRIP 		:= $(MEDIA_MUX_TOOL_CHAIN_PREFIX)strip

media_mux_tool_chain_c99_flags	:= -std=c99 -c -g -O2 -Wall -Wmissing-declarations
media_mux_tool_chain_cpp_flags	:= -std=c++0x -c -g -O2 -Wall -Wmissing-declarations

media_mux_tool_chain_ld_flags	:= --shared
media_mux_tool_chain_ar_flags	:= -rs