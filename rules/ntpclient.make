# -*-makefile-*-
# $Id: ntpclient.make$
#
#
# We provide this package
#
PACKAGES-$(PTXCONF_NTPCLIENT) += ntpclient

#
# Paths and names
#
NTPCLIENT_VERSION	= 2003_194
NTPCLIENT		= ntpclient
NTPCLIENT_SUFFIX	= tar.gz
NTPCLIENT_URL		= http://doolittle.faludi.com/ntpclient/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_SOURCE	= $(SRCDIR)/$(NTPCLIENT)_$(NTPCLIENT_VERSION).$(NTPCLIENT_SUFFIX)
NTPCLIENT_DIR		= $(BUILDDIR)/$(NTPCLIENT)

-include $(call package_depfile)

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

ntpclient_get: $(STATEDIR)/ntpclient.get

ntpclient_get_deps = $(NTPCLIENT_SOURCE)

$(STATEDIR)/ntpclient.get: $(ntpclient_get_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

$(NTPCLIENT_SOURCE):
	@$(call targetinfo, $@)
	@$(call get, $(NTPCLIENT_URL))

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

ntpclient_extract: $(STATEDIR)/ntpclient.extract

ntpclient_extract_deps = $(STATEDIR)/ntpclient.get

$(STATEDIR)/ntpclient.extract: $(ntpclient_extract_deps)
	@$(call targetinfo, $@)
	@$(call clean, $(NTPCLIENT_DIR))
	@$(call extract, $(NTPCLIENT_SOURCE))
	@$(call patchin, $(NTPCLIENT))
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

ntpclient_prepare: $(STATEDIR)/ntpclient.prepare

#
# dependencies
#
ntpclient_prepare_deps = \
	$(STATEDIR)/ntpclient.extract \
	$(STATEDIR)/virtual-xchain.install

NTPCLIENT_PATH	=  PATH=$(CROSS_PATH)
NTPCLIENT_ENV 	=  $(CROSS_ENV)

$(STATEDIR)/ntpclient.prepare: $(ntpclient_prepare_deps_default)
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

ntpclient_compile: $(STATEDIR)/ntpclient.compile

ntpclient_compile_deps = $(STATEDIR)/ntpclient.prepare

$(STATEDIR)/ntpclient.compile: $(ntpclient_compile_deps_default)
	@$(call targetinfo, $@)
	cd $(NTPCLIENT_DIR) && $(NTPCLIENT_ENV) $(NTPCLIENT_PATH) make
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

ntpclient_install: $(STATEDIR)/ntpclient.install

$(STATEDIR)/ntpclient.install: $(STATEDIR)/ntpclient.compile
	@$(call targetinfo, $@)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

ntpclient_targetinstall: $(STATEDIR)/ntpclient.targetinstall

ntpclient_targetinstall_deps = $(STATEDIR)/ntpclient.compile

$(STATEDIR)/ntpclient.targetinstall: $(ntpclient_targetinstall_deps_default)
	@$(call targetinfo, $@)
	@$(call install_init,default)
	@$(call install_fixup,PACKAGE,ntpclient)
	@$(call install_fixup,PRIORITY,optional)
	@$(call install_fixup,VERSION,$(NTPCLIENT_VERSION))
	@$(call install_fixup,SECTION,base)
	@$(call install_fixup,AUTHOR,"Robert Schwebel <r.schwebel\@pengutronix.de>")
	@$(call install_fixup,DEPENDS,)
	@$(call install_fixup,DESCRIPTION,missing)
	@$(call install_copy, 0, 0, 0755, $(NTPCLIENT_DIR)/ntpclient, /usr/sbin/ntpclient)
	@$(call install_finish)
	@$(call touch, $@)

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

ntpclient_clean:
	rm -rf $(STATEDIR)/ntpclient.*
	rm -rf $(IMAGEDIR)/ntpclient_*
	rm -rf $(NTPCLIENT_DIR)

# vim: syntax=make
