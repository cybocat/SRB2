LOCAL_PATH := $(call my-dir)
SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include

include $(CLEAR_VARS)

LOCAL_MODULE := sdl_gfx

LOCAL_C_INCLUDES := 	$(SDL_LOCAL_PATH) \
				$(LOCAL_PATH) \
				$(LOCAL_PATH)/.. \

LOCAL_CFLAGS := -Os

LOCAL_CPP_EXTENSION := .cpp

# Note this simple makefile var substitution, you can find even simpler examples in different Android projects
LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c))

LOCAL_SHARED_LIBRARIES := sdl

include $(BUILD_SHARED_LIBRARY)

