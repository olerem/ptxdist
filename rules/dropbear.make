# -*-makefile-*-
#
# Copyright (C) 2003 by Marc Kleine-Budde <kleine-budde@gmx.de> for
#                       Pengutronix e.K. <info@pengutronix.de>, Germany
#               2009 by Marc Kleine-Budde <mkl@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DROPBEAR) += dropbear

#
# Paths and names
#
DROPBEAR_VERSION	:= 2019.78
DROPBEAR_MD5		:= a972c85ed678ad0fdcb7844e1294fb54
DROPBEAR		:= dropbear-$(DROPBEAR_VERSION)
DROPBEAR_SUFFIX		:= tar.bz2
DROPBEAR_URL		:= http://matt.ucc.asn.au/dropbear/releases/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_SOURCE		:= $(SRCDIR)/$(DROPBEAR).$(DROPBEAR_SUFFIX)
DROPBEAR_DIR		:= $(BUILDDIR)/$(DROPBEAR)
DROPBEAR_LICENSE	:= MIT AND BSD-2-Clause AND BSD-3-Clause AND SSH-short
DROPBEAR_LICENSE_FILES	:= \
	file://LICENSE;md5=a5ec40cafba26fc4396d0b550f824e01 \
	file://loginrec.c;startline=1;endline=26;md5=0d785ee11fab1cead2c7fee9c35574f1

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DROPBEAR_CONF_TOOL	:= autoconf
DROPBEAR_CONF_OPT 	:= \
	$(CROSS_AUTOCONF_USR) \
	--enable-harden \
	$(GLOBAL_LARGE_FILE_OPTION) \
	--$(call ptx/endis, PTXCONF_DROPBEAR_ZLIB)-zlib \
	--disable-pam \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_OPENPTY)-openpty \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_SYSLOG)-syslog \
	--enable-shadow \
	--disable-fuzz \
	--enable-bundled-libtom \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_LASTLOG)-lastlog \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_UTMP)-utmp \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_UTMPX)-utmpx \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_WTMP)-wtmp \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_WTMPX)-wtmpx \
	--disable-loginfunc \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_PUTUTLINE)-pututline \
	--$(call ptx/disen, PTXCONF_DROPBEAR_DIS_PUTUTXLINE)-pututxline

DROPBEAR_LOCALOPTIONS	:= $(DROPBEAR_DIR)/localoptions.h

$(STATEDIR)/dropbear.prepare:
	@$(call targetinfo)
	@$(call world/prepare, DROPBEAR)

	@echo "/* localoptions.h created by ptxdist */" > $(DROPBEAR_LOCALOPTIONS)

ifdef PTXCONF_DROPBEAR_DIS_X11
	@echo "ptxdist: disabling x11 forwarding"
	@echo "#define DROPBEAR_X11FWD 0" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: enabling x11 forwarding"
	@echo "#define DROPBEAR_X11FWD 1" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_DIS_TCP
	@echo "ptxdist: disabling tcp"
	@echo "#define DROPBEAR_CLI_LOCALTCPFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_REMOTETCPFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_SVR_LOCALTCPFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_SVR_REMOTETCPFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: enabling tcp"
	@echo "#define DROPBEAR_CLI_LOCALTCPFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_REMOTETCPFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_SVR_LOCALTCPFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_SVR_REMOTETCPFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_DIS_AGENT
	@echo "ptxdist: disabling agent"
	@echo "#define DROPBEAR_SVR_AGENTFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_AGENTFWD 0" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: enabling agent"
	@echo "#define DROPBEAR_SVR_AGENTFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_AGENTFWD 1" >> $(DROPBEAR_LOCALOPTIONS)
endif


ifdef PTXCONF_DROPBEAR_AES128
	@echo "ptxdist: enabling aes128"
	@echo "#define DROPBEAR_AES128 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling aes128"
	@echo "#define DROPBEAR_AES128 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_3DES
	@echo "ptxdist: enabling 3des"
	@echo "#define DROPBEAR_3DES 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling 3des"
	@echo "#define DROPBEAR_3DES 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_AES256
	@echo "ptxdist: enabling aes256"
	@echo "#define DROPBEAR_AES256 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling aes256"
	@echo "#define DROPBEAR_AES256 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_BLOWFISH
	@echo "ptxdist: enabling blowfish"
	@echo "#define DROPBEAR_BLOWFISH 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling blowfish"
	@echo "#define DROPBEAR_BLOWFISH 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH256
	@echo "ptxdist: enabling twofish256"
	@echo "#define DROPBEAR_TWOFISH256 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling twofish256"
	@echo "#define DROPBEAR_TWOFISH256 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_TWOFISH128
	@echo "ptxdist: enabling twofish128"
	@echo "#define DROPBEAR_TWOFISH128 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling twofish128"
	@echo "#define DROPBEAR_TWOFISH128 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_CBC_CIPHERS
	@echo "ptxdist: enabling cbc ciphers"
	@echo "#define DROPBEAR_ENABLE_CBC_MODE 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling cbc ciphers"
	@echo "#define DROPBEAR_ENABLE_CBC_MODE 0" >> $(DROPBEAR_LOCALOPTIONS)
endif


ifdef PTXCONF_DROPBEAR_CTR_CIPHERS
	@echo "ptxdist: enabling ctr ciphers"
	@echo "#define DROPBEAR_ENABLE_CTR_MODE 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling ctr ciphers"
	@echo "#define DROPBEAR_ENABLE_CTR_MODE 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_SHA1
	@echo "ptxdist: enabling sha1"
	@echo "#define DROPBEAR_SHA1_HMAC 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_DH_GROUP1 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_DH_GROUP14_SHA1 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling sha1"
	@echo "#define DROPBEAR_SHA1_HMAC 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_DH_GROUP1 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_DH_GROUP14_SHA1 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_SHA1_96
	@echo "ptxdist: enabling sha1-96"
	@echo "#define DROPBEAR_SHA1_96_HMAC 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling sha1-96"
	@echo "#define DROPBEAR_SHA1_96_HMAC 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_SHA256
	@echo "ptxdist: enabling sha256"
	@echo "#define DROPBEAR_SHA2_256_HMAC 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling sha256"
	@echo "#define DROPBEAR_SHA2_256_HMAC 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_SHA512
	@echo "ptxdist: enabling sha512"
	@echo "#define DROPBEAR_SHA2_512_HMAC 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling sha512"
	@echo "#define DROPBEAR_SHA2_512_HMAC 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_MD5
	@echo "ptxdist: enabling md5"
	@echo "WARNING: md5 is considered broken and is deactivated in upstream dropbear by default!"
	@echo "#define DROPBEAR_MD5_HMAC 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling md5"
	@echo "#define DROPBEAR_MD5_HMAC 0" >> $(DROPBEAR_LOCALOPTIONS)
endif


ifdef PTXCONF_DROPBEAR_RSA
	@echo "ptxdist: enabling rsa"
	@echo "#define DROPBEAR_RSA 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling rsa"
	@echo "#define DROPBEAR_RSA 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_DSS
	@echo "ptxdist: enabling dss"
	@echo "#define DROPBEAR_DSS 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling dss"
	@echo "#define DROPBEAR_DSS 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_ECDSA
	@echo "ptxdist: enabling ecdsa"
	@echo "#define DROPBEAR_ECDSA 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling ecdsa"
	@echo "#define DROPBEAR_ECDSA 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_ECDH
	@echo "ptxdist: enabling ecdh"
	@echo "#define DROPBEAR_ECDH 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling ecdh"
	@echo "#define DROPBEAR_ECDH 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_CURVE25519
	@echo "ptxdist: enabling curve25519"
	@echo "#define DROPBEAR_CURVE25519 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling curve25519"
	@echo "#define DROPBEAR_CURVE25519 0" >> $(DROPBEAR_LOCALOPTIONS)
endif


ifdef PTXCONF_DROPBEAR_PASSWD
	@echo "ptxdist: enabling passwd"
	@echo "#define DROPBEAR_SVR_PASSWORD_AUTH 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_PASSWORD_AUTH 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling passwd"
	@echo "#define DROPBEAR_SVR_PASSWORD_AUTH 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_PASSWORD_AUTH 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

ifdef PTXCONF_DROPBEAR_PUBKEY
	@echo "ptxdist: enabling pubkey"
	@echo "#define DROPBEAR_SVR_PUBKEY_AUTH 1" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_PUBKEY_AUTH 1" >> $(DROPBEAR_LOCALOPTIONS)
else
	@echo "ptxdist: disabling pubkey"
	@echo "#define DROPBEAR_SVR_PUBKEY_AUTH 0" >> $(DROPBEAR_LOCALOPTIONS)
	@echo "#define DROPBEAR_CLI_PUBKEY_AUTH 0" >> $(DROPBEAR_LOCALOPTIONS)
endif

	@$(call touch)

DROPBEAR_MAKE_OPT	:= all scp
DROPBEAR_INSTALL_OPT	:= install inst_scp

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dropbear.targetinstall:
	@$(call targetinfo)

	@$(call install_init, dropbear)
	@$(call install_fixup, dropbear,PRIORITY,optional)
	@$(call install_fixup, dropbear,SECTION,base)
	@$(call install_fixup, dropbear,AUTHOR,"Robert Schwebel <r.schwebel@pengutronix.de>")
	@$(call install_fixup, dropbear,DESCRIPTION,missing)

ifdef PTXCONF_DROPBEAR_DROPBEAR
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/sbin/dropbear)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_KEY
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dropbearkey)
endif

ifdef PTXCONF_DROPBEAR_DROPBEAR_CONVERT
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dropbearconvert)
endif

ifdef PTXCONF_DROPBEAR_SCP
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/scp)
	@$(call install_copy, dropbear, 0, 0, 0755, -, \
		/usr/bin/dbclient)
endif

#	#
#	# busybox init: start script
#	#

ifdef PTXCONF_INITMETHOD_BBINIT
ifdef PTXCONF_DROPBEAR_STARTSCRIPT
	@$(call install_alternative, dropbear, 0, 0, 0755, /etc/init.d/dropbear, n)
	@$(call install_replace, dropbear, /etc/init.d/dropbear, \
		@KEYDIR@, $(PTXCONF_DROPBEAR_KEY_DIR))
	@$(call install_alternative, dropbear, 0, 0, 0755, /etc/rc.once.d/dropbear, n)
	@$(call install_replace, dropbear, /etc/rc.once.d/dropbear, \
		@KEYDIR@, $(PTXCONF_DROPBEAR_KEY_DIR))

ifneq ($(call remove_quotes,$(PTXCONF_DROPBEAR_BBINIT_LINK)),)
	@$(call install_link, dropbear, \
		../init.d/dropbear, \
		/etc/rc.d/$(PTXCONF_DROPBEAR_BBINIT_LINK))
endif
endif
endif

	@$(call install_copy, dropbear, 0, 0, 0755, $(PTXCONF_DROPBEAR_KEY_DIR))

	@$(call install_finish, dropbear)

	@$(call touch)

# vim: syntax=make
