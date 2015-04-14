#!/usr/bin/env perl 
#
# latexdiff-vc  - wrapper script for applying latexdiff to rcs managed files
#                 and for automatised creation of postscript or pdf from difference file
#
#   Copyright (C) 2005-13  F J Tilmann (tilmann@gfz-potsdam.de)
#
# Repository:         https://github.com/ftilmann/latexdiff
# CTAN page:          http://www.ctan.org/tex-archive/support/latexdiff
#
#
#   Contributors: S Utcke, H Bruyninckx, C Junghans
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
# version 1.1.0:
#
#      - with option --flatten and version control option, checkout the whole tree into a temporary directory
#        (use svn info + checkout ; git archive )
#       - add option --only-changes to output only changed pages (in combination with --ps or --pdf option)
# version 1.0.4:
#	- [ Patch #3486 contributed by cbarbu] add additional compilation for styles using chbar + avoid pdf/postscripts repeat in the code
# version 1.0.3: Bug fix: replace use of system('cp...') with File::Copy::copy (Patch contributed by D. Bremner)
#                 Quotes around system call file arguments to allow filenames with spaces (Patch contributed by ssteve)
# version 1.0.2: - option --so to use latexdiff-so
# version 1.0.1 (change version numbering to match that of latexdiff)
#   - Option --fast to use latexdiff-fast, 
#   - git support (thanks to Bjorn Magnus Mathisen, Santi Béjar, Pietro Battiston and Stefan Alfredson for patches) - UNTESTED
# version 0.25:
#   - bbl is allowed as alternative extension (instead of .tex)
# version 0.26a
#   - Bug fix: it copes now correctly with the possibility that there are no changes between current
#         and archived version
use Getopt::Long ;
use Pod::Usage qw/pod2usage/ ;
use File::Temp qw/tempdir/ ;
use File::Basename qw/dirname/;
use File::Copy;

use strict ;
use warnings ;

my $versionstring=<<EOF ;
This is LATEXDIFF-VC 1.1.0
  (c) 2005-2015 F J Tilmann
EOF


# Option names
my ($version,$help,$fast,$so,$postscript,$pdf,$onlychanges,$flatten,$force,$dir,$cvs,$rcs,$svn,$git,$hg,$diffcmd,$patchcmd,@revs);
# Preset Variables
my $latexdiff="latexdiff"; # Program for making the comparison
my $latexcmd="latex"; # latex compiler if not further identified
my $vc="";
my $tempdir=tempdir(CLEANUP => 1);   # generate a temp dir, which will automatically be deleted at program exit
# Variables
my ($file1,$file2,$diff,$diffbase,$rootdir,$answer,$options,$infile,$append,$dirname,$cwd);
my (@files,@ldoptions,@tmpfiles,@ptmpfiles,@difffiles,$extracomp); # ,

Getopt::Long::Configure('pass_through','bundling');

GetOptions('revision|r:s' => \@revs,
           'cvs' => \$cvs,
           'rcs' => \$rcs,
           'svn' => \$svn,
           'git' => \$git,
           'hg' => \$hg,
           'dir|d:s' => \$dir,
	   'fast' => \$fast,
	   'so' => \$so,
           'postscript|ps' => \$postscript,
           'pdf' => \$pdf,
           'force' => \$force,
	   'only-changes' => \$onlychanges,
	   'flatten:s' => \$flatten,
           'version' => \$version,
	   'help|h' => \$help);

$extracomp = join(" ",grep(/BAR/,@ARGV)); # special latexdiff options requiring additional compilation

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
  die "Cannot specify more than one of --cvs, --rcs, --svn --git or --hg." if ($vc);
  $vc="RCS";
}
if ( $svn ) {
  die "Cannot specify more than one of --cvs, --rcs, --svn --git or --hg." if ($vc);
  $vc="SVN";
}
if ( $git ) {
  die "Cannot specify more than one of --cvs, --rcs, --svn --git or --hg." if ($vc);
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
# check whether the first file name or first passed-through option for latexdiff got misinterpreted as an option to an empty --flatten option
if ( defined($flatten) && ( -f $flatten || $flatten =~ /^-/ ) ) {
  unshift @ARGV,$flatten;
  $flatten="";
}


#print "DEBUG: latexdiff-vc command line: ", join(" ",@ARGV), "\n"; 

$file2=pop @ARGV;
( defined($file2) && $file2 =~ /\.(tex|bbl|flt)$/ ) or pod2usage("Must specify at least one tex, bbl or flt file");

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
  } elsif ( $0 =~ /-hg$/ ) {
    $vc="HG";
  } elsif ( -e "$file2,v" ) {
    print STDERR "Guess you are using RCS ...\n";
    $vc="RCS";
  } elsif ( -d ".svn" ) {
    print STDERR "Guess you are using SVN ...\n";
    $vc="SVN";
  } elsif ( -d ".git" ) {
    print STDERR "Guess you are using GIT ...\n";
    $vc="GIT";
  } elsif ( -d ".hg" ) {
    print STDERR "Guess you are using HG ...\n";
    $vc="HG";
  } elsif ( -e "CVSROOT" || defined($ENV{"CVSROOT"}) ) {
    print STDERR "Guess you are using CVS ...\n";
    $vc="CVS";
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
  } elsif ( $vc eq "HG" ) {
    $diffcmd  = "hg diff -r";
    $patchcmd = "patch -R -p1";
  } else {
    print STDERR "Unknown versioning system $vc \n";
    exit 10;
  }
}


# make file list (last arguments), initial arguments have to be passed to latexdiff
# We assume an argument is a valid file rather than a latexdiff argument
# if it has extension .tex, .bbl or .flt (output of flatex)

@files=($file2);
while( $file1=pop @ARGV ) {
  if ( $file1 =~ /\.(tex|bbl|flt)$/ ) {
    # $file1 looks like a valid file name and is prepended to file list
    unshift @files, $file1 ;
  } else {
    # $file1 looks like an option for latexdiff, push it back to argument stack
    unshift @ldoptions, $file1 ;
  }
}

if ( defined($flatten) ) {
  push @ldoptions, "--flatten" ;
}

# impose ZLABEL subtype if --only-changes option
if ( $onlychanges ) {
  push @ldoptions, "-s", "ZLABEL" ;
}

if ( scalar(@revs) == 0 ) {
  pod2usage("When -r option is not used, two .tex files (old and new) must be given on the command line") unless @files==2;
  warn "Option -flatten should normally be combined with -r option (Results will probably not be as expected)" if $flatten;
    #  compare two files
  $file1=shift @files ;
} else {
  # revision control
  if ( $flatten ) {
    pod2usage("Only one root file must be given  if --flatten option is used with version control") if  @files != 1;
    $tempdir='.' if ( $flatten eq "keep-intermediate" );
    print "flatten tempdir |$tempdir|";
    if ( $vc eq "SVN" ) {
      my (@infoout)=`svn info`;
      my (@urlline) = grep(/^URL:/, @infoout);
      @urlline ==1 or die "Ambiguous output from svn info command."; 
      ( $rootdir = $urlline[0] ) =~ s/URL:\s*// ;
      chomp $rootdir;
    } elsif ( $vc eq "GIT" || $vc eq "HG" ) {
      # do nothing
    } else {
      die "--flatten option with revision control only possible with SVN, HG and GIT modes";
    }
  }
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
    if ( defined($flatten) ) {
       my $olddir=$tempdir . "/latexdiff-vc-$revs[0]";
       print STDERR "Checking out old dir into: $olddir (rev: $revs[0])\n";
       checkout_dir($revs[0],$olddir);
       $file1=$olddir ."/".$infile;
     } else {
       ($file1=$infile) =~ s/\.(tex|bbl|flt)/-oldtmp-$$.$1/ ;
       push @tmpfiles,$file1;
       # compare file with previous version ($revs[0]="") or specified version
       ### system("$diffcmd$revs[0] $infile| $patchcmd -o$file1") ;
       if (system("$diffcmd$revs[0] \"$infile\" | $patchcmd -o\"$file1\"")==0  and -z $file1 ) {
	 # no differences detected, i.e. file is equal to current version
	 copy($infile,$file1) || die "copy($infile,$file1) failed: $!";
       }
     }
  } elsif ( scalar(@revs) == 2 ) {
    if ( defined($flatten) ) {
      my $olddir=$tempdir . "/latexdiff-vc-$revs[0]";
      print STDERR "Checking out old dir into: $olddir (rev: $revs[0])\n";
      checkout_dir($revs[0],$olddir);
      $file1=$olddir ."/".$infile;

      my $newdir=$tempdir . "/latexdiff-vc-$revs[1]";
      print STDERR "Checking out new dir into: $newdir\n";
      checkout_dir($revs[1],$newdir);
      $file2=$newdir ."/".$infile;
    } else {
      ($file1=$infile) =~ s/\.(tex|bbl|flt)/-oldtmp-$$.$1/ ;
      $file2 =~ s/\.(tex|bbl|flt)/-newtmp-$$.$1/ ;
      push @tmpfiles,$file2;
      if (system("$diffcmd$revs[1] $infile | $patchcmd -o$file2")==0 and -z $file2 ) {
	copy($infile,$file2) || die "copy($infile,$file2) failed: $!";
      }
      if (system("$diffcmd$revs[0] $infile | $patchcmd -o$file1")==0 and -z $file1 ) {
	copy($infile,$file1) || die "copy($infile,$file1) failed: $!";
      };
    }
  }

  if ( -z $file1 || -z $file2) {
    print STDERR "One or both of the files to compare are empty. Possibly something went wrong in the retrieval of older versions. Aborting ...\n" ;
    exit(10);
  }

  # Get name of difference file
  if ( defined($dir) ) {
    $diff="$dir/$infile" ; 
  } else {
    ($diff=$infile) =~ s/\.(tex|bbl|flt)$/$append.$1/ ;
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
  unless ( system("$latexdiff $options \"$file1\" \"$file2\" > \"$diff\"") == 0 ) { 
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
    system("sed \"s/Package\\[dvips\\]/Package[pdftex]/\" \"$diff\" > \"$diff.tmp$$\" ; \\mv \"$diff.tmp$$\" \"$diff\"");
    $latexcmd = "pdflatex";
  } elsif ( $postscript ) {
    $latexcmd = "latex";
  }

  if ( $pdf | $postscript ) {
  print STDERR "PDF: $pdf Postscript: $postscript cwd $cwd\n";

  if ( system("grep -q \'^[^%]*\\\\bibliography\' \"$diff\"") == 0 ) { 
    system("$latexcmd --interaction=batchmode \"$diff\"; bibtex \"$diffbase\";");
    push @ptmpfiles, "$diffbase.bbl","$diffbase.bbl" ; 
  }

  # if special needs, as CHANGEBAR
  if ( $extracomp ) {
    # print "Extracomp\n";
    system("$latexcmd --interaction=batchmode \"$diff\";");
  }

  # final compilation
  system("$latexcmd --interaction=batchmode \"$diff\";"); # needed if cross-refs
  system("$latexcmd \"$diff\";"); # final, with possible error messages

  if ( $postscript ) {
    my $dvi="$diffbase.dvi";
    my $ps="$diffbase.ps";
    my $ppoption="";

    if ( $onlychanges ) {
      $ppoption="-pp ".join(",",findchangedpages("$diffbase.aux"));
    }
    system("dvips $ppoption -o $ps $dvi");
    push @ptmpfiles, "$diffbase.aux","$diffbase.log",$dvi ;
    print "Generated postscript file $ps\n";
  } 
  elsif ( $pdf ) {
    if ( $onlychanges ) {
      my @pages=findchangedpages("$diffbase.aux");
      system ("pdftk \"$diffbase.pdf\" cat " . join(" ",@pages) . " output \"$diffbase-changedpage.pdf\"")==0 or 
               die ("Could not execute <pdftk $diffbase.pdf cat " . join(" ",@pages) . " output $diffbase-changedpage.pdf> . Return code: $?");
      move("$diffbase-changedpage.pdf","$diffbase.pdf");
    }
    push @ptmpfiles, "$diffbase.aux","$diffbase.log";
  }
  }
  unlink @ptmpfiles;
  chdir $cwd;
}

# findchangedpages($auxfile)
# returns a list of the page numbers on which changes were marked with the ZLABEL subtype of latexdiff
sub findchangedpages {
  my ($auxfile) =@_;
  my $j;
  my (%pages);		# note that I use a hash with page numbers as keys and arbitrary values - this way I can use perl's built-in functions to get red of duplicates
  my %start;
  open(AUX,$auxfile) or die ("Could open aux file $auxfile . System error: $!");
  while (<AUX>) {
    if (m/\\zref\@newlabel{DIFchgb(\d*)}{.*\\abspage{(\d*)}}/ ) { 
      $start{$1}=$2; $pages{$2}=1;
    }
    if (m/\\zref\@newlabel{DIFchge(\d*)}{.*\\abspage{(\d*)}}/) { 
      if (defined($start{$1})) {
	for ($j=$start{$1}; $j<=$2; $j++) {
	  $pages{$j}=1;
	}
      } else {
	$pages{$2}=1;
      }
    }
  }
  close(AUX);
  # sort pages numerically (they should be sorted already; this is just to make sure
  return(sort {$a <=> $b} keys(%pages));
}

# checkout_dir(rev,dirname)
# checks out revision rev and stores it in dirname
# uses global variables: $vc, $rootdir
sub checkout_dir {
  my ($rev,$dirname)=@_;

  unless (-e $dirname) { mkdir $dirname or die "Cannot mkdir $dirname ." ;}
  if ( $vc eq "SVN" ) {
    system("svn checkout -r $rev $rootdir $dirname")==0 or die "Something went wrong in executing:  svn checkout -r $rev $rootdir $dirname";
  } elsif ( $vc eq "GIT" ) {
    system("git archive --format=tar $rev | ( cd $dirname ; tar -xf -)")==0 or die "Something went wrong in executing:  git archive --format=tar $rev | ( cd $dirname ; tar -xf -)";
  } elsif ( $vc eq "HG" ) {
    system("hg archive --type files -r $rev $dirname")==0 or die "Something went wrong in executing:  hg archive --type files -r $rev $dirname";
  } else {
    die "checkout_dir: only works with SVN, HG and GIT VCS system (selected: $vc)";
  }
}

# greptex returns 1 if regex is not matched in filename
# only the 25 first non-comment lines are scanned
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

=item B<--rcs>, B<--svn>, B<--cvs>, B<--git> or B<--hg>

Set the version system. 
If no version system is specified, latexdiff-vc will venture a guess.

latexdiff-cvs and latexdiff-rcs are variants of latexdiff-vc which default to 
the respective versioning system. However, this default can still be overridden using the options above.

=item B<-r>, B<-r> F<rev> or B<--revision>, B<--revision=>F<rev>

Choose revision (under RCS, CVS, SVN, GIT or HG). One or two B<-r> options can be
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

=item B<--flatten,--flatten=keep-intermediate>

If combined with C<--git>, C<--svn> or C<--hg> option or the corresponding modes, check out the revisions to compare in a separate temporary directory, and then pass on option C<--flatten> to latexdiff. The directory in which C<latexdiff-vc> is invoked defines the subtree which will be checked out.
Note that if additional files are needed which are not included in the flatten procedure (package files, included graphics), they need to be accessible in the current directory. If you use bibtex, it is recommended to include the C<.bbl> file in the version management.

The generic usage of this function is : C<latexdiff-vc --flatten -r rev1 [-r rev2] master.tex> where master.tex is the project file containing the highest level of includes etc.

With C<--flatten=keep-intermediate>, the intermediate revision snapshots are kept in the current directory (Default is to store them in a temporary directory and delete them after generating the diff file.)

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

=item B<--only-changes>

Post-process the output such that only pages with changes on them are displayed. This requires the use of subtype ZLABEL 
in latexdiff, which will be set automatically, but any manually set -s option will be overruled (also requires zref package to 
be installsed). (note that this option must be combined with --ps or --pdf to make sense)

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
limited to Unix-like systems. It also requires the a version control
system and latex to be installed on the system to make use of all features.  Modules from Perl 5.8
or higher are required.

=head1 BUG REPORTING

Please submit bug reports using the issue tracker of the github repository page I<https://github.com/ftilmann/latexdiff.git>, 
or send them to I<tilmann -- AT -- gfz-potsdam.de>.  Include the serial number of I<latexdiff-vc>
(option C<--version>).

=head1 AUTHOR

Copyright (C) 2005-2015 Frederik Tilmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License Version 3
Contributors: S Utcke, H Bruyninckx; some ideas have been inspired by git-latexdiff bash script.
C. Junghans: Mercurial Support.

=cut

