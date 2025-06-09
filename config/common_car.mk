# Inherit common Lineage stuff
$(call inherit-product, vendor/mica/config/common.mk)

# Inherit Lineage car device tree
$(call inherit-product, device/mica/car/mica_car.mk)
