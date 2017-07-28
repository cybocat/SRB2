LOCAL_PATH := $(call my-dir)
SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include

include $(CLEAR_VARS)

LOCAL_MODULE := sdl_image

LOCAL_CFLAGS := -I$(LOCAL_PATH) -I$(LOCAL_PATH)/../jpeg -I$(LOCAL_PATH)/../png -I$(LOCAL_PATH)/../sdl/include \
				-DLOAD_PNG -DLOAD_JPG -DLOAD_GIF -DLOAD_BMP

LOCAL_C_INCLUDES := 	$(SDL_LOCAL_PATH) \
				$(LOCAL_PATH)/../png \
				$(LOCAL_PATH)/../jpeg \
				$(LOCAL_PATH)/../intl \

LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c))

LOCAL_STATIC_LIBRARIES := png jpeg

LOCAL_SHARED_LIBRARIES := sdl

LOCAL_LDLIBS := -lz

include $(BUILD_SHARED_LIBRARY)

