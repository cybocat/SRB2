

LOCAL_PATH := $(call my-dir)

SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include

include $(CLEAR_VARS)

LOCAL_MODULE := sdl_mixer

LOCAL_C_INCLUDES := 	$(SDL_LOCAL_PATH) \
				$(LOCAL_PATH) \
				$(LOCAL_PATH)/.. \
				$(LOCAL_PATH)/../mad \
				$(LOCAL_PATH)/../mikmod/include

LOCAL_CFLAGS :=   -DWAV_MUSIC -DOGG_USE_TREMOR -DOGG_MUSIC  -DMOD_MUSIC

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c))

LOCAL_SHARED_LIBRARIES := sdl
LOCAL_STATIC_LIBRARIES := tremor mikmod

ifneq ($(SDL_MIXER_USE_LIBMAD),)
	LOCAL_CFLAGS += -DMP3_MAD_MUSIC
	LOCAL_SHARED_LIBRARIES += mad
endif

include $(BUILD_SHARED_LIBRARY)