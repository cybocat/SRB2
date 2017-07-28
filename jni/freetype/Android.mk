LOCAL_PATH := $(call my-dir)
SDL_LOCAL_PATH := /cygdrive/c/andy/doom/doom-android-read-only/project/jni/sdl/include


include $(CLEAR_VARS)

LOCAL_MODULE := freetype

APP_SUBDIRS := $(patsubst $(LOCAL_PATH)/%, %, $(shell find $(LOCAL_PATH)/src -type d))

LOCAL_C_INCLUDES := 	$(LOCAL_PATH)/include \
			$(foreach D, $(APP_SUBDIRS), $(LOCAL_PATH)/$(D)) 



LOCAL_CFLAGS :=  -DFT2_BUILD_LIBRARY


LOCAL_CPP_EXTENSION := .cpp

LOCAL_SRC_FILES := $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.cpp))))
LOCAL_SRC_FILES += $(foreach F, $(APP_SUBDIRS), $(addprefix $(F)/,$(notdir $(wildcard $(LOCAL_PATH)/$(F)/*.c))))

LOCAL_SHARED_LIBRARIES := 

LOCAL_STATIC_LIBRARIES := 

LOCAL_LDLIBS :=

include $(BUILD_STATIC_LIBRARY)
