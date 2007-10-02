# -*-makefile-*-
# $Id$
#
# Copyright (C) 2007 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# See CREDITS for details about who has contributed to this project.
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
HOST_PACKAGES-$(PTXCONF_HOST_LIBPNG) += host-libpng

#
# Paths and names
#
HOST_LIBPNG_DIR	= $(HOST_BUILDDIR)/$(LIBPNG)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

host-libpng_get: $(STATEDIR)/host-libpng.get

$(STATEDIR)/host-libpng.get: $(STATEDIR)/libpng.get
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

host-libpng_extract: $(STATEDIR)/host-libpng.extract

$(STATEDIR)/host-libpng.extract:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBPNG_DIR))
	@$(call extract, LIBPNG, $(HOST_BUILDDIR))
	@$(call patchin, LIBPNG, $(HOST_LIBPNG_DIR))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

host-libpng_prepare: $(STATEDIR)/host-libpng.prepare

HOST_LIBPNG_PATH	:= PATH=$(HOST_PATH)
HOST_LIBPNG_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_LIBPNG_AUTOCONF	:= $(HOST_AUTOCONF)

$(STATEDIR)/host-libpng.prepare:
	@$(call targetinfo, $@)
	@$(call clean, $(HOST_LIBPNG_DIR)/config.cache)
	cd $(HOST_LIBPNG_DIR) && \
		$(HOST_LIBPNG_PATH) $(HOST_LIBPNG_ENV) \
		./configure $(HOST_LIBPNG_AUTOCONF)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

host-libpng_compile: $(STATEDIR)/host-libpng.compile

$(STATEDIR)/host-libpng.compile:
	@$(call targetinfo, $@)
	cd $(HOST_LIBPNG_DIR) && $(HOST_LIBPNG_PATH) $(MAKE) $(PARALLELMFLAGS)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

host-libpng_install: $(STATEDIR)/host-libpng.install

$(STATEDIR)/host-libpng.install:
	@$(call targetinfo, $@)
	@$(call install, HOST_LIBPNG,,h)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-libpng_clean:
	rm -rf $(STATEDIR)/host-libpng.*
	rm -rf $(HOST_LIBPNG_DIR)

# vim: syntax=make
