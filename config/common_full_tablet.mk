# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/mica/config/common_mobile.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/mica/config/tablet.mk)

$(call inherit-product, vendor/mica/config/telephony.mk)
