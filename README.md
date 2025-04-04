latexdiff
=========

Compares two latex files and marks up significant differences between them. Releases on https://ctan.org/pkg/latexdiff and mirrors.

Link to full manual: http://mirrors.ctan.org/support/latexdiff/doc/latexdiff-man.pdf


INTRODUCTION
------------

latexdiff is a Perl script, which compares two latex files and marks
up significant differences between them (i.e. a diff for latex files).
  Various options are available for visual markup using standard latex 
packages such as "color.sty". Changes not directly affecting visible 
text, for example in formatting commands, are still marked in 
the latex source. Note that only files conforming to latex syntax will 
be processed correctly, not generic TeX files. Some further 
minor restrictions apply, see documentation.
 
A rudimentary revision facility is provided by another Perl script,
latexrevise, which accepts or rejects all changes.  Manual
editing of the difference file can be used to override this default
behaviour and accept or reject selected changes only.  

The author is F Tilmann. 


REQUIREMENTS
------------

Perl 5.8 or higher must be installed.
  The latexdiff script makes use of the Perl package Algorithm::Diff (available 
from www.cpan.org, current version 1.19). You can either install this package, or
use the standalone version of latexdiff, latexdiff-so, which has version 1.15 of 
this package inlined and does not require external installation of
the package. Because latexdiff uses internal functions of Algorithm:Diff whose 
calling format or availability can change without notice, the preferred method is
now to use the standalone version.

As an alternative, latexdiff-fast has a modified version of Algorithm::Diff inlined,
which internally uses the UNIX diff command.  This version is much faster but is dependent
on an external "diff" command.  Subtle differences in the algorithm of Algorithm::Diff and 
UNIX-diff mean that the resulting set of differences will generally not be the same as
for the standard latexdiff.  In most practical cases, these differences are minor, though.

INSTALLATION UNIX/LINUX
-----------------------

The basic installation procedure is almost trivial:

1. Copy latexdiff, latexrevise and latexdiff-vc into a directory which
   is in the search path and make them executable.  If the Algorithm::Diff
   package is not installed, use latexdiff-so instead of latexdiff. 

2. Copy latexdiff.1 and latexrevise.1 into the correct man directory

3. Optionally create soft links latexdiff-cvs latexdiff-rcs, latexdiff-git
   latexdiff-svn and latexdiff-hg for latexdiff-vc.

The attached trivial Makefile contains example commands to carry out above 
steps as root for a typical UNIX installation. Type 

  `make install`          (for the stand alone version)
  
or

  `make install-ext`      (for the version using the external Algorithm::Diff)

or

  `make install-fast`     (for the version using the UNIX 'diff' function for fast differencing)

to get it rolling.  You can type

  `make test` or
  
  `make test-ext` or

  `make test-fast`

to test the respective versions on a brief example before installation. It will often be
as easy to carry out these steps manually instead of using the Makefile.


DOCUMENTATION
-------------

Usage instructions are in the manual latexdiff-man.pdf as well as the 
man pages.

CHANGELOGS
----------
Check out the comment lines at the beginning of the perl scripts (latexdiff, latexdiff-vc, latexrevise)

CONTRIBUTIONS
-------------

The directory contrib contains code written by others relating to latexdiff.  
Currently this directory contains:

latexdiff-wrap (Author: V. Kuhlmann) An alternative wrapper script which can be used
  instead of latexdiff-vc.  Its main use is as a template for customised wrapper scripts.

latexdiff.spec (Author: T. Doerges) spec file for RPM generation

latexchanges (Author: Jan-Ake Larsson) Wrapper script for applying latexdiff with numbered document version 
(see contrib/README.latexchanges for a more detailed description)

Contributions by the following authors were incorporated into the latexdiff code, or inspired me to 
extend latexdiff in a similar way: J. Paisley, N. Becker, K. Huebner

EXTERNAL LATEXDIFF SUPPORT PROGRAMS
-----------------------------------

LATEXDIDFFR (Author: David Hugh-Jones) is a small library that uses the latexdiff command to create a diff of two Rmarkdown, .Rnw or TeX files.
https://github.com/hughjonesd/latexdiffr

LATEXDIFFCITE (Author: Christer van der Meeren)  is a wrapper around latexdiff to make citations diff properly. It works by expanding \cite type commands using the bbl or bib file, such that citations are treated just like normal text rather than as atomic in the plain latexdiff.
https://github.com/twilsonco/latexdiffcite

GIT-LATEXDIFF (lead author: Matthieu Moy) is a wrapper (bash script) around latexdiff that allows using it to diff two revisions of a LaTeX file under git revision control (similar functionality is provided by latexdiff-vc --git with --flatten option included with this distribution but git-latexdiff allows more fine-grained control on (not to be confused with latexdiff-git, which is normally installed as a soft link to latexdiff-vc) 
https://gitlab.com/git-latexdiff/git-latexdiff

WISHING TO CONTRIBUTE
---------------------
Pull requests are welcome. Please see the Wiki page: https://github.com/ftilmann/latexdiff/wiki  for some more detailed information.

LICENSE
-------
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License Version 3 as published by
the Free Software Foundation.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details (file LICENSE in the
distribution).




