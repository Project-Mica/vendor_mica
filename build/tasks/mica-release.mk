# Copyright (C) 2017 Unlegacy-Android
# Copyright (C) 2017,2020 The LineageOS Project
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

# -----------------------------------------------------------------
# MicaOS OTA update package

MICA_TARGET_PACKAGE := $(PRODUCT_OUT)/MicaOS-$(MICA_VERSION).zip
MICA_TARGET_UPDATEPACKAGE := $(PRODUCT_OUT)/MicaOS-$(MICA_VERSION)-img.zip
MICA_BUILD_TIME := 

MD5 := prebuilts/build-tools/path/$(HOST_PREBUILT_TAG)/md5sum

.PHONY: mica-release
mica-release: $(DEFAULT_GOAL) $(INTERNAL_OTA_PACKAGE_TARGET) $(INTERNAL_UPDATE_PACKAGE_TARGET)
	$(hide) ln -f $(INTERNAL_OTA_PACKAGE_TARGET) $(MICA_TARGET_PACKAGE)
	$(hide) $(MD5) $(MICA_TARGET_PACKAGE) > $(MICA_TARGET_PACKAGE).md5sum
	$(hide) source ./vendor/mica/build/tools/generate_json_build_info.sh $(MICA_TARGET_PACKAGE)
	$(hide) ln -f $(INTERNAL_UPDATE_PACKAGE_TARGET) $(MICA_TARGET_UPDATEPACKAGE)
	$(hide) $(MD5) $(MICA_TARGET_UPDATEPACKAGE) > $(MICA_TARGET_UPDATEPACKAGE).md5sum
	@echo -e ${C								                         "${CL_BLU}
	@echo -e ${CL_BLU}"                                                                              "${CL_BLU}
	@echo -e ${CL_CYN}"=============================-OTA Package Details-============================"${CL_RST}
	@echo -e ${CL_CYN}"OutputZip      : "${CL_MAG} $(MICA_TARGET_PACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"MD5            : "${CL_MAG}" $(shell cat $(MICA_TARGET_PACKAGE).md5sum | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size           : "${CL_MAG}" $(shell du -hs $(MICA_TARGET_PACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size(in bytes) : "${CL_MAG}" $(shell wc -c $(MICA_TARGET_PACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Build Type     : "${CL_MAG} $(MICA_BUILD_TYPE)${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
	@echo -e ${CL_CYN}"============================-Fastboot Package Details-=============================="${CL_RST}
	@echo -e ${CL_CYN}"OutputZip      : "${CL_MAG} $(MICA_TARGET_UPDATEPACKAGE)${CL_RST}
	@echo -e ${CL_CYN}"MD5            : "${CL_MAG}" $(shell cat $(MICA_TARGET_UPDATEPACKAGE).md5sum | awk '{print $$1}')"${CL_RST} 
	@echo -e ${CL_CYN}"Size           : "${CL_MAG}" $(shell du -hs $(MICA_TARGET_UPDATEPACKAGE) | awk '{print $$1}')"${CL_RST}
	@echo -e ${CL_CYN}"Size(in bytes) : "${CL_MAG}" $(shell wc -c $(MICA_TARGET_UPDATEPACKAGE) | awk '{print $$1}')"${CL_RST} 
	@echo -e ${CL_CYN}"Build Type     : "${CL_MAG} $(MICA_BUILD_TYPE)${CL_RST}
	@echo -e ${CL_CYN}"==========================================================================="${CL_RST}
	@echo -e ""
