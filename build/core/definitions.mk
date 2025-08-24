#
# Lineage-specific macros
#
define uniq
$(if $1,$(firstword $1) $(call uniq,$(filter-out $(firstword $1),$1)))
endef

# Include board/platform macros
include vendor/mica/build/core/utils.mk

# Include default installed modules
include vendor/mica/build/core/default_installed_modules.mk
