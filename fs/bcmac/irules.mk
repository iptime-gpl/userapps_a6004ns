include $(USERAPPS_ROOT)/config
-include $(USERAPPS_ROOT)/reg_config
include $(USERAPPS_ROOT)/rootfs/clone_info.mk
ifeq ($(USE_CUSTOM_VERSION),y)
include $(USERAPPS_ROOT)/rootfs/clones/$(TARGET)/version.mk
else
include $(USERAPPS_ROOT)/rootfs/version.mk
endif
include $(USERAPPS_ROOT)/lang_profile
include $(USERAPPS_ROOT)/rootfs/kernel_info.mk

ROOT_DIR:=root
PLUGIN_DIR:=./plugin

MODULE_SRC_DIR:=$(USERAPPS_ROOT)/bcmapp/sdk/$(BRCM_SDK_VERSION)/modules/2.6.36.4brcmarm$(if $(KERNEL_POSTFIX),.$(KERNEL_POSTFIX))
MODULE_DEST_DIR:=$(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/

STRIP:=arm-brcm-linux-uclibcgnueabi-strip


$(TARGET): target.fs image


post_targetfs:
	@echo -e "\t--->Post processing..." 
ifeq ($(USE_GET_URL),y)
	cp $(USERAPPS_ROOT)/cgi-src/$(CGI_ID)/gu.cgi $(ROOT_DIR)/cgibin
	cp $(USERAPPS_ROOT)/isysd/chkrcd $(ROOT_DIR)/bin
endif

ifeq ($(USE_APP_PLUGIN),y)
	@rm -rf $(ROOT_DIR)/sbin/wl
endif
	@rm -rf $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/usb/ipheth.ko
ifeq ($(USE_WIRELESS_CGI),y)
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/wl/wl.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/dpsta/dpsta.ko
endif
	@rm -rf $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/lib/libcrc32c.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/et/et.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/emf/emf.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/igs/igs.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/net/ctf/ctf.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/connector/cn.ko
ifeq ($(USE_ROUTER_NAS),y)
	@rm -rf $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/usb/mon/usbmon.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/usb/storage/usb-storage.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/usb/host/ehci-hcd.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/usb/host/ohci-hcd.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/usb/host/xhci-hcd.ko
	@$(STRIP) -d $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/scsi/scsi_wait_scan.ko
endif
	@rm -rf $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/scsi/scsi_wait_scan.ko
	@rm -rf $(ROOT_DIR)/lib/modules/2.6.36.4brcmarm/kernel/drivers/connector/cn.ko



ROOTFS_IMG=rootfs.lzma
CHIPSET_APP_INSTALL_DIR:=bcmapp
CLIB_DIR:=fs/bcmac/clib
IPTABLES_BIN_PATH:=$(USERAPPS_ROOT)/$(IPTABLES_DIR)/src/install/sbin
IPTABLES_BINS:=iptables xtables-multi
IPTABLES_LIB_PATH:=$(USERAPPS_ROOT)/$(IPTABLES_DIR)/src/install/lib/
IPTABLES_LIBS:=libipq.so libip4tc.so libxtables.so
TNTFS_MODULE_PATH:=$(BRCM_SDK_VERSION)/$(TNTFS_MODULE_NAME)
STRIP_OPTION:=
LDCONFIG_CMD:=/sbin/ldconfig -r $(ROOT_DIR)/default
MAKE_FS_BIANRY_CMD:=./mksquashfs $(ROOT_DIR) $(ROOTFS_IMG) -noappend -all-root


include $(USERAPPS_ROOT)/mkscripts/target.mk



# Make firmware
BOOT_BIN_PATH:=./prebuilt/boot/$(BOOT_FILE)
NVRAM_FILE:=./clones/$(TARGET)/$(NVRAM_FILENAME)
CFE_NV_IMG:=./clones/$(TARGET)/$(TARGET)_xboot.bin
TRX_NAME:=linux.trx
FIRMWARE_NAME:=a6004ns_kr_10_006.bin
FINAL_FIRMWARE_NAME:=a6004ns_ml_10_006.bin
image:
	@echo "--->Making firmware..."
	@./tools/trx -o $(TRX_NAME) prebuilt/kernel/$(KERNEL_FILENAME) $(ROOTFS_IMG);

ifneq ($(NVSERIAL),)
	@./tools/$(NVSERIAL) -i $(BOOT_BIN_PATH) $(NVSERIAL_OPT) -o $(CFE_NV_IMG) $(NVRAM_FILE)
else
	@./tools/nvserial -i $(BOOT_BIN_PATH) -o $(CFE_NV_IMG) $(NVRAM_FILE)
endif
	@./makefirm -t trx -a $(PRODUCT_ID) -k $(TRX_NAME) -v 0_00 -l $(LANGUAGE_POSTFIX) -b $(CFE_NV_IMG) -s 40000 -f $(MAX_FIRMWARE_SIZE) >>mk.log.$(PRODUCT_ID)
	@mv $(PRODUCT_ID)_$(LANGUAGE_POSTFIX)_0_00.bin binary/$(FINAL_FIRMWARE_NAME).boot
	@./makefirm -t trx -a $(PRODUCT_ID) -k $(TRX_NAME) -v $(MAJOR_VER)_$(MINOR_VER) -l $(LANGUAGE_POSTFIX) -b $(CFE_NV_IMG) -s 40000 -f $(MAX_FIRMWARE_SIZE) >>mk.log.$(PRODUCT_ID)
	@./firmware_size_check.sh $(FIRMWARE_NAME) $(MAX_FIRMWARE_SIZE)
	@mv $(FIRMWARE_NAME)* binary/$(FINAL_FIRMWARE_NAME)
	@echo -e "\n---------------------------------------------------------------------\n"
	@echo -e "\tFirmware Name   : binary / $(FINAL_FIRMWARE_NAME)"
	@echo -e "\tTo upgrade boot : binary / $(FINAL_FIRMWARE_NAME).boot"
	@echo -e "\n---------------------------------------------------------------------"
	@rm -rf $(ROOTFS_IMG)
#	rm -rf root
