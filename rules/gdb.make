# -*-makefile-*-
# $Id: gdb.make,v 1.6 2004/01/07 14:11:07 robert Exp $
#
# Copyright (C) 2002 by Pengutronix e.K., Hildesheim, Germany
# Copyright (C) 2003 by Auerswald GmbH & Co. KG, Schandelah, Germany
#
# See CREDITS for details about who has contributed to this project. 
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
ifdef PTXCONF_GDB
PACKAGES += gdb
endif

#
# We depend on this package
#
ifdef PTXCONF_GDB_TERMCAP
PACKAGES += termcap
endif

ifdef PTXCONF_GDB_NCURSES
PACKAGES += ncurses
endif

#
# Paths and names 
#
GDB_VERSION	= 6.0
GDB		= gdb-$(GDB_VERSION)
GDB_SUFFIX	= tar.gz
GDB_URL		= ftp://ftp.gnu.org/pub/gnu/gdb/$(GDB).$(GDB_SUFFIX)
GDB_SOURCE	= $(SRCDIR)/$(GDB).tar.gz
GDB_DIR		= $(BUILDDIR)/$(GDB)
GDB_BUILDDIR	= $(BUILDDIR)/$(GDB)-build

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gdb_get: $(STATEDIR)/gdb.get

gdb_get_deps = $(GDB_SOURCE)

$(STATEDIR)/gdb.get: $(gdb_get_deps)
	@$(call targetinfo, $@)
	@$(call get_patches, $(GDB))
	touch $@

$(GDB_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(GDB_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gdb_extract: $(STATEDIR)/gdb.extract

$(STATEDIR)/gdb.extract: $(STATEDIR)/gdb.get
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_DIR))
	@$(call extract, $(GDB_SOURCE))
	@$(call patchin, $(GDB))
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gdb_prepare: $(STATEDIR)/gdb.prepare

#
# dependencies
#
gdb_prepare_deps = \
	$(STATEDIR)/virtual-xchain.install \
	$(STATEDIR)/gdb.extract

ifdef PTXCONF_GDB_TERMCAP
gdb_prepare_deps += $(STATEDIR)/termcap.install
endif
ifdef PTXCONF_GDB_NCURSES
gdb_prepare_deps += $(STATEDIR)/ncurses.install
endif

GDB_PATH	=  PATH=$(CROSS_PATH)
GDB_ENV		=  $(CROSS_ENV)
GDB_ENV		+= bash_cv_have_mbstate_t=yes	# is not determined correctly in gdb-6.0
GDB_ENV		+= ac_cv_header_stdc=yes	# FIXME: libiberty doesn' find out correctly

ifndef PTXCONF_GDB_SHARED
GDB_MAKEVARS	=  LDFLAGS=-static
endif

#
# autoconf
#
GDB_AUTOCONF	=  --prefix=/usr
GDB_AUTOCONF	+= --build=$(GNU_HOST)
GDB_AUTOCONF	+= --host=$(PTXCONF_GNU_TARGET)
GDB_AUTOCONF	+= --target=$(PTXCONF_GNU_TARGET)

$(STATEDIR)/gdb.prepare: $(gdb_prepare_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(GDB_BUILDDIR))
	mkdir -p $(GDB_BUILDDIR)
	cd $(GDB_BUILDDIR) && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/configure $(GDB_AUTOCONF)

	# RSC: nobody seems to have tried to _crosscompile_ gdb yet - 
	# everybody seems to build cross-gdbs only. So we have to 
	# prepare libiberty first with the cross options to avoid that 
	# it runs the configure stages automatically and with the wrong
	# options (host) during the compile stage
	# 
	mkdir -p $(GDB_BUILDDIR)/libiberty
	ln -s $(GDB_BUILDDIR)/libiberty $(GDB_BUILDDIR)/build-i686-host-linux-gnu/libiberty
	cd $(GDB_BUILDDIR)/libiberty && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/libiberty/configure $(GDB_AUTOCONF)

	# same with sim/
	mkdir -p $(GDB_BUILDDIR)/sim
	cd $(GDB_BUILDDIR)/sim && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/sim/configure $(GDB_AUTOCONF)
	
	# same with gdb/
	mkdir -p $(GDB_BUILDDIR)/gdb
	cd $(GDB_BUILDDIR)/gdb && \
		$(GDB_PATH) $(GDB_ENV) \
		$(GDB_DIR)/gdb/configure $(GDB_AUTOCONF)
		
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gdb_compile: $(STATEDIR)/gdb.compile

$(STATEDIR)/gdb.compile: $(STATEDIR)/gdb.prepare 
	@$(call targetinfo, $@)
##
## the libiberty part is compiled for the host system
##
## don't pass target CFLAGS to it, so override them and call the configure script
##
#	$(GDB_PATH) make -C $(GDB_BUILDDIR) $(GDB_MAKEVARS) CFLAGS='' CXXFLAGS='' configure-build-libiberty
#	$(GDB_PATH) make -C $(GDB_BUILDDIR) $(GDB_MAKEVARS) 
	$(GDB_PATH) $(GDB_ENV) make -C $(GDB_BUILDDIR)

	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gdb_install: $(STATEDIR)/gdb.install

$(STATEDIR)/gdb.install:
	@$(call targetinfo, $@)
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gdb_targetinstall: $(STATEDIR)/gdb.targetinstall

gdb_targetinstall_deps = \
	$(STATEDIR)/gdb.compile

ifdef PTXCONF_GDB_SHARED
ifdef PTXCONF_NCURSES
gdb_targetinstall_deps += $(STATEDIR)/ncurses.targetinstall
endif
endif

$(STATEDIR)/gdb.targetinstall: $(gdb_targetinstall_deps)
	@$(call targetinfo, $@)
	mkdir -p $(ROOTDIR)/usr/bin
	install $(GDB_BUILDDIR)/gdb/gdb $(ROOTDIR)/usr/bin
	$(CROSSSTRIP) -R .note -R .comment $(ROOTDIR)/usr/bin/gdb
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gdb_clean: 
	rm -rf $(STATEDIR)/gdb.* $(GDB_DIR)

# vim: syntax=make
