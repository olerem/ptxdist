# -*-makefile-*-
#
# Copyright (C) 2006 by Erwin Rol
#           (C) 2010 by Michael Olbrich <m.olbrich@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_XORG_FONT_MISC_CYRILLIC) += xorg-font-misc-cyrillic

#
# Paths and names
#
XORG_FONT_MISC_CYRILLIC_VERSION	:= 1.0.3
XORG_FONT_MISC_CYRILLIC_MD5	:= 96109d0890ad2b6b0e948525ebb0aba8
XORG_FONT_MISC_CYRILLIC		:= font-misc-cyrillic-$(XORG_FONT_MISC_CYRILLIC_VERSION)
XORG_FONT_MISC_CYRILLIC_SUFFIX	:= tar.bz2
XORG_FONT_MISC_CYRILLIC_URL	:= $(PTXCONF_SETUP_XORGMIRROR)/individual/font/$(XORG_FONT_MISC_CYRILLIC).$(XORG_FONT_MISC_CYRILLIC_SUFFIX)
XORG_FONT_MISC_CYRILLIC_SOURCE	:= $(SRCDIR)/$(XORG_FONT_MISC_CYRILLIC).$(XORG_FONT_MISC_CYRILLIC_SUFFIX)
XORG_FONT_MISC_CYRILLIC_DIR	:= $(BUILDDIR)/$(XORG_FONT_MISC_CYRILLIC)

ifdef PTXCONF_XORG_FONT_MISC_CYRILLIC
$(STATEDIR)/xorg-fonts.targetinstall.post: $(STATEDIR)/xorg-font-misc-cyrillic.targetinstall
endif

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(XORG_FONT_MISC_CYRILLIC_SOURCE):
	@$(call targetinfo)
	@$(call get, XORG_FONT_MISC_CYRILLIC)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

XORG_FONT_MISC_CYRILLIC_PATH	:= PATH=$(CROSS_PATH)
XORG_FONT_MISC_CYRILLIC_ENV 	:= $(CROSS_ENV)

#
# autoconf
#
XORG_FONT_MISC_CYRILLIC_AUTOCONF := \
	$(CROSS_AUTOCONF_USR) \
	--with-fontdir=$(XORG_FONTDIR)/cyrillic

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-cyrillic.install:
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/xorg-font-misc-cyrillic.targetinstall:
	@$(call targetinfo)

	@mkdir -p $(XORG_FONTS_DIR_INSTALL)/cyrillic

	@find $(XORG_FONT_MISC_CYRILLIC_DIR) \
		-name "*.pcf.gz" \
		| \
		while read file; do \
		install -m 644 $${file} $(XORG_FONTS_DIR_INSTALL)/cyrillic; \
	done

	@$(call touch)

# vim: syntax=make
