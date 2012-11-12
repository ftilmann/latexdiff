# Modify these paths to the requirements of your own system
# For the current setting you will need root permission but 
# it is perfectly acceptable to choose user directories 
#
INSTALLPATH = /usr/local
INSTALLMANPATH = $(INSTALLPATH)/man
INSTALLEXECPATH = $(INSTALLPATH)/bin

default:
	@echo "To install stand-alone version type:    make install"
	@echo " "
	@echo "To install the version which uses the system Algorithm::Diff package type: make install-ext"
	@echo "  (Note this version requires prior installation"
	@echo "   of the PERL package Algorithm::Diff available from "
	@echo "   the PERL archive www.cpan.org)"
	@echo " "

install: install-so

install-ext: install-latexdiff install-latexrevise install-latexdiff-cvs install-man

install-so: install-latexdiff-so install-latexrevise install-latexdiff-cvs install-man

install-man:
	install latexrevise.1 latexdiff.1 latexdiff-cvs.1 $(INSTALLMANPATH)/man1

install-latexdiff:
	install latexdiff $(INSTALLEXECPATH)

install-latexdiff-so:
	if [ -e $(INSTALLEXECPATH)/latexdiff ]; then rm $(INSTALLEXECPATH)/latexdiff; fi
	install latexdiff-so $(INSTALLEXECPATH)
	cd $(INSTALLEXECPATH); ln -s latexdiff-so latexdiff

install-latexrevise:
	install latexrevise $(INSTALLEXECPATH)

install-latexdiff-cvs:
	install latexdiff-cvs $(INSTALLEXECPATH)

test: test-so

test-ext: 
	@echo "latexdiff example/example-draft.tex example/example-rev.tex (system Algorithm::Diff)"
	./latexdiff -V example/example-draft.tex example/example-rev.tex > example/example-diff.tex
	@echo "Difference file created: example/example-diff.tex"

test-so: 
	@echo "latexdiff example/example-draft.tex example/example-rev.tex (stand-alone version)"
	./latexdiff-so -V example/example-draft.tex example/example-rev.tex > example/example-diff.tex
	@echo "Difference file created: example/example-diff.tex"
