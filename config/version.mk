# Include gms by default
ifneq ($(TARGET_EXCLUDE_GMS),true)
$(call inherit-product, vendor/gms/products/gms.mk)
endif

# Versioning System
MICA_BUILD_DATETIME := $(shell date +%s)
MICA_BUILD_DATE := $(shell date -d @$(MICA_BUILD_DATETIME) +"%Y%m%d-%H%M%S")
TARGET_PRODUCT_SHORT := $(subst mica_,,$(MICA_BUILD))

MICA_BUILD_TYPE ?= OSS
MICA_BUILD_VERSION := BP3A
MICA_VERSION := $(MICA_BUILD_VERSION)-$(MICA_BUILD_TYPE)-$(TARGET_PRODUCT_SHORT)-$(MICA_BUILD_DATE)

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.mica.build.version=$(MICA_BUILD_VERSION) \
  ro.mica.build.date=$(BUILD_DATE) \
  ro.mica.buildtype=$(MICA_BUILD_TYPE) \
  ro.mica.version=$(MICA_VERSION) \
  ro.mica.device=$(MICA_BUILD) \
  ro.modversion=$(MICA_VERSION) \
  ro.mica.edition=$(MICA_EDITION)
