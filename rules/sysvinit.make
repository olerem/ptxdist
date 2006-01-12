# -*-makefile-*-
# $Id$
#
# Copyright (C) 2003 by Benedikt Spranger
# Copyright (C) 2005 by Oscar Peredo
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_SYSVINIT) += sysvinit

#
# Paths and names
#
SYSVINIT_VERSION	= 2.86
SYSVINIT		= sysvinit-$(SYSVINIT_VERSION)
SYSVINIT_SUFFIX		= tar.gz
SYSVINIT_URL		= ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_SOURCE		= $(SRCDIR)/$(SYSVINIT).$(SYSVINIT_SUFFIX)
SYSVINIT_DIR		= $(BUILDDIR)/$(SYSVINIT)

BSDINIT_URL		= http://www.exis.cl/ptxdist/bsdinit-1.0.tar.gz
BSDINIT_SOURCE		= $(SRCDIR)/bsdinit-1.0.tar.gz
BSDINIT_DIR		= $(BUILDDIR)/bsdinit-1.0

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

sysvinit_get: $(STATEDIR)/sysvinit.get

sysvinit_get_deps = $(SYSVINIT_SOURCE)

$(STATEDIR)/sysvinit.get: $(sysvinit_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(SYSVINIT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(SYSVINIT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

sysvinit_extract: $(STATEDIR)/sysvinit.extract

sysvinit_extract_deps = $(STATEDIR)/sysvinit.get

$(STATEDIR)/sysvinit.extract: $(sysvinit_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSVINIT_DIR))
	@$(call extract, $(SYSVINIT_SOURCE))
	@$(call patchin, $(SYSVINIT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

sysvinit_prepare: $(STATEDIR)/sysvinit.prepare

#
# dependencies
#
sysvinit_prepare_deps = \
	$(STATEDIR)/sysvinit.extract \
	$(STATEDIR)/virtual-xchain.install

SYSVINIT_PATH	=  PATH=$(CROSS_PATH)
SYSVINIT_ENV 	=  $(CROSS_ENV)
SYSVINIT_ENV	+= PKG_CONFIG_PATH=$(CROSS_LIB_DIR)/lib/pkgconfig

#
# autoconf
#
SYSVINIT_AUTOCONF =  $(CROSS_AUTOCONF_USR)

$(STATEDIR)/sysvinit.prepare: $(sysvinit_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(SYSVINIT_DIR)/config.cache)
#	cd $(SYSVINIT_DIR) && \
#		$(SYSVINIT_PATH) $(SYSVINIT_ENV) \
#		./configure $(SYSVINIT_AUTOCONF)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

sysvinit_compile: $(STATEDIR)/sysvinit.compile

sysvinit_compile_deps = $(STATEDIR)/sysvinit.prepare

$(STATEDIR)/sysvinit.compile: $(sysvinit_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(SYSVINIT_DIR)/src && \
		$(SYSVINIT_PATH) $(SYSVINIT_ENV) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

sysvinit_install: $(STATEDIR)/sysvinit.install

$(STATEDIR)/sysvinit.install: $(STATEDIR)/sysvinit.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

sysvinit_targetinstall: $(STATEDIR)/sysvinit.targetinstall

sysvinit_targetinstall_deps = $(STATEDIR)/sysvinit.compile

$(STATEDIR)/sysvinit.targetinstall: $(sysvinit_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,sysvinit)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(SYSVINIT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Oscar Peredo <oscar\@exis.cl>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)

ifdef PTXCONF_SYSVINIT_INIT
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/init, /sbin/init)
	@$(call install_link, init, /sbin/telinit)
endif
ifdef PTXCONF_SYSVINIT_HALT
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/halt, /sbin/halt)
	@$(call install_link, halt, /sbin/poweroff)
	@$(call install_link, halt, /sbin/reboot)
endif
ifdef PTXCONF_SYSVINIT_SHUTDOWN
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/shutdown, /sbin/shutdown)
endif
ifdef PTXCONF_SYSVINIT_RUNLEVEL
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/runlevel, /sbin/runlevel)
endif
ifdef PTXCONF_SYSVINIT_KILLALL5
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/killall5, /sbin/killall5)
	
endif
ifdef PTXCONF_SYSVINIT_SULOGIN
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/sulogin, /sbin/sulogin)
endif
ifdef PTXCONF_SYSVINIT_BOOTLOGD
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/bootlogd, /sbin/bootlogd)
endif
ifdef PTXCONF_SYSVINIT_WALL
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/wall, /usr/bin/wall)
endif
ifdef PTXCONF_SYSVINIT_LAST
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/last, /usr/bin/last)
endif
ifdef PTXCONF_SYSVINIT_MESG
	@$(call install_copy, 0, 0, 0755, $(SYSVINIT_DIR)/src/mesg, /usr/bin/mesg)
endif
ifdef PTXCONF_SYSVINIT_BSDINIT
	@$(call clean, $(BSDINIT_DIR))
	@$(call get, $(BSDINIT_URL))
	@$(call extract, $(BSDINIT_SOURCE))
	@$(call install_copy, 0, 0, 0644, $(BSDINIT_DIR)/inittab, /etc/inittab, n)
	@$(call install_copy, 0, 0, 0755, /etc/rc.d)
	@$(call install_copy, 0, 0, 0754, $(BSDINIT_DIR)/rc.0, /etc/rc.d/rc.0, n)
	@$(call install_copy, 0, 0, 0754, $(BSDINIT_DIR)/rc.1, /etc/rc.d/rc.1, n)
	@$(call install_copy, 0, 0, 0754, $(BSDINIT_DIR)/rc.2, /etc/rc.d/rc.2, n)
	@$(call install_copy, 0, 0, 0754, $(BSDINIT_DIR)/rc.5, /etc/rc.d/rc.5, n)
	@$(call install_copy, 0, 0, 0754, $(BSDINIT_DIR)/rc.sysinit, /etc/rc.d/rc.sysinit, n) 
	@$(call install_link, rc.2, /etc/rc.d/rc.3)
	@$(call install_link, rc.2, /etc/rc.d/rc.4)
	@$(call install_link, rc.0, /etc/rc.d/rc.6)
endif
	# FIXME: RSC: this should be done by udev?
	@$(call install_node, 0, 0, 0600, p, m, m, /dev/initctl)

	@$(call install_finish)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

sysvinit_clean:
	rm -rf $(STATEDIR)/sysvinit.*
	rm -rf $(IMAGEDIR)/sysvinit_*
	rm -rf $(SYSVINIT_DIR)

# vim: syntax=make
