# Inherit common mobile Mica stuff
$(call inherit-product, vendor/mica/config/common.mk)

# Apps
PRODUCT_PACKAGES += \
    AvatarPicker \
    LatinIME

# Charger
PRODUCT_PACKAGES += \
    product_charger_res_images

# New charging information
PRODUCT_PRODUCT_PROPERTIES += \
    charging_string.apply_lotx=true \
    charging_string.apply_v2=true

# Media
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    media.recorder.show_manufacturer_and_model=true

# SystemUI plugins
PRODUCT_PACKAGES += \
    QuickAccessWallet

# TextClassifier
PRODUCT_PACKAGES += \
    libtextclassifier_annotator_en_model \
    libtextclassifier_annotator_universal_model \
    libtextclassifier_actions_suggestions_universal_model \
    libtextclassifier_lang_id_model

PRODUCT_ARTIFACT_PATH_REQUIREMENT_ALLOWED_LIST += \
    system/etc/textclassifier/actions_suggestions.universal.model \
    system/etc/textclassifier/lang_id.model \
    system/etc/textclassifier/textclassifier.en.model \
    system/etc/textclassifier/textclassifier.universal.model

# Themes
PRODUCT_PACKAGES += \
    ThemePicker \
    ThemesStub
