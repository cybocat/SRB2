LOCAL_PATH := $(call my-dir)
SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include


include $(CLEAR_VARS)

APP_SUBDIRS := $(patsubst $(LOCAL_PATH)/%, %, $(shell find $(LOCAL_PATH) -type d))

LOCAL_C_INCLUDES := 	$(LOCAL_PATH)/../stlport/stlport \
				$(SDL_LOCAL_PATH) \
				$(LOCAL_PATH)/../sdl_mixer \
				$(LOCAL_PATH)/../sdl_image \
				$(LOCAL_PATH)/../sdl_ttf \
				$(LOCAL_PATH)/include \


LOCAL_CFLAGS := $(foreach D, $(APP_SUBDIRS), \
-I$(LOCAL_PATH)/$(D)) \
				



LOCAL_MODULE := mikmod

LOCAL_CPP_EXTENSION := .cpp

#LOCAL_SRC_FILES := $(notdir $(wildcard $(LOCAL_PATH)/*.c))

LOCAL_SRC_FILES := $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.cpp))))
# Uncomment to also add C sources
LOCAL_SRC_FILES += $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.c))))


include $(BUILD_STATIC_LIBRARY)

