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

include makefile_head.mk

# -----------------------------------------------------------
# uvc modules definition
media_mux_modules := muxer

# -----------------------------------------------------------
# uvc libraries comes from uvc modules
media_mux_libraries := $(addprefix lib, $(media_mux_modules))
media_mux_libraries := $(addsuffix .a,  $(media_mux_libraries))

# -----------------------------------------------------------
# the finally generated shared library
media_mux_binary_so := libmedia_mux.so

# -----------------------------------------------------------
# linked flags, generated
MEDIA_MUX_LD_FLAGS := -L_out/lib
MEDIA_MUX_LD_LIBS  += $(addprefix -l, $(media_mux_modules))

all : _out/bin $(media_mux_binary_so)

_out/bin:
	mkdir -p _out/bin

$(media_mux_binary_so) : $(media_mux_libraries)
	mkdir -p _out/bin
	$(MEDIA_MUX_TOOL_CHAIN_CPP) -shared -o _out/bin/$@                      \
                                $(MEDIA_MUX_LD_FLAGS) $(MEDIA_MUX_LD_LIBS)
	ls -l _out/bin/$@

$(media_mux_libraries) : lib%.a : %
	make -C $^

clean:
	rm -rf _out