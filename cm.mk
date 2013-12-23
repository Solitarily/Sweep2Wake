# Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := rider

# Bootanimation
TARGET_SCREEN_HEIGHT := 960
TARGET_SCREEN_WIDTH := 540

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/htc/rider/device_rider.mk)

# Device naming
PRODUCT_DEVICE := rider
PRODUCT_NAME := cm_rider
PRODUCT_BRAND := htc
PRODUCT_MODEL := HTC X515E
PRODUCT_MANUFACTURER := HTC

# Set build fingerprint / ID / Product Name ect.
PRODUCT_BUILD_PROP_OVERRIDES += PRODUCT_NAME=htc_rider BUILD_FINGERPRINT=tmous/htc_rider/rider:4.0.3/IML74K/356011.14:user/release-keys PRIVATE_BUILD_DESC="3.32.531.14 CL356011 release-keys" BUILD_NUMBER=356011
