# -*-makefile-*- 
# $Id: bootdisk.make,v 1.3 2003/06/16 12:05:16 bsp Exp $
#
# (c) 2002 by Pengutronix e.K., Hildesheim, Germany
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXDIST project and license conditions
# see the README file.
#

#
# We provide this package
#
ifeq (y, $(PTXCONF_GRUB_BOOTDISK))
PACKAGES += bootdisk
endif

#
# Paths and names 
#
BOOTDISK			=
BOOTDISK_URL			=
BOOTDISK_SOURCE			=
BOOTDISK_DIR			= $(TOPDIR)/bootdisk
BOOTDISK_EXTRACT		=

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

bootdisk_get: $(STATEDIR)/bootdisk.get

$(STATEDIR)/bootdisk.get:
	touch $@

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

bootdisk_extract: $(STATEDIR)/bootdisk.extract

$(STATEDIR)/bootdisk.extract: $(STATEDIR)/bootdisk.get
	@$(call targetinfo, bootdisk.extract)
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

bootdisk_prepare: $(STATEDIR)/bootdisk.prepare

$(STATEDIR)/bootdisk.prepare: $(STATEDIR)/bootdisk.extract
	@$(call targetinfo, bootdisk.prepare)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

bootdisk_compile: $(STATEDIR)/bootdisk.compile

$(STATEDIR)/bootdisk.compile: $(STATEDIR)/bootdisk.prepare 
	@$(call targetinfo, bootdisk.compile)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

bootdisk_install: $(STATEDIR)/bootdisk.install

$(STATEDIR)/bootdisk.install: $(STATEDIR)/bootdisk.compile
	@$(call targetinfo, bootdisk.install)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

bootdisk_targetinstall: $(STATEDIR)/bootdisk.targetinstall

bootdisk_targetinstall_deps =  $(STATEDIR)/bootdisk.install
bootdisk_targetinstall_deps += $(STATEDIR)/kernel.compile
bootdisk_targetinstall_deps += $(STATEDIR)/grub.compile
bootdisk_targetinstall_deps += $(STATEDIR)/e2fsprogs.compile
bootdisk_targetinstall_deps += $(STATEDIR)/ncurses.compile

$(STATEDIR)/bootdisk.targetinstall: $(bootdisk_targetinstall_deps)
	@$(call targetinfo, bootdisk.targetinstall)
        ifeq (y, $(PTXCONF_GRUB_BOOTDISK))
	mkdir -p $(BOOTDISK_DIR)
	mkdir -p $(BOOTDISK_DIR)/boot
	mkdir -p $(BOOTDISK_DIR)/boot/grub
	mkdir -p $(BOOTDISK_DIR)/bin
	mkdir -p $(BOOTDISK_DIR)/lib

	install $(KERNEL_TARGET_PATH) $(BOOTDISK_DIR)/boot/
	install $(GRUB_DIR)/stage1/stage1 $(BOOTDISK_DIR)/boot/grub/
	install $(GRUB_DIR)/stage2/stage2 $(BOOTDISK_DIR)/boot/grub/
	install $(GRUB_DIR)/grub/grub $(BOOTDISK_DIR)/bin/
	strip $(BOOTDISK_DIR)/bin/grub
	# FIXME: make this a config option
	install $(SRCDIR)/grub-menu-flash-ptx1.lst $(BOOTDISK_DIR)/boot/grub/menu-flash.lst
	install $(SRCDIR)/grub-menu-disk-ptx1.lst  $(BOOTDISK_DIR)/boot/grub/menu-disk.lst
	ln -sf menu-disk.lst $(BOOTDISK_DIR)/boot/grub/menu.lst
	ln -sf menu.lst $(BOOTDISK_DIR)/boot/grub/grub.conf
	install $(E2FSPROGS_DIR)/misc/mke2fs $(BOOTDISK_DIR)/bin/
	install $(NCURSES_DIR)/lib/libncurses.so.5.2 $(BOOTDISK_DIR)/lib/
	strip $(BOOTDISK_DIR)/lib/libncurses.so.5.2
        endif
	# FIXME: is this the correct file for this rule? 
        ifeq (y, $(PTXCONF_PTXFLASH))
	mkdir -p $(ROOTDIR)/sbin
	install $(SRCDIR)/ptxflash $(ROOTDIR)/sbin/
        endif
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

bootdisk_clean: 
	rm -rf $(STATEDIR)/bootdisk.* $(BOOTDISK_DIR)

# vim: syntax=make
