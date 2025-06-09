# Inherit mobile full common Lineage stuff
$(call inherit-product, vendor/mica/config/common_mobile_full.mk)

# Inherit tablet common Lineage stuff
$(call inherit-product, vendor/mica/config/tablet.mk)

$(call inherit-product, vendor/mica/config/telephony.mk)
