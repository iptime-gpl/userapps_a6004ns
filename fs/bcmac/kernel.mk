$(info include $(notdir $(lastword $(MAKEFILE_LIST))))

.PHONY: DUMMY
DUMMY:

include ../../misc_config
include clone_info.mk
include kernel_info.mk

LINUXDIR:=$(KERNEL_PATH)/$(LINUX_PATH)
SRCBASE:=$(patsubst %/,%,$(abspath $(LINUXDIR)/../../../../src))
BASEDIR:=$(patsubst %/,%,$(abspath $(LINUXDIR)/../../../..))
ARCH:=arm

WLAN_Components:=src/shared/bcmwifi/include src/wl/clm/include src/wl/olpc/include src/wl/ppr/include

ifeq ($(BRCM_SDK_VERSION),9.10.178.27)
WLAN_Components+=components/shared
MK_ENV+=WLTEST=1
endif

WLAN_ComponentIncPath:=$(addprefix -I$(BASEDIR)/,$(WLAN_Components))
CROSS_COMPILE:=arm-brcm-linux-uclibcgnueabi-
LD:=$(CROSS_COMPILE)ld
CC:=$(CROSS_COMPILE)gcc

MK_ENV:=SRCBASE=$(SRCBASE) BASEDIR=$(BASEDIR) ARCH=$(ARCH) WLAN_ComponentIncPath="$(WLAN_ComponentIncPath)"

vmlinux:
	make $(MK_ENV) oldconfig -C $(LINUXDIR)
	(echo '.NOTPARALLEL:' ; cat $(LINUXDIR)/Makefile) | $(MAKE) -C $(LINUXDIR) -f - $(MK_ENV) zImage

vmlinuz:
	make -C $(BASEDIR)/$(COMPRESSED_DIR_PATH) $(MK_ENV) LINUXDIR=$(LINUXDIR) LD=$(LD) CC=$(CC)
	@mv $(BASEDIR)/$(COMPRESSED_DIR_PATH)/vmlinuz $(LINUXDIR)

clean_kernel:
	@rm -f $(LINUXDIR)/vmlinux $(LINUXDIR)/vmlinuz
	make clean CONFIG_WL_CONF=wlconfig_lx_router_ap -C $(LINUXDIR)
	make clean -C $(BASEDIR)/$(COMPRESSED_DIR_PATH) -C $(LINUXDIR)

.PHONY: clean_kernel

ifeq ($(.DEFAULT_GOAL),DUMMY)
.DEFAULT_GOAL:=kernel
endif

MAKE_KERNEL:= __kernel__ __install__
.PHONY : $(MAKE_KERNEL)
kernel: $(MAKE_KERNEL)

__kernel__: vmlinux vmlinuz 

__install__:
	@mkdir -p prebuilt/kernel
	cp $(LINUXDIR)/vmlinuz prebuilt/kernel/$(KERNEL_FILENAME)

