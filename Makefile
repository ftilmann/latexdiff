# Makefile for preparing files for distribution
#VERSION=$(shell git describe --abbrev=4 --dirty --always --tags)
VERSION=1.3.4

.PHONY: distribution release test mkdirs clean cleanall cleantest webmanual

default:
	@echo "Type:" 
	@echo "make distribution    - to prepare distribution directory dist"
	@echo "make test            - to run suite of example files to check against output of previous version"
	@echo "make release         - to prepare file" latexdiff-$(VERSION).tar.gz " for upload"
	@echo "make webmanual       - to prepare manual pdf for inclusion in webpage"
	@echo "Version:" $(VERSION)


distribution: mkdirs dist/latexdiff dist/latexrevise dist/latexdiff-so dist/latexdiff-fast dist/latexdiff-vc dist/latexdiff.1 dist/latexrevise.1 dist/latexdiff-vc.1 dist/doc/latexdiff-man.pdf dist/example/example-draft.tex dist/example/example-rev.tex dist/doc/example-diff.tex dist/doc/latexdiff-man.tex dist/COPYING dist/README dist/contrib dist/Makefile

mkdirs: dist
	mkdir -p dist/doc
	mkdir -p dist/example
#	mkdir -p dist/contrib

release: latexdiff-$(VERSION).tar.gz

dist: latexdiff-$(VERSION)
	[ ! -e dist ] || rm dist
	ln -s latexdiff-$(VERSION) dist

webmanual: htdocs/latexdiff-man.pdf

latexdiff-$(VERSION):
	mkdir -p latexdiff-$(VERSION)

htdocs/latexdiff-man.pdf: dist/doc/latexdiff-man.pdf
	cp $< $@ 

# CTAN requested that top level directory is latexdiff rather than latexdiff-x.x.x
latexdiff-$(VERSION).tar.gz: distribution
	[ ! -e prep-release-tmp ] || rm -r prep-release-tmp
	mkdir -p prep-release-tmp
	cp -r latexdiff-$(VERSION) prep-release-tmp/latexdiff 
	cd prep-release-tmp; tar -z -cvf ../latexdiff-$(VERSION).tar.gz --dereference --exclude-vcs  latexdiff
	rm -r prep-release-tmp

dist/latexdiff: latexdiff
	grep -v '^###' latexdiff > dist/latexdiff ; chmod a+x dist/latexdiff

dist/latexrevise: latexrevise
	grep -v '^###' latexrevise > dist/latexrevise ; chmod a+x dist/latexrevise

dist/latexdiff-vc: latexdiff-vc
	grep -v '^###' latexdiff-vc > dist/latexdiff-vc ; chmod a+x dist/latexdiff-vc

dist/latexdiff-so: latexdiff Algorithm-Diff-Block
	awk '/use Algorithm::Diff qw\(traverse_sequences\);/ { system("cat Algorithm-Diff-Block") ; next } { print }' latexdiff | grep -v '^###' > dist/latexdiff-so ; chmod a+x dist/latexdiff-so

dist/latexdiff-fast: latexdiff Algorithm-Diff-Fast
	awk '/use Algorithm::Diff qw\(traverse_sequences\);/ { system("cat Algorithm-Diff-Fast") ; next } { print }' latexdiff | grep -v '^###' > dist/latexdiff-fast ; chmod a+x dist/latexdiff-fast

dist/latexdiff.1: latexdiff
	pod2man -center=" " latexdiff > dist/latexdiff.1

dist/latexrevise.1: latexrevise
	pod2man -center=" " latexrevise > dist/latexrevise.1

dist/latexdiff-vc.1: latexdiff-vc
	pod2man -center=" " latexdiff-vc > dist/latexdiff-vc.1

dist/doc/latexdiff-man.pdf: latexdiff-man.tex latexdiff.tex latexdiff-vc.tex latexrevise.tex example-diff.pdf
	pdflatex latexdiff-man.tex
	pdflatex latexdiff-man.tex
	mv latexdiff-man.pdf dist/doc

dist/doc/example-diff.tex: example-diff.tex
	cp $^ $@

dist/doc/latexdiff-man.tex: latexdiff-man.tex
	cp $^ $@

dist/doc/latexdiff.tex: latexdiff.tex
	cp $^ $@

dist/doc/latexrevise.tex: latexrevise.tex
	cp $^ $@

dist/doc/latexdiff-vc.tex: latexrevise.tex
	cp $^ $@

latexdiff.tex: latexdiff
	pod2latex latexdiff; sed 's/--/-{}-/g' latexdiff.tex > tmp$$$$.tex ; mv tmp$$$$.tex latexdiff.tex

latexrevise.tex: latexrevise
	pod2latex latexrevise ; sed 's/--/-{}-/g' latexrevise.tex > tmp$$$$.tex ; mv tmp$$$$.tex latexrevise.tex

latexdiff-vc.tex: latexdiff-vc
	pod2latex latexdiff-vc; sed 's/--/-{}-/g' latexdiff-vc.tex > tmp$$$$.tex ; mv tmp$$$$.tex latexdiff-vc.tex

example-diff.pdf: example-diff.tex
	pdflatex example-diff.tex

example-diff.tex: example-draft.tex example-rev.tex dist/latexdiff
	./dist/latexdiff -t UNDERLINE example-draft.tex example-rev.tex > example-diff.tex

dist/example/example-draft.tex: example-draft.tex
	cp $< $@

dist/example/example-rev.tex: example-rev.tex
	cp $< $@

dist/README: README.md
	cp $< $@

dist/COPYING: COPYING
	cp $< $@

dist/Makefile: Makefile.dist
	cp $< $@

dist/contrib: contrib
	cp -r $< $@
# also copies hidden file	cp -r $< $@	


clean:
	\rm *.aux *.pdf *.log latexdiff.debug.* example-diff.tex latexdiff.tex latexdiff-vc.tex latexrevise.tex

cleantest:perltidy -i=2 -l=120 --cuddled-else --noblanks-before-comments --ignore-side-comment-lengths --nooutdent-long-lines -dop
	\rm testsuite/*-diff.tex  testsuite/*.{aux,log,pdf}

cleanall: clean cleantest
	\rm -r dist 

test:
	cd testsuite; ./verify --run

## perltidy setup
.perltidyrc:
	perltidy -i=2 -l=120 --cuddled-else --noblanks-before-comments --ignore-side-comment-lengths --nooutdent-long-lines -dop | grep -v dump > .perltidyrc



