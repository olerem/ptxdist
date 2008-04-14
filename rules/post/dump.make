# -*-makefile-*-

# ----------------------------------------------------------------------------
# environment export to plugins and shell scripts
# ----------------------------------------------------------------------------
# If you run 'ptxdist make dump', you will get two files:
# $(STATEDIR)/environment.symbols <- A list of all internal Variable
#                                    Symbols in the main PTXdist Makefile
# $(STATEDIR)/environment.bash    <- A selection of Variables in bash
#				     syntax. Please adjust M2B_DUMP_VARIABLES
#				     and M2B_DUMP_SUFFIXES to your needs.
#				     See rules/other/Definitions.make
# ----------------------------------------------------------------------------
#
# dump all internal make symbols
#
$(M2B).symbols:
	@echo "$(.VARIABLES)" 		\
	| sed s/\ /\\n/g 		\
	| egrep -v "[^A-Z0-9_-]|^_$$" 	\
	| sort -u > $@

dump-symbols: $(M2B).symbols

#
# dump selected symbols with value
#
packages	:= $(PACKAGES-) $(PACKAGES-y) $(PACKAGES-m)
prefixes	:= $(shell echo $(packages) | tr "a-z-" "A-Z_")
symbols		:= $(foreach prefix,$(prefixes),$(foreach suffix,$(M2B_DUMP_SUFFIXES),$(prefix)$(suffix)))
allsymbols	:= $(prefixes) $(shell echo $(symbols) | tr "a-z-" "A-Z_") $(M2B_DUMP_VARIABLES)
sources		:= $(addsuffix _SOURCE,$(shell echo $(SELECTED_PACKAGES) | tr "a-z-" "A-Z_"))

dump-%: $(M2B).symbols
	@echo 'M2B_$(call remove_quotes,$(*))="$(call remove_quotes,$($(*)))"' >> $(M2B).bash.tmp
	@echo '$(call remove_quotes,$(*)) $(call remove_quotes,$($(*)))' >> $(M2B).tmp

dump: $(addprefix dump-,$(allsymbols))
	@mv $(M2B).bash.tmp $(M2B).bash
	@mv $(M2B).tmp $(M2B)

# vim600:set foldmethod=marker:
# vim600:set syntax=make:
