SCRIPTS		= totp-cth-cli lib/base32decoder.lib.sh lib/io.lib.sh
SED		= /bin/sed
SHELL		= /bin/bash
PREFIX		= /usr/local
SED		= /bin/sed
INSTALL		= /usr/bin/env install
DESTDIR		=
libdir		= $(PREFIX)/lib
bindir		= $(PREFIX)/bin


all: $(SCRIPTS)

$(SCRIPTS): ${SCRIPTS:=.in}
	@echo '	GEN' $@
	@$(SED) -e 's|@libdir@|$(libdir)|g' \
	        $@.in > $@

install: $(SCRIPTS)
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(libdir)/totp-cth-cli
	$(INSTALL) -m755 totp-cth-cli $(DESTDIR)$(bindir)/totp-cth-cli
	$(INSTALL) -m644 lib/base32decoder.lib.sh $(DESTDIR)$(libdir)/totp-cth-cli/
	$(INSTALL) -m644 lib/io.lib.sh $(DESTDIR)$(libdir)/totp-cth-cli/

clean: 
	rm -f $(SCRIPTS)

.PHONY: all clean install
