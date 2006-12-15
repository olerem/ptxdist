# -*-makefile-*-
# $Id: template 4565 2006-02-10 14:23:10Z mkl $
#
# Copyright (C) 2006 by Erwin Rol
#          
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_ADOBE_UTOPIA_75DPI) += xorg-font-adobe-utopia-75dpi

#
# Paths and names
#
XORG_FONT_ADOBE_UTOPIA_75DPI_VERSION	:= 1.0.1
XORG_FONT_ADOBE_UTOPIA_75DPI		:= font-adobe-utopia-75dpi-X11R7.0-$(XORG_FONT_ADOBE_UTOPIA_75DPI_VERSION)
XORG_FONT_ADOBE_UTOPIA_75DPI_SUFFIX	:= tar.bz2
XORG_FONT_ADOBE_UTOPIA_75DPI_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/X11R7.0/src/font//$(XORG_FONT_ADOBE_UTOPIA_75DPI).$(XORG_FONT_ADOBE_UTOPIA_75DPI_SUFFIX)
XORG_FONT_ADOBE_UTOPIA_75DPI_SOURCE	:= $(SRCDIR)/$(XORG_FONT_ADOBE_UTOPIA_75DPI).$(XORG_FONT_ADOBE_UTOPIA_75DPI_SUFFIX)
XORG_FONT_ADOBE_UTOPIA_75DPI_DIR	:= $(BUILDDIR)/$(XORG_FONT_ADOBE_UTOPIA_75DPI)


# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_get: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.get

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.get: $(xorg-font-adobe-utopia-75dpi_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(XORG_FONT_ADOBE_UTOPIA_75DPI_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, XORG_FONT_ADOBE_UTOPIA_75DPI)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_extract: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.extract

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.extract: $(xorg-font-adobe-utopia-75dpi_extract_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR))
	@$(call extract, XORG_FONT_ADOBE_UTOPIA_75DPI)
	@$(call patchin, XORG_FONT_ADOBE_UTOPIA_75DPI)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_prepare: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.prepare

XORG_FONT_ADOBE_UTOPIA_75DPI_PATH	:=  PATH=$(CROSS_PATH)
XORG_FONT_ADOBE_UTOPIA_75DPI_ENV 	:=  $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_ADOBE_UTOPIA_75DPI_AUTOCONF := $(CROSS_AUTOCONF_USR)

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.prepare: $(xorg-font-adobe-utopia-75dpi_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call clean, $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR)/config.cache)
	cd $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR) && \
		$(XORG_FONT_ADOBE_UTOPIA_75DPI_PATH) $(XORG_FONT_ADOBE_UTOPIA_75DPI_ENV) \
		./configure $(XORG_FONT_ADOBE_UTOPIA_75DPI_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_compile: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.compile

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.compile: $(xorg-font-adobe-utopia-75dpi_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR) && $(XORG_FONT_ADOBE_UTOPIA_75DPI_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_install: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.install

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.install: $(xorg-font-adobe-utopia-75dpi_install_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_targetinstall: $(STATEDIR)/xorg-font-adobe-utopia-75dpi.targetinstall

$(STATEDIR)/xorg-font-adobe-utopia-75dpi.targetinstall: $(xorg-font-adobe-utopia-75dpi_targetinstall_deps_default)
	@$(call targetinfo, $@)

	@$(call install_init, xorg-font-adobe-utopia-75dpi)
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,PACKAGE,xorg-font-adobe-utopia-75dpi)
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,PRIORITY,optional)
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,VERSION,$(XORG_FONT_ADOBE_UTOPIA_75DPI_VERSION))
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,SECTION,base)
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,AUTHOR,"Erwin Rol <ero\@pengutronix.de>")
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,DEPENDS,)
	@$(call install_fixup, xorg-font-adobe-utopia-75dpi,DESCRIPTION,missing)

	@cd $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR); \
	for file in `find . -name "*.pcf.gz" -a \! -name "*ISO8859*"`; do	\
		if [ -e $$file ];then \
			$(call install_copy, xorg-font-adobe-utopia-75dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/75dpi/$$file, n); \
		fi; \
	done;

	@cd $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR); \
	for file in *{ISO8859-15,ISO8859-1}.pcf.gz; do \
		if [ -e $$file ];then \
			$(call install_copy, xorg-font-adobe-utopia-75dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/75dpi/$$file, n); \
		fi; \
	done;

ifdef PTXCONF_XORG_FONT_ADOBE_UTOPIA_75DPI_TRANS
	@cd $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR); \
	for file in *{ISO8859-2,ISO8859-3,ISO8859-4,ISO8859-9,ISO8859-10,ISO8859-13,ISO8859-14}.pcf.gz; do \
		if [ -e $$file ]; then \
			$(call install_copy, xorg-font-adobe-utopia-75dpi, 0, 0, 0644, $$file, $(XORG_FONTDIR)/75dpi/$$file, n); \
		fi; \
	done;
endif

	@$(call install_finish, xorg-font-adobe-utopia-75dpi)

	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

xorg-font-adobe-utopia-75dpi_clean:
	rm -rf $(STATEDIR)/xorg-font-adobe-utopia-75dpi.*
	rm -rf $(IMAGEDIR)/xorg-font-adobe-utopia-75dpi_*
	rm -rf $(XORG_FONT_ADOBE_UTOPIA_75DPI_DIR)

# vim: syntax=make
