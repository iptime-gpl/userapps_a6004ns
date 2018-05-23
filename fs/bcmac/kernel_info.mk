$(info include $(notdir $(lastword $(MAKEFILE_LIST))))

KERNEL_PATH:=$(abspath ../../linux)
KERNEL_FILENAME:=vmlinuz.6.37.14.106.fsrc.512m
LINUX_PATH:=components/opensource/linux/linux-2.6.36
COMPRESSED_DIR_PATH:=src/router/compressed
