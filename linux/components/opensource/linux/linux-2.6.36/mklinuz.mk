CUR_DIR:=$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
SRCBASE:=$(patsubst %/,%,$(abspath $(CUR_DIR)/../../../../src))
BASEDIR:=$(patsubst %/,%,$(abspath $(CUR_DIR)/../../../..))
ARCH:=arm
WLAN_Components:=src/shared/bcmwifi/include src/wl/clm/include src/wl/olpc/include src/wl/ppr/include
WLAN_ComponentIncPath:=$(addprefix -I$(BASEDIR)/,$(WLAN_Components))
LINUXDIR:=$(CUR_DIR)
CROSS_COMPILE:=arm-brcm-linux-uclibcgnueabi-
LD:=$(CROSS_COMPILE)ld
CC:=$(CROSS_COMPILE)gcc

all: vmlinux vmlinuz 
vmlinux:
	@make SRCBASE=$(SRCBASE) BASEDIR=$(BASEDIR) ARCH=$(ARCH) WLAN_ComponentIncPath="$(WLAN_ComponentIncPath)" oldconfig
	(echo '.NOTPARALLEL:' ; cat $(LINUXDIR)/Makefile) | $(MAKE) -C $(LINUXDIR) -f - SRCBASE=$(SRCBASE) BASEDIR=$(BASEDIR) ARCH=$(ARCH) WLAN_ComponentIncPath="$(WLAN_ComponentIncPath)" zImage
#	@make SRCBASE=$(SRCBASE) BASEDIR=$(BASEDIR) ARCH=$(ARCH) WLAN_ComponentIncPath="$(WLAN_ComponentIncPath)" zImage

vmlinuz:
	@make -C $(BASEDIR)/src/router/compressed SRCBASE=$(SRCBASE) BASEDIR=$(BASEDIR) ARCH=$(ARCH) LINUXDIR=$(LINUXDIR) LD=$(LD) CC=$(CC)
	@mv $(BASEDIR)/src/router/compressed/vmlinuz .

clean:
	@rm -f vmlinux vmlinuz
	@make clean CONFIG_WL_CONF=wlconfig_lx_router_ap
	@make clean -C $(BASEDIR)/src/router/compressed

mrproper:
	@make mrproper CONFIG_WL_CONF=wlconfig_lx_router_ap -C $(LINUXDIR)

.PHONY: all clean
