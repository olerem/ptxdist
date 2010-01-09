# -*-makefile-*-
#
# Copyright (C) 2007 by Robert Schwebel
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
HOST_PACKAGES-$(PTXCONF_HOST_XORG_PROTO_INPUT) += host-xorg-proto-input

#
# Paths and names
#
HOST_XORG_PROTO_INPUT_DIR	= $(HOST_BUILDDIR)/$(XORG_PROTO_INPUT)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

$(STATEDIR)/host-xorg-proto-input.get: $(STATEDIR)/xorg-proto-input.get
	@$(call targetinfo)
	@$(call touch)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

HOST_XORG_PROTO_INPUT_PATH	:= PATH=$(HOST_PATH)
HOST_XORG_PROTO_INPUT_ENV 	:= $(HOST_ENV)

#
# autoconf
#
HOST_XORG_PROTO_INPUT_AUTOCONF	:= $(HOST_AUTOCONF)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

host-xorg-proto-input_clean:
	rm -rf $(STATEDIR)/host-xorg-proto-input.*
	rm -rf $(HOST_XORG_PROTO_INPUT_DIR)

# vim: syntax=make
