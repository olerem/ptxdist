#!/bin/bash
#
# Copyright (C) 2019 Sascha Hauer <s.hauer@pengutronix.de>
#
# For further information about the PTXdist project and license conditions
# see the README file.
#

#
# This is an overview over the ptxdist signing infrastructure. ptxdist
# uses PKCS#11 internally for providing access to keys and certificates.
# Packages that wish to sign something should implement a PKCS#11 interface.
#
# As PKCS#11 URIs usually differ between different usecases (release vs.
# development) the URIs normally are not hardcoded in the package
# configuration. Instead, ptxdist has the idea of "roles" which are string
# identifiers used to access a single private/public key pair and a
# certificate.
#
# ptxdist supports Hardware Security Modules (HSM). In case a HSM is not
# present or shall not be used SoftHSM is used internally to transparently
# provide the same API internally.
#
# For each role a PKCS#11 URI must be known by ptxdist. In case of a HSM
# the keys and certificates are stored in the HSM, but ptxdist needs to know
# the PKCS#11 URI to access the keys. This is done in ptxdist rule files
# calling cs_set_uri <role> <uri>. For SoftHSM the URI is generated internally
# by ptxdist, but instead the keys/certificates for each role have have to
# be imported. This is done with the cs_import_* functions below.
#
# During each invocation of ptxdist exactly one key provider is active. The
# code signing provider can be chosen with the PTXCONF_CODE_SIGNING_PROVIDER
# variable. A code signing provider is a package resposible for providing
# the role <-> PKCS#11 URI relationships in case a HSM is used or for providing
# the key material in case SoftHSM is used.
#
# A package which wants to sign something or which needs access to keys has
# to select CODE_SIGNING. This makes sure the keys are ready when the package
# is being built.
#

cs_check_env() {
    if [ -z "${SOFTHSM2_CONF}" ]; then
	ptxd_bailout "SOFTHSM2_CONF is not defined. Maybe \$(CODE_SIGNING_ENV) is not used."
    fi
    if [ ! -e "${SOFTHSM2_CONF}" ]; then
	ptxd_bailout "'${SOFTHSM2_CONF}' is missing."
    fi
    if [ -z "${PKCS11_MODULE_PATH}" ]; then
	ptxd_bailout "PKCS11_MODULE_PATH is not defined. Maybe \$(CODE_SIGNING_ENV) is not used."
    fi
    if [ ! -e "${PKCS11_MODULE_PATH}" ]; then
	ptxd_bailout "'${PKCS11_MODULE_PATH}' is missing."
    fi
}
export -f cs_check_env

#
# softhsm_pkcs11_tool_init <args>
#
# Wrapper around pkcs11-tool. To be called initially when --login
# and --pin options shall not be set.
#
softhsm_pkcs11_tool_init() {
    cs_check_env
    pkcs11-tool --module "${PKCS11_MODULE_PATH}" $*
}
export -f softhsm_pkcs11_tool_init

#
# softhsm_pkcs11_tool <args>
#
# Wrapper around pkcs11-tool. Adds --login and --pin options
#
softhsm_pkcs11_tool() {
    softhsm_pkcs11_tool_init --login --pin 1111 $*
}
export -f softhsm_pkcs11_tool

#
# cs_init_variables
#
# Initialize variables used in the code signing functions. Internal.
#
cs_init_variables() {
    sysroot="$(ptxd_get_ptxconf PTXCONF_SYSROOT_HOST)"
    keyprovider="$(ptxd_get_ptxconf PTXCONF_CODE_SIGNING_PROVIDER)"
    keydir="${sysroot}/var/lib/keys/${keyprovider}"
}
export -f cs_init_variables

#
# cs_init_softhsm
#
# Initialize SoftHSM and set the initial pin
#
cs_init_softhsm() {
    cs_check_env
    cs_init_variables
    local shsm_keys="${sysroot}/var/cache/softhsm/${keyprovider}"

    rm -rf "${shsm_keys}" &&
    rm -rf "${keydir}" &&

    sed -i "s^directories.tokendir =.*^directories.tokendir = ${shsm_keys}^" \
	${SOFTHSM2_CONF} &&

    mkdir -p "${shsm_keys}" &&

    softhsm_pkcs11_tool_init --init-token --label "${keyprovider}" --so-pin 0000 &&
    softhsm_pkcs11_tool_init -l --so-pin 0000 --new-pin 1111 --init-pin
}
export -f cs_init_softhsm

#
# cs_define_role <role>
#
# Define a new key role.
#
cs_define_role() {
    local role="${1}"
    cs_init_variables

    mkdir -p "${keydir}/${role}" &&
    # default for SoftHSM
    cs_set_uri "${role}" "pkcs11:token=${keyprovider};object=${role};pin-value=1111"
}
export -f cs_define_role

#
# cs_set_uri <role> <uri>
#
# Set the uri for a role
#
cs_set_uri() {
    local role="${1}"
    local uri="${2}"
    cs_init_variables

    echo "${uri}" > "${keydir}/${role}/uri"
}
export -f cs_set_uri

#
# cs_get_uri <role>
#
# Get the uri from a role
#
cs_get_uri() {
    local role="${1}"
    cs_init_variables

    if [ ! -f "${keydir}/${role}/uri" ]; then
	if [ ${#FUNCNAME[*]} -gt 1 ]; then
	    ptxd_bailout "No PKCS#11 URI for role ${role}"
	else
	    # ignore the error if cs_get_uri is called directly from make
	    return
	fi
    fi
    cat "${keydir}/${role}/uri"
}
export -f cs_get_uri

#
# cs_import_cert_from_der <role> <der>
#
# Import a certificate from DER file to a role. To be used
# with SoftHSM.
#
cs_import_cert_from_der() {
    local role="${1}"
    local der="${2}"
    cs_init_variables

    softhsm_pkcs11_tool --type cert --write-object "${der}" --label "${role}"
}
export -f cs_import_cert_from_der

#
# cs_import_cert_from_pem <role> <pem>
#
# Import a certificate from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_cert_from_pem() {
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    openssl x509 \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -outform der |
    softhsm_pkcs11_tool --type cert --write-object /dev/stdin --label "${role}"
}
export -f cs_import_cert_from_pem

#
# cs_import_pubkey_from_pem <role> <pem>
#
# Import a public key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_pubkey_from_pem() {
    local  -a openssl_keyopt
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    if [ -n "${OPENSSL_KEYPASS}" ]; then
	openssl_keyopt=( -passin "file:${OPENSSL_KEYPASS}" )
    fi

    openssl rsa \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -pubout -outform der |
    softhsm_pkcs11_tool --type pubkey --write-object /dev/stdin --label "${role}"
    check_pipe_status
}
export -f cs_import_pubkey_from_pem

#
# cs_import_privkey_from_pem <role> <pem>
#
# Import a private key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_privkey_from_pem() {
    local  -a openssl_keyopt
    local role="${1}"
    local pem="${2}"
    cs_init_variables

    if [ -n "${OPENSSL_KEYPASS}" ]; then
	openssl_keyopt=( -passin "file:${OPENSSL_KEYPASS}" )
    fi

    openssl rsa \
	"${openssl_keyopt[@]}" \
	-in "${pem}" -inform pem -outform der |
    softhsm_pkcs11_tool --type privkey --write-object /dev/stdin --label "${role}"
    check_pipe_status
}
export -f cs_import_privkey_from_pem

#
# cs_import_key_from_pem <role> <pem>
#
# Import a private and public key from PEM file to a role. To be used
# with SoftHSM.
#
cs_import_key_from_pem() {
    local role="${1}"
    local pem="${2}"

    cs_import_pubkey_from_pem "${role}" "${pem}"
    cs_import_privkey_from_pem "${role}" "${pem}"
}
export -f cs_import_key_from_pem
