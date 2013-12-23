#
# Copyright (C) 2013 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# common msm8660 configs
$(call inherit-product, device/htc/msm8660-common/msm8660.mk)

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

DEVICE_PACKAGE_OVERLAYS += device/htc/rider/overlay

# GPS
PRODUCT_PACKAGES += \
    gps.rider

#LIGHT
PRODUCT_PACKAGES += lights.rider \

## The gps config appropriate for this device
PRODUCT_COPY_FILES += device/htc/rider/configs/gps.conf:system/etc/gps.conf

# Bluetooth firmware
$(call inherit-product, device/htc/msm8660-common/bcm_hcd.mk)

$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4329/device-bcm.mk)

# Boot ramdisk setup
PRODUCT_COPY_FILES += \
    device/htc/rider/ramdisk/fstab.rider:root/fstab.rider \
    device/htc/rider/ramdisk/init.rider.rc:root/init.rider.rc \
    device/htc/rider/ramdisk/init.rider.usb.rc:root/init.rider.usb.rc \
    device/htc/rider/ramdisk/ueventd.rider.rc:root/ueventd.rider.rc

## recovery and custom charging
PRODUCT_COPY_FILES += \
    device/htc/rider/recovery/sbin/choice_fn:recovery/root/sbin/choice_fn \
    device/htc/rider/recovery/sbin/power_test:recovery/root/sbin/power_test \
    device/htc/rider/recovery/sbin/offmode_charging:recovery/root/sbin/offmode_charging \
    device/htc/rider/recovery/sbin/detect_key:recovery/root/sbin/detect_key \
    device/htc/rider/recovery/sbin/htcbatt:recovery/root/sbin/htcbatt

# Some misc configuration files
PRODUCT_COPY_FILES += \
    device/htc/rider/configs/vold.fstab:system/etc/vold.fstab

# Keylayouts and Keychars
PRODUCT_COPY_FILES += \
    device/htc/rider/keychars/BT_HID.kcm.bin:system/usr/keychars/BT_HID.kcm.bin \
    device/htc/rider/keychars/qwerty.kcm.bin:system/usr/keychars/qwerty.kcm.bin \
    device/htc/rider/keychars/qwerty2.kcm.bin:system/usr/keychars/qwerty2.kcm.bin \
    device/htc/rider/keychars/rider-keypad.kcm.bin:system/usr/keychars/rider-keypad.kcm.bin \
    device/htc/rider/keylayout/atmel-touchscreen.kl:system/usr/keylayout/atmel-touchscreen.kl \
    device/htc/rider/keylayout/h2w_headset.kl:system/usr/keylayout/h2w_headset.kl \
    device/htc/rider/keylayout/rider-keypad.kl:system/usr/keylayout/rider-keypad.kl

# Input device config
PRODUCT_COPY_FILES += \
    device/htc/rider/idc/atmel-touchscreen.idc:system/usr/idc/atmel-touchscreen.idc

# HTC BT Audio tune
PRODUCT_COPY_FILES += device/htc/rider/dsp/AudioBTID.csv:system/etc/AudioBTID.csv

# Sound configs
PRODUCT_COPY_FILES += \
    device/htc/rider/dsp/AdieHWCodec.csv:system/etc/AdieHWCodec.csv \
    device/htc/rider/dsp/AIC3254_REG.csv:system/etc/AIC3254_REG.csv \
    device/htc/rider/dsp/AIC3254_REG_DualMic.csv:system/etc/AIC3254_REG_DualMic.csv \
    device/htc/rider/dsp/CodecDSPID.txt:system/etc/CodecDSPID.txt \
    device/htc/rider/dsp/TPA2051_CFG.csv:system/etc/TPA2051_CFG.csv \
    device/htc/rider/dsp/soundimage/Sound_FM_HP.txt:system/etc/soundimage/Sound_FM_HP.txt \
    device/htc/rider/dsp/soundimage/Sound_FM_SPK.txt:system/etc/soundimage/Sound_FM_SPK.txt \
    device/htc/rider/dsp/soundimage/Sound_Original.txt:system/etc/soundimage/Sound_Original.txt \
    device/htc/rider/dsp/soundimage/Sound_Original_MFG.txt:system/etc/soundimage/Sound_Original_MFG.txt \
    device/htc/rider/dsp/soundimage/Sound_Original_Recording.txt:system/etc/soundimage/Sound_Original_Recording.txt \
    device/htc/rider/dsp/soundimage/Sound_Original_SPK.txt:system/etc/soundimage/Sound_Original_SPK.txt \
    device/htc/rider/dsp/soundimage/Sound_Phone_Original.txt:system/etc/soundimage/Sound_Phone_Original.txt \
    device/htc/rider/dsp/soundimage/Sound_Phone_Original_HP.txt:system/etc/soundimage/Sound_Phone_Original_HP.txt \
    device/htc/rider/dsp/soundimage/Sound_Phone_Original_REC.txt:system/etc/soundimage/Sound_Phone_Original_REC.txt \
    device/htc/rider/dsp/soundimage/Sound_Phone_Original_SPK.txt:system/etc/soundimage/Sound_Phone_Original_SPK.txt \
    device/htc/rider/dsp/soundimage/Sound_Rec_Landscape.txt:system/etc/soundimage/Sound_Rec_Landscape.txt \
    device/htc/rider/dsp/soundimage/Sound_Rec_mono.txt:system/etc/soundimage/Sound_Rec_mono.txt \
    device/htc/rider/dsp/soundimage/Sound_Recording.txt:system/etc/soundimage/Sound_Recording.txt \
    device/htc/rider/dsp/soundimage/Sound_Rec_Portrait.txt:system/etc/soundimage/Sound_Rec_Portrait.txt \
    device/htc/rider/dsp/soundimage/Sound_Rec_Voice_record.txt:system/etc/soundimage/Sound_Rec_Voice_record.txt \
    device/htc/rider/dsp/soundimage/srsfx_trumedia_51.cfg:system/etc/soundimage/srsfx_trumedia_51.cfg \
    device/htc/rider/dsp/soundimage/srsfx_trumedia_movie.cfg:system/etc/soundimage/srsfx_trumedia_movie.cfg \
    device/htc/rider/dsp/soundimage/srsfx_trumedia_music.cfg:system/etc/soundimage/srsfx_trumedia_music.cfg \
    device/htc/rider/dsp/soundimage/srs_geq10.cfg:system/etc/soundimage/srs_geq10.cfg

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml

# Adreno Drivers
PRODUCT_COPY_FILES += \
    device/htc/rider/firmware/a225_pfp.fw:system/etc/firmware/a225_pfp.fw \
    device/htc/rider/firmware/a225_pm4.fw:system/etc/firmware/a225_pm4.fw \
    device/htc/rider/firmware/a225p5_pm4.fw:system/etc/firmware/a225p5_pm4.fw \
    device/htc/rider/firmware/yamato_pfp.fw:system/etc/firmware/yamato_pfp.fw \
    device/htc/rider/firmware/yamato_pm4.fw:system/etc/firmware/yamato_pm4.fw 

## misc
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.enable_bypass=1 \
    dalvik.vm.lockprof.threshold=500 \
    ro.com.google.locationfeatures=1 \
    dalvik.vm.dexopt-flags=m=y

# call the proprietary setup
$(call inherit-product-if-exists, vendor/htc/rider/rider-vendor.mk)

# media profiles and capabilities spec
$(call inherit-product, device/htc/rider/media_a1026.mk)

## htc audio settings
$(call inherit-product, device/htc/rider/media_htcaudio.mk)

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)

# Device ID
PRODUCT_NAME := full_rider
PRODUCT_DEVICE := rider
