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

media_mux_mod_srcs += src/muxer.cpp

media_mux_mod_cpp_incs := .
media_mux_mod_cpp_incs += inc
media_mux_mod_cpp_incs += $(project_root)/routines/prebuild/ffmpeg-2.7.2/$(PLATFORM)/$(CPU_ARCH)/include
