# $Id: gmp.make,v 1.2 2003/05/13 11:17:58 robert Exp $
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
ifeq (y,$(PTXCONF_GMP))
PACKAGES += gmp
endif

#
# Paths and names 
#
# FIXME: if lsh works with 4.1, remove 3.1
# GMP			= gmp-3.1
# GMP_URL 		= ftp://ftp.gnu.org/pub/gnu/gmp/$(GMP).tar.gz
GMP			= gmp-4.1
GMP_URL 		= ftp://ftp.informatik.rwth-aachen.de/pub/gnu/gmp/$(GMP).tar.gz
GMP_SOURCE		= $(SRCDIR)/$(GMP).tar.gz
GMP_DIR 		= $(BUILDDIR)/$(GMP)
GMP_EXTRACT		= gzip -dc

# ----------------------------------------------------------------------------
# Get
# ----------------------------------------------------------------------------

gmp_get: $(STATEDIR)/gmp.get

$(STATEDIR)/gmp.get: $(GMP_SOURCE)
	touch $@

$(GMP_SOURCE):
	@echo
	@echo -------
	@echo target: gmp.get
	@echo -------
	@echo
	wget -P $(SRCDIR) $(PASSIVEFTP) $(GMP_URL)

# ----------------------------------------------------------------------------
# Extract
# ----------------------------------------------------------------------------

gmp_extract: $(STATEDIR)/gmp.extract

$(STATEDIR)/gmp.extract: $(STATEDIR)/gmp.get
	@echo
	@echo -----------
	@echo target: gmp.extract
	@echo -----------
	@echo
	$(GMP_EXTRACT)    $(GMP_SOURCE)    | $(TAR) -C $(BUILDDIR) -xf -
	touch $@

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

gmp_prepare: $(STATEDIR)/gmp.prepare

GMP_AUTOCONF =
GMP_AUTOCONF += --build=$(GNU_HOST)
GMP_AUTOCONF += --host=$(PTXCONF_GNU_TARGET)
GMP_AUTOCONF += --prefix=$(PTXCONF_PREFIX)

$(STATEDIR)/gmp.prepare: $(STATEDIR)/gmp.extract
	@echo
	@echo ----------- 
	@echo target: gmp.prepare
	@echo -----------
	@echo
	cd $(GMP_DIR) && 						\
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH ./configure $(GMP_AUTOCONF)
	touch $@

# ----------------------------------------------------------------------------
# Compile
# ----------------------------------------------------------------------------

gmp_compile: $(STATEDIR)/gmp.compile

$(STATEDIR)/gmp.compile: $(STATEDIR)/gmp.prepare 
	@echo
	@echo ----------- 
	@echo target: gmp.compile
	@echo -----------
	@echo
	PATH=$(PTXCONF_PREFIX)/bin:$$PATH make -C $(GMP_DIR)
	touch $@

# ----------------------------------------------------------------------------
# Install
# ----------------------------------------------------------------------------

gmp_install: $(STATEDIR)/gmp.install

$(STATEDIR)/gmp.install: $(STATEDIR)/gmp.compile
	@echo
	@echo ----------- 
	@echo target: gmp.install
	@echo -----------
	@echo
	# FIXME: doesn't work when using local bin dir
	make -C $(GMP_DIR) install 
	touch $@

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

gmp_targetinstall: $(STATEDIR)/gmp.targetinstall

$(STATEDIR)/gmp.targetinstall: $(STATEDIR)/gmp.install
	@echo
	@echo ----------------- 
	@echo target: gmp.targetinstall
	@echo -----------------
	@echo
	mkdir -p $(ROOTDIR)/lib
	# preserve links -> we cannot use install
	cp -d $(PTXCONF_PREFIX)/lib/libgmp.so* $(ROOTDIR)/lib
	$(CROSSSTRIP) -S $(ROOTDIR)/lib/libgmp.so*
	touch $@

# ----------------------------------------------------------------------------
# Clean
# ----------------------------------------------------------------------------

gmp_clean: 
	rm -rf $(STATEDIR)/gmp.* $(GMP_DIR)

# vim: syntax=make
