#!/usr/bin/env perl 
#
# latexdiff-vc  - wrapper script for applying latexdiff to rcs managed files
#                 and for automatised creation of postscript or pdf from difference file
#
#   Copyright (C) 2005-12  F J Tilmann (tilmann@gfz-potsdam.de, ftilmann@users.berlios.de)
#
# Project webpages:   http://latexdiff.berlios.de/
# CTAN page:          http://www.ctan.org/tex-archive/support/latexdiff
#
#
#   Contributors: S Utcke, H Bruyninckx
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Detailed usage information at the end of the file
#
# version 1.0.2: - option --so to use latexdiff-so
# version 1.0.1 (change version numbering to match that of latexdiff)
#   - Option --fast to use latexdiff-fast, 
#   - git support (thanks to Bjørn Magnus Mathisen, Santi Béjar, Pietro Battiston and Stefan Alfredson for patches) - UNTESTED
# version 0.25:
#   - bbl is allowed as alternative extension (instead of .tex)
# version 0.26a
#   - Bug fix: it copes now correctly with the possibility that there are no changes between current
#         and archived version
use Getopt::Long ;
use Pod::Usage qw/pod2usage/ ;
use File::Temp qw/tempdir/ ;
use File::Basename qw/dirname/;
use strict ;
use warnings ;

my $versionstring=<<EOF ;
This is LATEXDIFF-VC 1.0.2
  (c) 2005-2012 F J Tilmann
EOF


# Option names
my ($version,$help,$fast,$so,$postscript,$pdf,$force,$dir,$cvs,$rcs,$svn,$git,$diffcmd,$patchcmd,@revs);
# Preset Variables
my $latexdiff="latexdiff"; # Program for making the comparison
my $vc="";
my $tempdir=tempdir(CLEANUP => 1);
# Variables
my ($file1,$file2,$diff,$diffbase,$answer,$options,$infile,$append,$dirname,$cwd);
my (@files,@ldoptions,@tmpfiles,@ptmpfiles,@difffiles); # ,

Getopt::Long::Configure('pass_through','bundling');

GetOptions('revision|r:s' => \@revs,
           'cvs' => \$cvs,
           'rcs' => \$rcs,
           'svn' => \$svn,
           'git' => \$git,
           'dir|d:s' => \$dir,
	   'fast' => \$fast,
	   'so' => \$so,
           'postscript|ps' => \$postscript,
           'pdf' => \$pdf,
           'force' => \$force,
           'version' => \$version,
	   'help|h' => \$help);

if ( $help ) {
  pod2usage(1) ;
}

if ( $version ) {
  die $versionstring ; 
}

if ( $so ) {
  $latexdiff='latexdiff-so';
}
if ( $fast ) { 
  die "Cannot specify more than one of --fast or --so " if ($so);
  $latexdiff='latexdiff-fast';
}

if ( $cvs ) {
  $vc="CVS";
}
if ( $rcs ) {
  die "Cannot specify more than one of --cvs, --rcs --svn or --git." if ($vc);
  $vc="RCS";
}
if ( $svn ) {
  die "Cannot specify more than one of --cvs, --rcs --svn or --git." if ($vc);
  $vc="SVN";
}
if ( $git ) {
  die "Cannot specify more than one of --cvs, --rcs, --svn or --git." if ($vc);
  $vc="GIT";
}


# check whether the first file name or first passed-through option for latexdiff got misinterpreted as an option to an empty -r option
if ( @revs && ( -f $revs[$#revs] || $revs[$#revs] =~ /^-/ ) ) {
  unshift @ARGV,$revs[$#revs];
  $revs[$#revs]="";
}
# check whether the first file name or first passed-through option for latexdiff got misinterpreted as an option to an empty -d option
if ( defined($dir) && ( -f $dir || $dir =~ /^-/ ) ) {
  unshift @ARGV,$dir;
  $dir="";
}

#print "DEBUG: latexdiff-vc command line: ", join(" ",@ARGV), "\n"; 

$file2=pop @ARGV;
( defined($file2) && $file2 =~ /\.(tex|bbl)$/ ) or pod2usage("Must specify at least one tex or bbl file");

if (! $vc && scalar(@revs)>0 ) {
  # have to guess $vc
  # check whether we have a special name
  if ( $0 =~ /-cvs$/ ) {
    $vc="CVS";
  } elsif ( $0 =~ /-rcs$/ ) {
    $vc="RCS";
  } elsif ( $0 =~ /-svn$/ ) {
    $vc="SVN";
  } elsif ( $0 =~ /-git$/ ) {
    $vc="GIT";
  } elsif ( -e "CVSROOT" || defined($ENV{"CVSROOT"}) ) {
    print STDERR "Guess you are using CVS ...\n";
    $vc="CVS";
  } elsif ( -e "$file2,v" ) {
    print STDERR "Guess you are using RCS ...\n";
    $vc="RCS";
  } elsif ( -d ".svn" ) {
    print STDERR "Guess you are using SVN ...\n";
    $vc="SVN";
  } elsif ( -d ".git" ) {
    print STDERR "Guess you are using GIT ...\n";
    $vc="GIT";
  } else {
    print STDERR "Cannot figure out version control system, so I default to CVS\n";
    $vc="CVS";
  }
}

if (defined($dir) && $dir=~/^\.\/?/ ) {
  print STDERR "You wrote -dir=.  but you do not really like to do that, do you ?\n";
  exit 10
}

if ( scalar(@revs)>0 ) {
  if ( $vc eq "CVS" ) { 
    $diffcmd  = "cvs diff -u -r"; 
    $patchcmd = "patch -R -p0";
  } elsif ( $vc eq "RCS" ) {
    $diffcmd  = "rcsdiff -u -r";  
    $patchcmd = "patch -R -p0";
  } elsif ( $vc eq "SVN" ) {
    $diffcmd  = "svn diff -r ";  
    $patchcmd = "patch -R -p0";
  } elsif ( $vc eq "GIT" ) {
    $diffcmd  = "git diff -r --relative --no-prefix ";  
    $patchcmd = "patch -R -p0";
    # alternatively:
    # $diffcmd  = "git diff ";
    # $patchcmd = "patch -R -p1";
  } else {
    print STDERR "Unknown versioning system $vc \n";
    exit 10;
  }
}


# make file list (last arguments), initial arguments have to be passed to latexdiff
# We assume an argument is a valid file rather than a latexdiff argument
# if it has extension .tex or .bbl

@files=($file2);
while( $file1=pop @ARGV ) {
  if ( $file1 =~ /\.(tex|bbl)$/ ) {
    # $file1 looks like a valid file name and is prepended to file list
    unshift @files, $file1 ;
  } else {
    # $file1 looks like an option for latexdiff, push it back to argument stack
    unshift @ldoptions, $file1 ;
  }
}

if ( scalar(@revs) == 0 ) {
  pod2usage("When -r option is not used, two .tex files (old and new) must be given on the command line") unless @files==2;
    #  compare two files
  $file1=shift @files ;
}

if ( scalar(@revs) == 2 ) {
  $append = "-diff$revs[0]-$revs[1]";
} elsif ( scalar(@revs) == 1 || $revs[0] ) {
  $append = "-diff$revs[0]";
} else {
  $append = "-diff";
}

if ( defined ($dir) && ! $dir ) {
  # bare -d option => choose directory name
  ($dir=$append) =~ s/^-//;
}

if ( ($vc eq "SVN" || $vc eq "CVS") && scalar(@revs)) {
  length($revs[$#revs]) > 0 or $revs[$#revs]="HEAD";
  length($revs[0]) > 0 or $revs[0]="HEAD";
}

#exit ; 


# cycle through all files

@difffiles=();
while ( $infile=$file2=shift @files ) {
  print STDERR "Working on  $infile \n";
  if ( scalar(@revs) == 1 ) {
    ($file1=$infile) =~ s/\.(tex|bbl)/-oldtmp-$$.$1/ ;
    push @tmpfiles,$file1;
    # compare file with previous version ($revs[0]="") or specified version
    ### system("$diffcmd$revs[0] $infile| $patchcmd -o$file1") ;
    if (system("$diffcmd$revs[0] $infile | $patchcmd -o$file1")==0  and -z $file1 ) {
      # no differences detected, i.e. file is equal to current version
      system("\cp $infile $file1");
    }
  } elsif ( scalar(@revs) == 2 ) {
    ($file1=$infile) =~ s/\.(tex|bbl)/-oldtmp-$$.$1/ ;
    $file2 =~ s/\.(tex|bbl)/-newtmp-$$.$1/ ;
    push @tmpfiles,$file2;
      ;
    if (system("$diffcmd$revs[1] $infile | $patchcmd -o$file2")==0 and -z $file2 ) {
      system("\cp $infile $file2");
    }
    if (system("$diffcmd$revs[0] $infile | $patchcmd -o$file1")==0 and -z $file1 ) {
	system("\cp $infile $file1");
    };
  }

  if ( -z $file1 || -z $file2) {
    print STDERR "One or both of the files to compare are empty. Possibly something went wrong in the retrieval of older versions. Aborting ...\n" ;
    exit(10);
  }

  # Get name of difference file
  if ( defined($dir) ) {
    $diff="$dir/$infile" ; 
  } else {
    ($diff=$infile) =~ s/\.(tex|bbl)$/$append.$1/ ;
  }
  # make directories if needed
  $dirname=dirname($diff) ;
  system("mkdir -p $dirname") unless ( -e $dirname );

  # Remaining options are passed to latexdiff
  $options = join(" ",@ldoptions);

  if ( -e $diff && ! $force ) {
    print STDERR "OK to overwrite existing file $diff (y/n)? ";
    $answer = <STDIN> ;
    unless ($answer =~ /^y/i ) {
      unlink @tmpfiles;
      die "Abort ... " ;
    }
  }
  print "Running $latexdiff\n";
  unless ( system("$latexdiff $options $file1 $file2 > $diff") == 0 ) { 
    print STDERR  "Something went wrong in $latexdiff. Deleting $diff and abort\n" ; unlink $diff ; exit(5) 
  };
  print "Generated difference file $diff\n";

  if ( ( $postscript or $pdf ) and !( scalar(@revs) && greptex( qr/\\document(?:class|style)/ , $diff ) ) ) {
    # save filename for later processing if postscript or pdf conversion is requested and either two-file mode was used (scalar(@revs)==0) or the diff file contains documentclass statement (ie. is a root document)
    push @difffiles, $diff ;
  }
  
  unlink @tmpfiles;
}

foreach $diff ( @difffiles ) {
  chomp($cwd=(`pwd`));
  if  (defined($dir)) {
    ( $diff =~ s/$dir\/?// ) ;
    chdir $dir ; 
  }
  @ptmpfiles=();
  ( $diffbase=$diff) =~ s/\.(tex)$// ;

  # adapt magically changebar styles to [pdftex] display driver if pdf output was selected
  if ( $pdf ) {
    system("sed \"s/Package\\[dvips\\]/Package[pdftex]/\" $diff > $diff.tmp$$ ; \\mv $diff.tmp$$ $diff");
  }
  print STDERR "PDF: $pdf Postscript: $postscript cwd $cwd\n";

  if ( system("grep -q \'^[^%]*\\\\bibliography\' $diff") == 0 ) { 
    if ( $postscript) {
      system("latex --interaction=batchmode $diff; bibtex $diffbase");
      push @ptmpfiles, "$diffbase.bbl","$diffbase.bbl" ; 
    } elsif ( $pdf ) {
      system("pdflatex --interaction=batchmode $diff; bibtex $diffbase");
      push @ptmpfiles, "$diffbase.bbl","$diffbase.bbl" ; 
    }
  }

  if ( $postscript ) {
    my $dvi="$diffbase.dvi";
    my $ps="$diffbase.ps";

    system("latex --interaction=batchmode $diff; latex $diff; dvips -o $ps $dvi");
    push @ptmpfiles, "$diffbase.aux","$diffbase.log",$dvi ;
    print "Generated postscript file $ps\n";
  } 
  elsif ( $pdf ) {
    system("pdflatex --interaction=batchmode $diff; pdflatex $diff");
    push @ptmpfiles, "$diffbase.aux","$diffbase.log";
  }
  unlink @ptmpfiles;
  chdir $cwd;
}

# greptex returns 1 if regex is not matched in filename
# 0 if there is a match
sub greptex {
  my ($regex,$filename)=@_;
  my ($i)=0;
  open (FH, $filename) or die("Couldn't open $filename: $!");
  while (<FH>) {
    next if /^\s*%/;    # skip comment lines
    if ( m/$regex/ ) {
      close(FH);
      return(0);
    }
    # only scan 25 lines
    $i++;    
    last if $i>25 ;
  }
  close(FH);
  return(1);
}


=head1 NAME

latexdiff-vc - wrapper script that calls latexdiff for different versions of a file under version management (CVS, RCS or SVN)

=head1 SYNOPSIS

B<latexdiff-vc> [ F<latexdiff-options> ] [ F<latexdiff-vc-options> ]  B<-r> [F<rev1>] [B<-r> F<rev2>]  F<file1.tex> [ F<file2.tex> ...]

 or

B<latexdiff-vc> [ F<latexdiff-options> ]  [ F<latexdiff-vc-options> ][ B<--postscript> | B<--pdf> ]  F<old.tex> F<new.tex>

=head1 DESCRIPTION

I<latexdiff-vc> is a wrapper script that applies I<latexdiff> to a
file, or multiple files under version control (CVS, RCS or SVN), and optionally runs the
sequence of C<latex> and C<dvips> or C<pdflatex> commands necessary to
produce pdf or postscript output of the difference tex file(s). It can
also be applied to a pair of files to automatise the generation of difference
file in postscript or pdf format.

=head1 OPTIONS

=over 4

=item B<--rcs>, B<--svn>, B<--cvs>, or B<--git>

Set the version system. 
If no version system is specified, latexdiff-vc will venture a guess.

latexdiff-cvs and latexdiff-rcs are variants of latexdiff-vc which default to 
the respective versioning system. However, this default can still be overridden using the options above.

=item B<-r>, B<-r> F<rev> or B<--revision>, B<--revision=>F<rev>

Choose revision (under RCS, CVS, SVN or GIT). One or two B<-r> options can be
specified, and they result in different behaviour:

=over 4

=item B<latexdiff-vc> -r F<file.tex> ...

compares F<file.tex> with the most recent version checked into RCS.

=item B<latexdiff-vc> -r F<rev1> F<file.tex> ...

compares F<file.tex> with revision F<rev1>.

=item B<latexdiff-vc> -r F<rev1> -r F<rev2> F<file.tex> ...

compares revisions F<rev1> and F<rev2> of F<file.tex>.

Multiple files can be specified for all of the above options. All files must have the
extension C<.tex>, though.

=item B<latexdiff-vc>  F<old.tex> F<new.tex>

compares two files.

=back

The name of the difference file is generated automatically and
reported to stdout.

=item B<-d> or B<--dir>  B<-d> F<path> or B<--dir=>F<path>

Rather than appending the string C<diff> and optionally the version
numbers given to the output-file, this will prepend a directory name C<diff> 
to the
original filename, creating the directory and subdirectories should they not exist already.  This is particularly useful in order to clone a
complete directory hierarchy.  Optionally, a pathname F<path> can be specified, which is prepended instead of C<diff>.

=item B<--fast> or B<--so>

Use C<latexdiff-fast> or C<latexdiff-so>, respectively (instead of C<latexdiff>).

=item B<--ps> or B<--postscript>

Generate postscript output from difference file.  This will run the
sequence C<latex; latex; dvips> on the difference file (do not use
this option in the rare cases, where three C<latex> commands are
required if you care about correct referencing).  If the difference
file contains a C<\bibliography> tag, run the sequence C<latex;
bibtex; latex; latex; dvips>.

=item B<--pdf>

Generate pdf output from difference file using C<pdflatex>. This will
run the sequence C<pdflatex; pdflatex> on the difference file, or
C<pdflatex; bibtex; pdflatex; pdflatex> for files requiring bibtex.

=item B<--force>

Overwrite existing diff files without asking for confirmation. Default 
behaviour is to ask for confirmation before overwriting an existing difference
file.

=item B<--help> or
B<-h>

Show help text

=item B<--version>

Show version number

=back

All other options are passed on to C<latexdiff>.

=head1 SEE ALSO

L<latexdiff>

=head1 PORTABILITY

I<latexdiff-vc> uses external commands and is therefore
limited to Unix-like systems. It also requires the RCS version control
system and latex to be installed on the system.  Modules from Perl 5.8
or higher are required.

=head1 BUG REPORTING

 Please submit bug reports through
the latexdiff project page I<http://developer.berlios.de/projects/latexdiff/> or send
to I<tilmann@gfz-potsdam.de>.  Include the serial number of I<latexdiff-vc>
(option C<--version>)
.
=head1 AUTHOR

Copyright (C) 2005,2012 Frederik Tilmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License Version 3
Contributors: S Utcke, H Bruyninckx

=cut

