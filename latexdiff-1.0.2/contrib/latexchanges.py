#! /bin/env python
# latexchanges
#
# Wrapper for latexdiff, intended as a drop-in replacement for latex,
# when you have several numbered (or dated) versions of a manuscript.
# My coauthors don't as a rule know what CVS or SVN is, they simply
# use a number or date for the different versions.
#
# latexchanges replaces the current DVI with one that includes a
# latexdiff to the last version. The last version is selected as the
# TEX file in the same directory with the same prefix (up to a number
# or a dot), that has an mtime immediately preceding the given TEX
# file.
#
# (I should probably add CVS version numbering too, at some point.)
#
# Copyright (C) 2009 by Jan-\AA{}ke Larsson <jan-ake.larsson@liu.se>
# Released under the terms of the GNU General Public License (GPL)
# Version 2.  See http://www.gnu.org/ for details.
#
# Please do provide patches and bug reports, but remember: if it
# breaks, you get to keep the pieces.
#
# Jan-\AA{}ke Larsson
# Sept 16 2009

from os import listdir,system,stat
from sys import argv
from re import split

name=""
newarg=[]

# Find filename argument
for i in range(1,len(argv)):
    if argv[i][-4:]==".tex":
        basename=split('[0-9.]',argv[i])[0]
        name=argv[i][:-4]
        newarg.append(name+".changes.tex")
    else:
        newarg.append(argv[i])

if name:
    print "Filename",name+".tex"
    print "Prefix is",basename
    # Find last archived version
    mtime=stat(name+".tex").st_mtime
    old_mtime=0
    ls=listdir(".")
    for j in ls:
        if j.startswith(basename) and j.endswith(".tex")\
               and not j.endswith(".changes.tex"):
            tmptime=stat(j).st_mtime
            if mtime>tmptime and old_mtime<tmptime:
                oldname=j
                old_mtime=tmptime

    # Archived version found?
    if old_mtime>0:
        print "Comparing with",oldname
        system ("/bin/cp "+name+".aux "+name+".changes.aux")
        system ("/bin/cp "+name+".bbl "+name+".changes.bbl")
        system ("latexdiff "+oldname+" "+name+".tex > "+name+".changes.tex")
        system ("latex "+" ".join(newarg))
        system ("cp "+name+".changes.dvi "+name+".dvi")
    else:
        system ("latex "+" ".join(argv[1:]))
