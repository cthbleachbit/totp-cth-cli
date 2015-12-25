SCRIPTS		= totp-cth-cli totp-cth-zenity lib/base32decoder.lib.sh lib/io.lib.sh lib/encryption.lib.sh
SED		= /bin/sed
SHELL		= /bin/bash
PREFIX		= /usr/local
INSTALL		= /usr/bin/env install
DESTDIR		=
libdir		= $(PREFIX)/lib/totp-cth-cli
bindir		= $(PREFIX)/bin
completiondir	= $(PREFIX)/share/bash-completion/completions
applicationdir	= $(PREFIX)/share/applications
syscompletiondir= /usr/share/bash-completion/completions
sysapplicationdir= /usr/share/applications

# ======File List======
# totp-cth-cli			<- totp-cth-cli.in
# totp-cth-zenity		<- totp-cth-zenity.in
# lib/base32decoder.lib.sh	<- lib/base32decoder.lib.sh.in
# lib/io.lib.sh			<- lib/io.lib.sh.in
# lib/encryption.lib.sh		<- lib/encryption.lib.sh.in
# conf/bash-completion
# conf/totp-cth-zenity.desktop

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
	$(INSTALL) -m755 conf/totp-cth-zenity.desktop $(DESTDIR)$(sysapplicationdir)

clean: 
	rm -f $(SCRIPTS)

uninstall:
	rm -rf $(DESTDIR)$(bindir)/totp-cth-cli
	rm -rf $(DESTDIR)$(bindir)/totp-cth-zenity
	rm -rf $(DESTDIR)$(libdir)/totp-cth-cli
	rm -rf $(DESTDIR)$(syscompletiondir)/totp-cth-cli
	rm -rf $(DESTDIR)$(sysapplicationdir)/totp-cth-zenity.desktop

.PHONY: all clean install uninstall
