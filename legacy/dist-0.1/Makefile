# Modify these paths to the requirements of your own system
# For the current setting you will need root permission but 
# it is perfectly acceptable to choose user directories 
#
INSTALLPATH = /usr/local
INSTALLMANPATH = $(INSTALLPATH)/man
INSTALLEXECPATH = $(INSTALLPATH)/bin

default:
	@echo "To install standard version type:    make install"
	@echo "  (Note the standard version requires prior installation"
	@echo "   of the PERL package Algorithm::Diff available from "
	@echo "   the PERL archive www.cpan.org)"
	@echo " "
	@echo "To install stand alone version type: make install-so"
	@echo " "

install: install-latexdiff install-latexrevise install-man

install-so: install-latexdiff-so install-latexrevise install-man

install-man:
	install latexrevise.1 latexdiff.1 $(INSTALLMANPATH)/man1

install-latexdiff:
	install latexdiff $(INSTALLEXECPATH)

install-latexdiff-so:
	if [ -e $(INSTALLEXECPATH)/latexdiff ]; then rm $(INSTALLEXECPATH)/latexdiff; fi
	install latexdiff-so $(INSTALLEXECPATH)
	cd $(INSTALLEXECPATH); ln -s latexdiff-so latexdiff

install-latexrevise:
	install latexrevise $(INSTALLEXECPATH)
