# Inherit mobile mini common Lineage stuff
$(call inherit-product, vendor/mica/config/common_mobile_mini.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/mica/config/tablet.mk)

$(call inherit-product, vendor/mica/config/wifionly.mk)
