SCRIPTS		= totp-cth-cli totp-cth-zenity lib/base32decoder.lib.sh lib/io.lib.sh lib/encryption.lib.sh
SED		= /bin/sed
SHELL		= /bin/bash
PREFIX		= /usr/local
INSTALL		= /usr/bin/env install
DESTDIR		=
libdir		= $(PREFIX)/lib/totp-cth-cli
bindir		= $(PREFIX)/bin
completiondir	= ${PREFIX}/share/bash-completion/completions
syscompletiondir= /usr/share/bash-completion/completions


all: $(SCRIPTS)

$(SCRIPTS): ${SCRIPTS:=.in}
	@echo '	GEN' $@
	@$(SED) -e 's|@libdir@|$(libdir)|g' \
	        $@.in > $@

install: $(SCRIPTS)
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(libdir)
	$(INSTALL) -d $(DESTDIR)$(completiondir)
	$(INSTALL) -m755 totp-cth-cli $(DESTDIR)$(bindir)/totp-cth-cli
	$(INSTALL) -m755 totp-cth-zenity $(DESTDIR)${bindir}/totp-cth-zenity
	$(INSTALL) -m644 lib/base32decoder.lib.sh $(DESTDIR)$(libdir)/
	$(INSTALL) -m644 lib/io.lib.sh $(DESTDIR)$(libdir)/
	$(INSTALL) -m644 lib/encryption.lib.sh $(DESTDIR)$(libdir)/
	$(INSTALL) -m644 conf/bash-completion $(DESTDIR)$(syscompletiondir)/totp-cth-cli

clean: 
	rm -f $(SCRIPTS)

uninstall:
	rm -rf $(DESTDIR)$(bindir)/totp-cth-cli
	rm -rf $(DESTDIR)$(bindir)/totp-cth-zenity
	rm -rf $(DESTDIR)$(libdir)/totp-cth-cli
	rm -rf $(DESTDIR)$(syscompletiondir)/totp-cth-cli

.PHONY: all clean install uninstall
