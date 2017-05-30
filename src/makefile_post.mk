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

# -----------------------------------------------------------------------------------------
media_mux_mod_tsrcs			:= $(addprefix $(MEDIA_MUX_OUT_OBJ_DIR)/$(media_mux_mod_lib_name)/, $(media_mux_mod_srcs))
media_mux_mod_csrcs			:= $(filter %.c, $(media_mux_mod_tsrcs))
media_mux_mod_cppsrcs		:= $(filter %.cpp, $(media_mux_mod_tsrcs))

media_mux_mod_cobjs			:= $(media_mux_mod_csrcs:%.c=%.o)
media_mux_mod_cppobjs		:= $(media_mux_mod_cppsrcs:%.cpp=%.o)

# -----------------------------------------------------------------------------------------
media_mux_mod_out_lib_name	:= $(MEDIA_MUX_OUT_LIB_DIR)/lib$(media_mux_mod_lib_name).a

# -----------------------------------------------------------------------------------------
media_mux_mod_out_dir_names	:= $(dir $(media_mux_mod_out_lib_name))
media_mux_mod_out_dir_names	+= $(dir $(media_mux_mod_cobjs))
media_mux_mod_out_dir_names	+= $(dir $(media_mux_mod_cppobjs))
media_mux_mod_out_dir_names	:= $(shell echo $(media_mux_mod_out_dir_names) | sed 's/ /\n/g' | sort -u)


# -----------------------------------------------------------------------------------------
# set platform flags
ifeq ($(PLATFORM), android)
media_mux_mod_c99_flags		+= -D__ANDROID__ 
media_mux_mod_cpp_flags		+= -D__ANDROID__ 
endif
ifeq ($(PLATFORM), cygwin)
media_mux_mod_c99_flags		+= -D__UNIX_LIKE__ 
media_mux_mod_cpp_flags		+= -D__UNIX_LIKE__ 
endif
ifeq ($(CPU_ARCH), x86)
media_mux_mod_c99_flags		+= -D__X86__
media_mux_mod_cpp_flags     += -D__X86__
endif
ifeq ($(CPU_ARCH), armeabi-v7a)
media_mux_mod_c99_flags		+= -D__ARMEABI_V7A__
media_mux_mod_cpp_flags     += -D__ARMEABI_V7A__
endif

# set included directories flags
media_mux_mod_c99_flags		+= $(addprefix -I, $(media_mux_mod_c99_incs))
media_mux_mod_cpp_flags		+= $(addprefix -I, $(media_mux_mod_cpp_incs))

# -----------------------------------------------------------------------------------------
$(media_mux_mod_out_lib_name) : $(media_mux_mod_out_dir_names) $(media_mux_mod_cobjs) $(media_mux_mod_cppobjs)
	@rm -f $@
	$(MEDIA_MUX_TOOL_CHAIN_AR) -rs -o $@ $(filter %.o, $^ )

$(media_mux_mod_out_dir_names) :
	@mkdir -p $@

# -----------------------------------------------------------------------------------------
$(media_mux_mod_cobjs) : $(MEDIA_MUX_OUT_OBJ_DIR)/$(media_mux_mod_lib_name)/%.o : %.c
	$(MEDIA_MUX_TOOL_CHAIN_C99) $(media_mux_mod_c99_flags) -o $@ $^

$(media_mux_mod_cppobjs) : $(MEDIA_MUX_OUT_OBJ_DIR)/$(media_mux_mod_lib_name)/%.o : %.cpp
	$(MEDIA_MUX_TOOL_CHAIN_CPP) $(media_mux_mod_cpp_flags) -o $@ $^

