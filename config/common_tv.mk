# Inherit common Lineage stuff
$(call inherit-product, vendor/mica/config/common.mk)

# Include AOSP audio files
$(call inherit-product-if-exists, frameworks/base/data/sounds/AudioTv.mk)

# Inherit Lineage atv device tree
$(call inherit-product, device/mica/atv/mica_atv.mk)

# AOSP packages
PRODUCT_PACKAGES += \
    LeanbackIME

# Lineage packages
PRODUCT_PACKAGES += \
    Catapult \
    LineageCustomizer

PRODUCT_PACKAGE_OVERLAYS += vendor/mica/overlay/tv
