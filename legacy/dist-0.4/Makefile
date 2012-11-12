# Modify these paths to the requirements of your own system
# For the current setting you will need root permission but 
# it is perfectly acceptable to choose user directories 
#
INSTALLPATH = /usr/local
INSTALLMANPATH = $(INSTALLPATH)/man
INSTALLEXECPATH = $(INSTALLPATH)/bin

default:
	@echo "To install stand-alone version type:    make install"
	@echo "  (Note the standard version requires prior installation"
	@echo "   of the PERL package Algorithm::Diff available from "
	@echo "   the PERL archive www.cpan.org)"
	@echo " "
	@echo "To install fast version (using UNIX diff) type: make install fast "
	@echo " "
	@echo "To install the version which uses the system Algorithm::Diff package type: make install-ext"
	@echo " "

install: install-so

install-ext: install-latexdiff install-latexrevise install-latexdiff-vc install-man

install-so: install-latexdiff-so install-latexrevise install-latexdiff-vc install-man

install-fast: install-latexdiff-fast install-latexrevise install-latexdiff-vc install-man

install-man:
	install latexrevise.1 latexdiff.1 latexdiff-vc.1 $(INSTALLMANPATH)/man1

install-latexdiff:
	install latexdiff $(INSTALLEXECPATH)

install-latexdiff-so:
	if [ -e $(INSTALLEXECPATH)/latexdiff ]; then rm $(INSTALLEXECPATH)/latexdiff; fi
	install latexdiff-so $(INSTALLEXECPATH)
	cd $(INSTALLEXECPATH); ln -s latexdiff-so latexdiff

install-latexdiff-fast:
	if [ -e $(INSTALLEXECPATH)/latexdiff ]; then rm $(INSTALLEXECPATH)/latexdiff; fi
	install latexdiff-fast $(INSTALLEXECPATH)
	cd $(INSTALLEXECPATH); ln -s latexdiff-fast latexdiff

install-latexrevise:
	install latexrevise $(INSTALLEXECPATH)

install-latexdiff-vc:
	install latexdiff-vc $(INSTALLEXECPATH)
	cd $(INSTALLEXECPATH); for vcs in cvs rcs svn ; do if [ -e latexdiff-$$vcs ]; then rm latexdiff-$$vcs; fi; ln -s latexdiff-vc latexdiff-$$vcs ; done

test-ext: 
	@echo "latexdiff example/example-draft.tex example/example-rev.tex (system Algorithm::Diff)"
	./latexdiff -V example/example-draft.tex example/example-rev.tex > example/example-diff.tex
	@echo "Difference file created: example/example-diff.tex"

test-so: 
	@echo "latexdiff example/example-draft.tex example/example-rev.tex (stand-alone version)"
	./latexdiff-so -V example/example-draft.tex example/example-rev.tex > example/example-diff.tex
	@echo "Difference file created: example/example-diff.tex"

test-fast: 
	@echo "latexdiff example/example-draft.tex example/example-rev.tex (stand-alone version)"
	./latexdiff-fast -V example/example-draft.tex example/example-rev.tex > example/example-diff.tex
	@echo "Difference file created: example/example-diff.tex"
