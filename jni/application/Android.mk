
LOCAL_PATH := $(call my-dir)

SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include


include $(CLEAR_VARS)

LOCAL_MODULE := application

APP_SUBDIRS := $(patsubst $(LOCAL_PATH)/%, %, $(shell find $(LOCAL_PATH)/doom -type d))
ifneq ($(APPLICATION_SUBDIRS_BUILD),)
APP_SUBDIRS := $(APPLICATION_SUBDIRS_BUILD)
endif

LOCAL_CFLAGS :=  -DOGG_MUSIC -DOGG_USE_TREMOR -DHAVE_LIBSDL_MIXER -DUSE_SDL_MIXER 

LOCAL_C_INCLUDES := 	$(LOCAL_PATH)/../stlport/stlport \
				$(SDL_LOCAL_PATH) \
				$(LOCAL_PATH)/../sdl_mixer \
				$(LOCAL_PATH)/../sdl_image \
				$(LOCAL_PATH)/../sdl_ttf \
				$(LOCAL_PATH)/../sdl_net \
				$(LOCAL_PATH)/../sdl_blitpool \
				$(LOCAL_PATH)/../sdl_gfx \
				$(LOCAL_PATH)/../png \
				$(LOCAL_PATH)/../jpeg \
				$(LOCAL_PATH)/../intl \
				$(LOCAL_PATH)/../freetype/include \
				$(LOCAL_PATH)/..

ifeq ($(CRYSTAX_TOOLCHAIN),)
# Paths should be on newline so launchConfigure.sh will work properly
endif

# Paths should be on newline so launchConfigure.sh will work properly
LOCAL_CFLAGS += \
				$(foreach D, $(APP_SUBDIRS), -I$(LOCAL_PATH)/$(D)) \


LOCAL_CFLAGS += $(APPLICATION_ADDITIONAL_CFLAGS) -DNORMALUNIX -DLINUX -DHAVE_CONFIG_H -DHAVE_MIXER

#Change C++ file extension as appropriate
LOCAL_CPP_EXTENSION := .cpp

#LOCAL_SRC_FILES := $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.cpp))))
# Uncomment to also add C sources
#LOCAL_SRC_FILES += $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.c))))
COMMON_SRC = am_map.c\
d_client.c\
d_deh.c\
d_items.c\
d_main.c\
doomdef.c\
doomstat.c\
dstrings.c\
f_finale.c\
f_wipe.c\
g_game.c\
hu_lib.c\
hu_stuff.c\
info.c\
i_joy.c\
i_main.c\
i_network.c\
i_sound.c\
i_sshot.c\
i_system.c\
i_video.c\
lprintf.c\
m_argv.c\
m_bbox.c\
m_cheat.c\
m_menu.c\
m_misc.c\
m_random.c\
md5.c\
Mmus2mid.c\
p_ceilng.c\
p_checksum.c\
p_doors.c\
p_enemy.c\
p_floor.c\
p_genlin.c\
p_inter.c\
p_lights.c\
p_map.c\
p_maputl.c\
p_mobj.c\
p_plats.c\
p_pspr.c\
p_saveg.c\
p_setup.c\
p_sight.c\
p_spec.c\
p_switch.c\
p_telept.c\
p_tick.c\
p_user.c\
r_bsp.c\
r_data.c\
r_demo.c\
r_draw.c\
r_filter.c\
r_fps.c\
r_main.c\
r_patch.c\
r_plane.c\
r_segs.c\
r_segs.h\
r_sky.c\
r_things.c\
s_sound.c\
sounds.c\
st_lib.c\
st_stuff.c\
tables.c\
v_video.c\
version.c\
w_mmap.c\
w_wad.c\
wi_stuff.c\
z_bmalloc.c\
z_zone.c\





LOCAL_SRC_FILES =  $(foreach F, $(COMMON_SRC), $(addprefix doom/src/,$(F))) 
ifneq ($(APPLICATION_CUSTOM_BUILD_SCRIPT),)
LOCAL_SRC_FILES := dummy.c
endif

LOCAL_SHARED_LIBRARIES := sdl $(COMPILED_LIBRARIES)  sdl_mixer

LOCAL_STATIC_LIBRARIES := stlport doomsdl

LOCAL_LDLIBS := -lGLESv1_CM -ldl -llog -lz -lm

LOCAL_LDFLAGS := -Lobj/local/armeabi

LOCAL_LDFLAGS += $(APPLICATION_ADDITIONAL_LDFLAGS)


LIBS_WITH_LONG_SYMBOLS := $(strip $(shell \
	for f in $(LOCAL_PATH)/../../libs/armeabi/*.so ; do \
		if echo $$f | grep "libapplication[.]so" > /dev/null ; then \
			continue ; \
		fi ; \
		if [ -e "$$f" ] ; then \
			if nm -g $$f | cut -c 12- | egrep '.{128}' > /dev/null ; then \
				echo $$f | grep -o 'lib[^/]*[.]so' ; \
			fi ; \
		fi ; \
	done \
) )

ifneq "$(LIBS_WITH_LONG_SYMBOLS)" ""
$(foreach F, $(LIBS_WITH_LONG_SYMBOLS), \
$(info Library $(F): abusing symbol names are: \
$(shell nm -g $(LOCAL_PATH)/../../libs/armeabi/$(F) | cut -c 12- | egrep '.{128}' ) ) \
$(info Library $(F) contains symbol names longer than 128 bytes, \
YOUR CODE WILL DEADLOCK WITHOUT ANY WARNING when you'll access such function - \
please make this library static to avoid problems. ) )
$(error Detected libraries with too long symbol names. Remove all files under project/libs/armeabi, make these libs static, and recompile)
endif

include $(BUILD_SHARED_LIBRARY)

ifneq ($(APPLICATION_CUSTOM_BUILD_SCRIPT),)

$(info LOCAL_PATH $(LOCAL_PATH) )
$(info $(LOCAL_PATH)/src/libapplication.so )
$(info $(realpath $(LOCAL_PATH)/../../obj/local/armeabi/libapplication.so) )

LOCAL_PATH_SDL_APPLICATION := $(LOCAL_PATH)

$(LOCAL_PATH)/src/libapplication.so: $(LOCAL_PATH)/src/AndroidBuild.sh $(LOCAL_PATH)/src/AndroidAppSettings.cfg
	cd $(LOCAL_PATH_SDL_APPLICATION)/src && ./AndroidBuild.sh

# $(realpath $(LOCAL_PATH)/../../libs/armeabi/libapplication.so) \

$(realpath $(LOCAL_PATH)/../../obj/local/armeabi/libapplication.so): $(LOCAL_PATH)/src/libapplication.so OVERRIDE_CUSTOM_LIB
	cp -f $< $@
#	$(patsubst %-gcc,%-strip,$(TARGET_CC)) -g $@

.PHONY: OVERRIDE_CUSTOM_LIB

OVERRIDE_CUSTOM_LIB:

endif
