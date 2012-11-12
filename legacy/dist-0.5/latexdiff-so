#!/usr/bin/perl -w
# latexdiff - differences two latex files on the word level
#             and produces a latex file with the differences marked up.
#
#   Copyright (C) 2004-2007  F J Tilmann (tilmann@esc.cam.ac.uk)
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License Version 2 as published by
#    the Free Software Foundation.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
# Detailed usage information at the end of the file
#
# Version 0.5  A number of minor improvements based on feedback
#              Deleted blocks are now shown before added blocks
#              Package specific processing
#
# Version 0.43 unreleased typo in list of styles at the end
#              Add protect to all \cbstart, \cbend commands
#              More robust substitution of deleted math commands
#
# Version 0.42 November 06  Bug fixes only
#
# Version 0.4   March 06 option for fast differencing using UNIX diff command, several minor bug fixes (\par bug, improved highlighting of textcmds)
#
# Version 0.3   August 05 improved parsing of displayed math, --allow-spaces 
#               option, several minor bug fixes
#
# Version 0.25  October 04 Fix bug with deleted equations, add math mode commands to safecmd, add | to allowed interpunctuation signs
# Version 0.2   September 04 extension to utf-8 and variable encodings
# Version 0.1   August 04    First public release

# Inserted block for stand-alone version replaces
# use Algorithm::Diff qw(traverse_sequences);
# in standard version
# The following BEGIN block contains a verbatim copy of
# Ned Konz' Algorithm::Diff package version 1.15 except
# that all POD documentation has been stripped out.
# I encourage you to download and install the Algorithm::Diff
# package and use the standard latexdiff version instead
# (current distribution available from http://search.cpan.org/~nedkonz/Algorithm-Diff-1.15
#  the most recent version can be found via  http://search.cpan.org/search?module=Algorithm::Diff )
# Please note that the LICENCSE for Algorithm::Diff :
#   "Copyright (c) 2000-2002 Ned Konz.  All rights reserved.
#    This program is free software;
#    you can redistribute it and/or modify it under the same terms
#    as Perl itself."
# The stand-alone version of latexdiff is provided as a convenience
# for latex users with no knowledge of PERL who do not wish to install
# additional packages to be able to use latexdiff.  If you believe
# the inlining of Algorithm::Diff violates its license please contact
# me and I will modify the latexdiff distribution accordingly.
# Frederik Tilmann (tilmann@esc.cam.ac.uk)
BEGIN { 
package Algorithm::Diff;
use strict;
use vars qw($VERSION @EXPORT_OK @ISA @EXPORT);
use integer;    # see below in _replaceNextLargerWith() for mod to make
                # if you don't use this
require Exporter;
@ISA       = qw(Exporter);
@EXPORT    = qw();
@EXPORT_OK = qw(LCS diff traverse_sequences traverse_balanced sdiff);
$VERSION = sprintf('%d.%02d so', (q$Revision: 1.15 $ =~ /\d+/g));

# McIlroy-Hunt diff algorithm
# Adapted from the Smalltalk code of Mario I. Wolczko, <mario@wolczko.com>
# by Ned Konz, perl@bike-nomad.com


# Create a hash that maps each element of $aCollection to the set of positions
# it occupies in $aCollection, restricted to the elements within the range of
# indexes specified by $start and $end.
# The fourth parameter is a subroutine reference that will be called to
# generate a string to use as a key.
# Additional parameters, if any, will be passed to this subroutine.
#
# my $hashRef = _withPositionsOfInInterval( \@array, $start, $end, $keyGen );

sub _withPositionsOfInInterval
{
	my $aCollection = shift;    # array ref
	my $start       = shift;
	my $end         = shift;
	my $keyGen      = shift;
	my %d;
	my $index;
	for ( $index = $start ; $index <= $end ; $index++ )
	{
		my $element = $aCollection->[$index];
		my $key = &$keyGen( $element, @_ );
		if ( exists( $d{$key} ) )
		{
			unshift ( @{ $d{$key} }, $index );
		}
		else
		{
			$d{$key} = [$index];
		}
	}
	return wantarray ? %d : \%d;
}

# Find the place at which aValue would normally be inserted into the array. If
# that place is already occupied by aValue, do nothing, and return undef. If
# the place does not exist (i.e., it is off the end of the array), add it to
# the end, otherwise replace the element at that point with aValue.
# It is assumed that the array's values are numeric.
# This is where the bulk (75%) of the time is spent in this module, so try to
# make it fast!

sub _replaceNextLargerWith
{
	my ( $array, $aValue, $high ) = @_;
	$high ||= $#$array;

	# off the end?
	if ( $high == -1 || $aValue > $array->[-1] )
	{
		push ( @$array, $aValue );
		return $high + 1;
	}

	# binary search for insertion point...
	my $low = 0;
	my $index;
	my $found;
	while ( $low <= $high )
	{
		$index = ( $high + $low ) / 2;

		#		$index = int(( $high + $low ) / 2);		# without 'use integer'
		$found = $array->[$index];

		if ( $aValue == $found )
		{
			return undef;
		}
		elsif ( $aValue > $found )
		{
			$low = $index + 1;
		}
		else
		{
			$high = $index - 1;
		}
	}

	# now insertion point is in $low.
	$array->[$low] = $aValue;    # overwrite next larger
	return $low;
}

# This method computes the longest common subsequence in $a and $b.

# Result is array or ref, whose contents is such that
# 	$a->[ $i ] == $b->[ $result[ $i ] ]
# foreach $i in ( 0 .. $#result ) if $result[ $i ] is defined.

# An additional argument may be passed; this is a hash or key generating
# function that should return a string that uniquely identifies the given
# element.  It should be the case that if the key is the same, the elements
# will compare the same. If this parameter is undef or missing, the key
# will be the element as a string.

# By default, comparisons will use "eq" and elements will be turned into keys
# using the default stringizing operator '""'.

# Additional parameters, if any, will be passed to the key generation routine.

sub _longestCommonSubsequence
{
	my $a      = shift;    # array ref
	my $b      = shift;    # array ref
	my $keyGen = shift;    # code ref
	my $compare;           # code ref

	# set up code refs
	# Note that these are optimized.
	if ( !defined($keyGen) )    # optimize for strings
	{
		$keyGen = sub { $_[0] };
		$compare = sub { my ( $a, $b ) = @_; $a eq $b };
	}
	else
	{
		$compare = sub {
			my $a = shift;
			my $b = shift;
			&$keyGen( $a, @_ ) eq &$keyGen( $b, @_ );
		};
	}

	my ( $aStart, $aFinish, $bStart, $bFinish, $matchVector ) =
	  ( 0, $#$a, 0, $#$b, [] );

	# First we prune off any common elements at the beginning
	while ( $aStart <= $aFinish
		and $bStart <= $bFinish
		and &$compare( $a->[$aStart], $b->[$bStart], @_ ) )
	{
		$matchVector->[ $aStart++ ] = $bStart++;
	}

	# now the end
	while ( $aStart <= $aFinish
		and $bStart <= $bFinish
		and &$compare( $a->[$aFinish], $b->[$bFinish], @_ ) )
	{
		$matchVector->[ $aFinish-- ] = $bFinish--;
	}

	# Now compute the equivalence classes of positions of elements
	my $bMatches =
	  _withPositionsOfInInterval( $b, $bStart, $bFinish, $keyGen, @_ );
	my $thresh = [];
	my $links  = [];

	my ( $i, $ai, $j, $k );
	for ( $i = $aStart ; $i <= $aFinish ; $i++ )
	{
		$ai = &$keyGen( $a->[$i], @_ );
		if ( exists( $bMatches->{$ai} ) )
		{
			$k = 0;
			for $j ( @{ $bMatches->{$ai} } )
			{

				# optimization: most of the time this will be true
				if ( $k and $thresh->[$k] > $j and $thresh->[ $k - 1 ] < $j )
				{
					$thresh->[$k] = $j;
				}
				else
				{
					$k = _replaceNextLargerWith( $thresh, $j, $k );
				}

				# oddly, it's faster to always test this (CPU cache?).
				if ( defined($k) )
				{
					$links->[$k] =
					  [ ( $k ? $links->[ $k - 1 ] : undef ), $i, $j ];
				}
			}
		}
	}

	if (@$thresh)
	{
		for ( my $link = $links->[$#$thresh] ; $link ; $link = $link->[0] )
		{
			$matchVector->[ $link->[1] ] = $link->[2];
		}
	}

	return wantarray ? @$matchVector : $matchVector;
}

sub traverse_sequences
{
	my $a                 = shift;                                  # array ref
	my $b                 = shift;                                  # array ref
	my $callbacks         = shift || {};
	my $keyGen            = shift;
	my $matchCallback     = $callbacks->{'MATCH'} || sub { };
	my $discardACallback  = $callbacks->{'DISCARD_A'} || sub { };
	my $finishedACallback = $callbacks->{'A_FINISHED'};
	my $discardBCallback  = $callbacks->{'DISCARD_B'} || sub { };
	my $finishedBCallback = $callbacks->{'B_FINISHED'};
	my $matchVector = _longestCommonSubsequence( $a, $b, $keyGen, @_ );

	# Process all the lines in @$matchVector
	my $lastA = $#$a;
	my $lastB = $#$b;
	my $bi    = 0;
	my $ai;

	for ( $ai = 0 ; $ai <= $#$matchVector ; $ai++ )
	{
		my $bLine = $matchVector->[$ai];
		if ( defined($bLine) )    # matched
		{
			&$discardBCallback( $ai, $bi++, @_ ) while $bi < $bLine;
			&$matchCallback( $ai,    $bi++, @_ );
		}
		else
		{
			&$discardACallback( $ai, $bi, @_ );
		}
	}

	# The last entry (if any) processed was a match.
	# $ai and $bi point just past the last matching lines in their sequences.

	while ( $ai <= $lastA or $bi <= $lastB )
	{

		# last A?
		if ( $ai == $lastA + 1 and $bi <= $lastB )
		{
			if ( defined($finishedACallback) )
			{
				&$finishedACallback( $lastA, @_ );
				$finishedACallback = undef;
			}
			else
			{
				&$discardBCallback( $ai, $bi++, @_ ) while $bi <= $lastB;
			}
		}

		# last B?
		if ( $bi == $lastB + 1 and $ai <= $lastA )
		{
			if ( defined($finishedBCallback) )
			{
				&$finishedBCallback( $lastB, @_ );
				$finishedBCallback = undef;
			}
			else
			{
				&$discardACallback( $ai++, $bi, @_ ) while $ai <= $lastA;
			}
		}

		&$discardACallback( $ai++, $bi, @_ ) if $ai <= $lastA;
		&$discardBCallback( $ai, $bi++, @_ ) if $bi <= $lastB;
	}

	return 1;
}

sub traverse_balanced
{
	my $a                 = shift;                                  # array ref
	my $b                 = shift;                                  # array ref
	my $callbacks         = shift || {};
	my $keyGen            = shift;
	my $matchCallback     = $callbacks->{'MATCH'} || sub { };
	my $discardACallback  = $callbacks->{'DISCARD_A'} || sub { };
	my $discardBCallback  = $callbacks->{'DISCARD_B'} || sub { };
	my $changeCallback    = $callbacks->{'CHANGE'};
	my $matchVector = _longestCommonSubsequence( $a, $b, $keyGen, @_ );

	# Process all the lines in match vector
	my $lastA = $#$a;
	my $lastB = $#$b;
	my $bi    = 0;
	my $ai    = 0;
	my $ma    = -1;
	my $mb;

	while (1)
	{

		# Find next match indices $ma and $mb
		do { $ma++ } while ( $ma <= $#$matchVector && !defined $matchVector->[$ma] );

		last if $ma > $#$matchVector;    # end of matchVector?
		$mb = $matchVector->[$ma];

		# Proceed with discard a/b or change events until
		# next match
		while ( $ai < $ma || $bi < $mb )
		{

			if ( $ai < $ma && $bi < $mb )
			{

				# Change
				if ( defined $changeCallback )
				{
					&$changeCallback( $ai++, $bi++, @_ );
				}
				else
				{
					&$discardACallback( $ai++, $bi, @_ );
					&$discardBCallback( $ai, $bi++, @_ );
				}
			}
			elsif ( $ai < $ma )
			{
				&$discardACallback( $ai++, $bi, @_ );
			}
			else
			{

				# $bi < $mb
				&$discardBCallback( $ai, $bi++, @_ );
			}
		}

		# Match
		&$matchCallback( $ai++, $bi++, @_ );
	}

	while ( $ai <= $lastA || $bi <= $lastB )
	{
		if ( $ai <= $lastA && $bi <= $lastB )
		{

			# Change
			if ( defined $changeCallback )
			{
				&$changeCallback( $ai++, $bi++, @_ );
			}
			else
			{
				&$discardACallback( $ai++, $bi, @_ );
				&$discardBCallback( $ai, $bi++, @_ );
			}
		}
		elsif ( $ai <= $lastA )
		{
			&$discardACallback( $ai++, $bi, @_ );
		}
		else
		{

			# $bi <= $lastB
			&$discardBCallback( $ai, $bi++, @_ );
		}
	}

	return 1;
}

sub LCS
{
	my $a = shift;                                           # array ref
	my $matchVector = _longestCommonSubsequence( $a, @_ );
	my @retval;
	my $i;
	for ( $i = 0 ; $i <= $#$matchVector ; $i++ )
	{
		if ( defined( $matchVector->[$i] ) )
		{
			push ( @retval, $a->[$i] );
		}
	}
	return wantarray ? @retval : \@retval;
}

sub diff
{
	my $a      = shift;    # array ref
	my $b      = shift;    # array ref
	my $retval = [];
	my $hunk   = [];
	my $discard = sub { push ( @$hunk, [ '-', $_[0], $a->[ $_[0] ] ] ) };
	my $add = sub { push ( @$hunk, [ '+', $_[1], $b->[ $_[1] ] ] ) };
	my $match = sub { push ( @$retval, $hunk ) if scalar(@$hunk); $hunk = [] };
	traverse_sequences( $a, $b,
		{ MATCH => $match, DISCARD_A => $discard, DISCARD_B => $add }, @_ );
	&$match();
	return wantarray ? @$retval : $retval;
}

sub sdiff
{
	my $a      = shift;    # array ref
	my $b      = shift;    # array ref
	my $retval = [];
	my $discard = sub { push ( @$retval, [ '-', $a->[ $_[0] ], "" ] ) };
	my $add = sub { push ( @$retval, [ '+', "", $b->[ $_[1] ] ] ) };
	my $change = sub {
		push ( @$retval, [ 'c', $a->[ $_[0] ], $b->[ $_[1] ] ] );
	};
	my $match = sub {
		push ( @$retval, [ 'u', $a->[ $_[0] ], $b->[ $_[1] ] ] );
	};
	traverse_balanced(
		$a,
		$b,
		{
			MATCH     => $match,
			DISCARD_A => $discard,
			DISCARD_B => $add,
			CHANGE    => $change,
		},
		@_
	);
	return wantarray ? @$retval : $retval;
}

1;
}
import Algorithm::Diff qw(traverse_sequences);
# End of inserted block for stand-alone version

use Getopt::Long ;
use strict ;
use utf8 ;

my ($algodiffversion)=split(/ /,$Algorithm::Diff::VERSION);


my ($versionstring)=<<EOF ;
This is LATEXDIFF 0.5  (Algorithm::Diff $Algorithm::Diff::VERSION)
  (c) 2004-2007 F J Tilmann
EOF

# Configuration variables: these have to be visible from the subroutines
my $MINWORDSBLOCK=3; # minimum number of tokens to form an independent block
                     # shorter identical blocks will be merged to the previous word
my $FLOATENV='(?:figure|table|plate)[\w\d*@]*' ;   # Environments in which FL variants of defined commands are used
my $PICTUREENV='(?:picture|DIFnomarkup)[\w\d*@]*' ;   # Environments in which all change markup is removed
my $MATHENV='(?:equation|displaymath|DOLLARDOLLAR)' ;           # Environments turning on display math mode (code also knows about \[ and \]
my $MATHREPL='displaymath';  # Environment introducing deleted maths blocks
my $MATHARRENV='(?:eqnarray|align|gather|multiline|flalign)[*]?' ;           # Environments turning on eqnarray math mode
my $MATHARRREPL='eqnarray*';  # Environment introducing deleted maths blocks
my $ARRENV='(?:array|[pbvBV]matrix)'; # Enviroments making arrays in math mode.  The underlining style does not cope well with those - as a result in-text math environments are surrounded by \mbox{ } if any of these commands is used in an inline math block
my $COUNTERCMD='(?:footnote|part|section|subsection|subsubsection|paragraph|subparagraph)';  # textcmds which are associated with a counter
                                        # If any of these commands occur in a deleted block
                                        # they will be succeeded by an \addtocounter{...}{-1}
                                        # for the associated counter such that the overall numbers
                                        # should be the same as in the new file

# Markup strings
# If at all possible, do not change these as parts of the program
# depend on the actual name (particularly post-processing)
# At the very least adapt subroutine postprocess to new tokens.
my $ADDMARKOPEN='\DIFaddbegin ';   # Token to mark begin of appended text
my $ADDMARKCLOSE='\DIFaddend ';   # Token to mark end of appended text
my $ADDOPEN='\DIFadd{';  # To mark begin of added text passage
my $ADDCLOSE='}';        # To mark end of added text passage
my $ADDCOMMENT='DIF > ';   # To mark added comment line
my $DELMARKOPEN='\DIFdelbegin ';   # Token to mark begin of deleted text
my $DELMARKCLOSE='\DIFdelend ';   # Token to mark end of deleted text
my $DELOPEN='\DIFdel{';  # To mark begin of deleted text passage
my $DELCLOSE='}';        # To mark end of deleted text passage
my $DELCMDOPEN='%DIFDELCMD < ';  # To mark begin of deleted commands (must begin with %, i.e., be a comment
my $DELCMDCLOSE="%%%\n";    # To mark end of deleted commands (must end with a new line)
my $AUXCMD='%DIFAUXCMD' ; #  follows auxiliary commands put in by latexdiff to make difference file legal
                          # auxiliary commands must be on a line of their own
my $DELCOMMENT='DIF < ';   # To mark deleted comment line


# main local variables:
my @TEXTCMDLIST=();  # array containing patterns of commands with text arguments
my @TEXTCMDEXCL=();  # array containing patterns of commands without text arguments (if a pattern
                     # matches both TEXTCMDLIST and TEXTCMDEXCL it is excluded)
my @CONTEXT1CMDLIST=();  # array containing patterns of commands with text arguments (subset of text commands),
                         # but which cause confusion if used out of context (e.g. \caption). 
                         # In deleted passages, the command will be disabled but its argument is marked up
                         # Otherwise they behave exactly like TEXTCMD's 
my @CONTEXT1CMDEXCL=();  # exclude list for above, but always empty
my @CONTEXT2CMDLIST=();  # array containing patterns of commands with text arguments, but which fail cause confusion
                         # if used out of context (e.g. \title). They and their arguments will be disabled in deleted
                         # passages
my @CONTEXT2CMDEXCL=();  # exclude list for above, but always empty

my @SAFECMDLIST=();  # array containing patterns of safe commands (which do not break when in the argument of DIFadd or DIFDEL)
my @SAFECMDEXCL=();

my ($i,$j,$l);
my ($old,$new);
my ($line);
my ($newpreamble,$oldpreamble);
my (@newpreamble,@oldpreamble,@diffpreamble,@diffbody);
my ($latexdiffpreamble);
my ($oldbody, $newbody, $diffbo);
my ($oldpost, $newpost);
my ($diffall);
# Option names
my ($type,$subtype,$floattype,$config,$preamblefile,$encoding,
    $showpreamble,$showsafe,$showtext,$showconfig,$showall,
    $replacesafe,$appendsafe,$excludesafe,
    $replacetext,$appendtext,$excludetext,
    $replacecontext1,$appendcontext1,
    $replacecontext2,$appendcontext2,
    $help,$verbose,$version,$ignorewarnings,$allowspaces,$flatten,$debug);
my (@configlist,
    @appendsafelist,@excludesafelist,
    @appendtextlist,@excludetextlist,
    @appendcontext1list,@appendcontext2list,
    @packagelist);
my ($assign,@config);
# Hash where keys corresponds to the names of  all included packages (including the documentclass as another package
# the optional arguments to the package are the values of the hash elements
my ($pkg,%packages);
# Defaults
$type='UNDERLINE';
$subtype='SAFE';
$floattype='FLOATSAFE';

$verbose=0;
$debug=1; 
# define character properties
sub IsNonAsciiPunct { return <<'END'    # Unicode punctuation but excluding ASCII punctuation
+utf8::IsPunct
-utf8::IsASCII
END
}
sub IsNonAsciiS { return <<'END'       # Unicode symbol but excluding ASCII
+utf8::IsS
-utf8::IsASCII
END
}



  my %verbhash;

Getopt::Long::Configure('bundling');
GetOptions('type|t=s' => \$type, 
	   'subtype|s=s' => \$subtype, 
	   'floattype|f=s' => \$floattype, 
	   'config|c=s' => \@configlist,
	   'preamble|p=s' => \$preamblefile,
	   'encoding|e=s' => \$encoding,
	   'exclude-safecmd|A=s' => \@excludesafelist,
	   'replace-safecmd=s' => \$replacesafe,
	   'append-safecmd|a=s' => \@appendsafelist,
	   'exclude-textcmd|X=s' => \@excludetextlist,
	   'replace-textcmd=s' => \$replacetext,
	   'append-textcmd|x=s' => \@appendtextlist,
	   'replace-context1cmd=s' => \$replacecontext1,
	   'append-context1cmd=s' => \@appendcontext1list,
	   'replace-context2cmd=s' => \$replacecontext2,
	   'append-context2cmd=s' => \@appendcontext2list,
	   'show-preamble' => \$showpreamble,
	   'show-safecmd' => \$showsafe,
	   'show-textcmd' => \$showtext,
	   'show-config' => \$showconfig,
	   'show-all' => \$showall,
           'packages=s' => \@packagelist,
	   'verbose|V' => \$verbose,
	   'ignore-warnings' => \$ignorewarnings,
	   'allow-spaces' => \$allowspaces,
	   'flatten' => \$flatten,
	   'version' => \$version,
	   'help|h|H' => \$help);

if ( $help ) {
  usage() ;
}


if ( $version ) {
  die $versionstring ; 
}

print STDERR $versionstring if $verbose; 

if (defined($showall)){
  $showpreamble=$showsafe=$showtext=$showconfig=1;
}

# setting extra preamble commands
if (defined($preamblefile)) {
  $latexdiffpreamble=join "\n",(extrapream($preamblefile),"");
} else {
  $latexdiffpreamble=join "\n",(extrapream($type,$subtype,$floattype),"");
}

# setting up @SAFECMDLIST and @SAFECMDEXCL
if (defined($replacesafe)) {
  init_regex_arr_ext(\@SAFECMDLIST,$replacesafe);
} else {
  init_regex_arr_data(\@SAFECMDLIST, "SAFE COMMANDS");
}
foreach $appendsafe ( @appendsafelist ) {
  init_regex_arr_ext(\@SAFECMDLIST, $appendsafe);
}
foreach $excludesafe ( @excludesafelist ) {
  init_regex_arr_ext(\@SAFECMDEXCL, $excludesafe);
}

# Special: treat all cite commands as safe except in UNDERLINE and FONTSTRIKE mode
# (there is a conflict between citation and ulem package, see
# package documentation)
if ( uc($type) ne "UNDERLINE" && uc($type) ne "FONTSTRIKE" && uc($type) ne "CULINECHBAR" ) {
  push (@SAFECMDLIST, qr/^cite.*$/);
}

# setting up @TEXTCMDLIST and @TEXTCMDEXCL
if (defined($replacetext)) {
  init_regex_arr_ext(\@TEXTCMDLIST,$replacetext);
} else {
  init_regex_arr_data(\@TEXTCMDLIST, "TEXT COMMANDS");
}
foreach $appendtext ( @appendtextlist ) {
  init_regex_arr_ext(\@TEXTCMDLIST, $appendtext);
}
foreach $excludetext ( @excludetextlist ) {
  init_regex_arr_ext(\@TEXTCMDEXCL, $excludetext);
}


# setting up @CONTEXT1CMDLIST ( @CONTEXT1CMDEXCL exist but is always empty )
if (defined($replacecontext1)) {
  init_regex_arr_ext(\@CONTEXT1CMDLIST,$replacecontext1);
} else {
  init_regex_arr_data(\@CONTEXT1CMDLIST, "CONTEXT1 COMMANDS");
}
foreach $appendcontext1 ( @appendcontext1list ) {
  init_regex_arr_ext(\@CONTEXT1CMDLIST, $appendcontext1);
}


# setting up @CONTEXT2CMDLIST ( @CONTEXT2CMDEXCL exist but is always empty )
if (defined($replacecontext2)) {
  init_regex_arr_ext(\@CONTEXT2CMDLIST,$replacecontext2);
} else {
  init_regex_arr_data(\@CONTEXT2CMDLIST, "CONTEXT2 COMMANDS");
}
foreach $appendcontext2 ( @appendcontext2list ) {
  init_regex_arr_ext(\@CONTEXT2CMDLIST, $appendcontext2);
}




# setting configuration variables
@config=();
foreach $config ( @configlist ) {
  if (-f $config ) {
    open(FILE,$config) or die ("Couldn't open configuration file $config: $!");
    while (<FILE>) {
      chomp;
      next if /^\s*#/ || /^\s*%/ || /^\s*$/ ;
      push (@config,$_);
    }
    close(FILE);
  }
  else {
#    foreach ( split(",",$config) ) {
#      push @config,$_;
#    }
     push @config,split(",",$config)
  }
}
foreach $assign ( @config ) {
  $assign=~ m/\s*(\w*)\s*=\s*(\S*)\s*$/ or die "Illegal assignment $assign in configuration list (must be variable=value)";  
  if ( $1 eq "MINWORDSBLOCK" ) { $MINWORDSBLOCK = $2; }
  elsif ( $1 eq "FLOATENV" ) { $FLOATENV = $2 ; }
  elsif ( $1 eq "PICTUREENV" ) { $PICTUREENV = $2 ; }
  elsif ( $1 eq "MATHENV" ) { $MATHENV = $2 ; }
  elsif ( $1 eq "MATHREPL" ) { $MATHREPL = $2 ; }
  elsif ( $1 eq "MATHARRENV" ) { $MATHARRENV = $2 ; }
  elsif ( $1 eq "MATHARRREPL" ) { $MATHARRREPL = $2 ; }
  elsif ( $1 eq "ARRENV" ) { $ARRENV = $2 ; }
  elsif ( $1 eq "COUNTERCMD" ) { $COUNTERCMD = $2 ; }
  else { die "Unknown variable $1 in assignment.";}
}


foreach $pkg ( @packagelist ) {
  map { $packages{$_}="" } split(/,/,$pkg) ;
}

if ($showpreamble) {
  print "\nPreamble commands:\n";
  print $latexdiffpreamble ;
}

if ($showsafe) {
  print "\nCommands safe within scope of $ADDOPEN $ADDCLOSE and $DELOPEN $DELCLOSE (unless excluded):\n";
  print_regex_arr(@SAFECMDLIST);
  print "\nCommands not safe within scope of $ADDOPEN $ADDCLOSE and $DELOPEN $DELCLOSE :\n";
  print_regex_arr(@SAFECMDEXCL);
}

if ($showtext) {
  print "\nCommands with last argument textual (unless excluded) and safe in every context:\n";
  print_regex_arr(@TEXTCMDLIST);
  print "\nContext1 commands (last argument textual, command will be disabled in deleted passages, last argument will be shown as plain text):\n";
  print_regex_arr(@CONTEXT1CMDLIST);
  print "\nContext2 commands (last argument textual, command ant its argument will be disabled in deleted passages):\n";
  print_regex_arr(@CONTEXT2CMDLIST);  
  print "\nExclude list of Commands with last argument not textual (overrides patterns above):\n";
  print_regex_arr(@TEXTCMDEXCL);
}

if ($showconfig) {
  print "Configuration variables:\n";
  print "MINWORDSBLOCK=$MINWORDSBLOCK\n";
  print "FLOATENV=$FLOATENV\n";
  print "PICTUREENV=$PICTUREENV\n";
  print "MATHENV=$MATHENV\n";
  print "MATHREPL=$MATHREPL\n";
  print "MATHARRENV=$MATHARRENV\n";
  print "MATHARRREPL=$MATHARRREPL\n";
  print "ARRENV=$ARRENV\n";
  print "COUNTERCMD=$COUNTERCMD\n";
}
if ($showconfig || $showtext || $showsafe || $showpreamble) {
  exit 0; }
if ( @ARGV != 2 ) { 
  print STDERR "2 and only 2 non-option arguments required.  Write latexdiff -h to get help\n";
  exit(2);
}

# Are extra spaces between command arguments permissible?
my $extraspace;
if ($allowspaces) {
  $extraspace='\s*'; 
} else {
  $extraspace='';
}

# append context lists to text lists (as text property is implied)
push @TEXTCMDLIST, @CONTEXT1CMDLIST;
push @TEXTCMDLIST, @CONTEXT2CMDLIST;


# Patterns. These are used by some of the subroutines, too
# I can only define them down here because value of extraspace depends on an option
  my $pat0 = '(?:[^{}]|\\\{|\\\})*';
  my $pat1 = '(?:[^{}]|\\\{|\\\}|\{'.$pat0.'\})*';
  my $pat2 = '(?:[^{}]|\\\{|\\\}|\{'.$pat1.'\})*'; # 
  my $pat3 = '(?:[^{}]|\\\{|\\\}|\{'.$pat2.'\})*';
  my $pat4 = '(?:[^{}]|\\\{|\\\}|\{'.$pat3.'\})*';
  my $brat0 = '(?:[^\[\]]|\\\[|\\\])*'; 

  my $quotemarks = '(?:\'\')|(?:\`\`)';
  my $punct='[0.,\/\'\`:;\"\?\(\)\[\]!~\p{IsNonAsciiPunct}\p{IsNonAsciiS}]';
  my $number='-?\d*\.\d*';
  my $mathpunct='[+=<>\-\|]';
  my $and = '&';
  my $coords= '[\-.,\s\d]*';
# word: sequence of letters or accents followed by letter
  my $word='(?:[-\w\d*]|\\\\[\"\'\`~^][A-Za-z\*])+';
  my $cmdleftright='\\\\(?:left|right)\s*(?:[()\[\]|]|\\\\(?:[|{}]|\w+))';

  my $cmdoptseq='\\\\[\w\d\*]+'.$extraspace.'(?:(?:\['.$brat0.'\]|\{'. $pat4 . '\}|\(' . $coords .'\))'.$extraspace.')*';
  my $oneletcmd='\\\\.(?:\['.$brat0.'\]|\{'. $pat4 . '\})*';
  my $math='\$(?:[^$]|\\\$)*?\$|\\\\[(].*?\\\\[)]';
#  my $math='\$(?:[^$]|\\\$)*\$';
  my $comment='%.*?\n';
  my $pat=qr/(?:\A\s*)?(?:${and}|${quotemarks}|${number}|${word}|$cmdleftright|${cmdoptseq}|${math}|${oneletcmd}|${comment}|${punct}|${mathpunct}|\{|\})\s*/ ;



# now we are done setting up and can start working   
my ($oldfile, $newfile) = @ARGV;

$encoding=guess_encoding($newfile) unless defined($encoding);

$encoding = "utf8" if $encoding =~ m/^utf8/i ;
if (lc($encoding) eq "utf8" ) {
  binmode(STDOUT, ":utf8");
  binmode(STDERR, ":utf8");
}

$old=read_file_with_encoding($oldfile,$encoding);
$new=read_file_with_encoding($newfile,$encoding);




# reset time
exetime(1);
($oldpreamble,$oldbody,$oldpost)=splitdoc($old,'\\\\begin\{document\}','\\\\end\{document\}');


($newpreamble,$newbody,$newpost)=splitdoc($new,'\\\\begin\{document\}','\\\\end\{document\}');


if ($flatten) {
  $oldbody=flatten($oldbody,$oldpreamble,$oldfile,$encoding);
  $newbody=flatten($newbody,$newpreamble,$newfile,$encoding);
}

if ( length $oldpreamble && length $newpreamble ) {
  @oldpreamble = split /\n/, $oldpreamble;
  @newpreamble = split /\n/, $newpreamble;
  
  %packages=list_packages(@newpreamble) unless %packages;
  if (defined $packages{"hyperref"} ) {
    print STDERR "hyperref package detected.\n" if $verbose ;
    $latexdiffpreamble =~ s/\{\\DIFadd\}/{\\DIFaddtex}/g;
    $latexdiffpreamble =~ s/\{\\DIFdel\}/{\\DIFdeltex}/g;
    $latexdiffpreamble .= join "\n",(extrapream("HYPERREF"),"");
  }
  # insert dummy first line such that line count begins with line 1 (rather than perl's line 0) - just so that line numbers inserted by linediff are correct
  unshift @newpreamble,'';
  unshift @oldpreamble,'';
  print STDERR "Differencing preamble.\n" if $verbose;
  @diffpreamble = linediff(\@oldpreamble, \@newpreamble);
  # remove dummy line again
  shift @diffpreamble; 
  push @diffpreamble,$latexdiffpreamble;
  push @diffpreamble,'\begin{document}';
}
elsif ( !length $oldpreamble && !length $newpreamble ) {
  @diffpreamble=();
} else {
  print STDERR "Either both texts must have preamble or neither text must have the preamble.\n";
  exit(2);
}

if (defined $packages{"amsmath"} ) {
  print STDERR "amsmath package detected.\n" if $verbose ;
  $MATHARRREPL='align*';
}

print STDERR "Preprocessing body.  " if $verbose;
my ($oldleadin,$newleadin)=preprocess($oldbody,$newbody);


# run difference algorithm
@diffbody=bodydiff($oldbody, $newbody);
$diffbo=join("",@diffbody);
print STDERR "(",exetime()," s)\n","Postprocessing body. \n " if $verbose;
postprocess($diffbo);
$diffall =join("\n",@diffpreamble) ;
$diffall .= "$newleadin$diffbo" ;
$diffall .= "\\end{document}$newpost" if length $newpreamble ;
if ( lc($encoding) ne "utf8" && lc($encoding) ne "ascii" ) {
  print STDERR "Encoding output file to $encoding\n" if $verbose;
  $diffall=Encode::encode($encoding,$diffall);
  binmode STDOUT;
}
print $diffall;


print STDERR "(",exetime()," s)\n","Done.\n" if $verbose;



## guess_encoding(filename)
## reads the first 20 lines of filename and looks for call of inputenc package
## if found, return the option of this package (encoding), otherwise return ascii
sub guess_encoding {
  my ($filename)=@_;
  my ($i,$enc);
  open (FH, $filename) or die("Couldn't open $filename: $!");
  $i=0;
  while (<FH>) {
    next if /^\s*%/;    # skip comment lines
    if (m/\\usepackage\[(\w*?)\]\{inputenc\}/) {
      close(FH);
      return($1);
    }
    last if (++$i > 20 ); # scan at most 20 non-comment lines
  }
  close(FH);
  return("ascii");
}


sub read_file_with_encoding {
  my ($output);
  my ($filename, $encoding) = @_;

  if (lc($encoding) eq "utf8" ) {
    open (FILE, "<:utf8",$filename) or die("Couldn't open $filename: $!");
    local $/ ; # locally set record operator to undefined, ie. enable whole-file mode
    $output=<FILE>;
  } elsif ( lc($encoding) eq "ascii") {
    open (FILE, $filename) or die("Couldn't open $filename: $!");
    local $/ ; # locally set record operator to undefined, ie. enable whole-file mode
    $output=<FILE>;
  } else {
    require Encode;
    open (FILE, "<",$filename) or die("Couldn't open $filename: $!");
    local $/ ; # locally set record operator to undefined, ie. enable whole-file mode
    $output=<FILE>;
    print STDERR "Converting $filename from $encoding to utf8\n" if $verbose;
    $output=Encode::decode($encoding,$output);
  }
  close FILE;
  return $output;
}

# %packages=list_packages(@preamble)
# scans the arguments for \documentclass and \usepackage statements and constructs a hash
# whose keys are the included packages, and whose values are the associated optional arguments
sub list_packages {
  my (@preamble)=@_;
  my %packages=();
  foreach $line ( @preamble ) {
    # get rid of comments
    $line=~s/(?<!\\)%.*$// ;
    if ( $line =~ m/\\(?:documentclass|usepackage)(?:\[(.+?)\])?\{(.*?)\}/ ) {
#      print STDERR "Found something: |$line|\n";
      if (defined($1)) {
	$packages{$2}=$1;
      } else {
	$packages{$2}="";
      }
    }
  }
  return (%packages);
}

# flatten($text,$preamble,$filename,$encoding)
# expands \input and \include commands within text
# premable is scanned for includeonly commands
# encoding is the encoding
sub flatten {
  my ($text,$preamble,$filename,$encoding)=@_;
  my ($includeonly,$dirname,$fname,$newpage,$replacement);
  require File::Basename ; 
  require File::Spec ; 
  $dirname = File::Basename::dirname($filename);

  if ( ($includeonly) = ($preamble =~ m/\\includeonly{(.*?)}/ ) ) {
    $includeonly =~ s/,/|/g;
  } else {
    $includeonly = '.*?';
  }

  print STDERR "DEBUG: includeonly $includeonly\n";

  $text=~s/\\input{(.*?)}|\\include{(${includeonly}(?:\.tex)?)}/{ 
	    $fname = $1 if defined($1)  ;
	    $fname = $2 if defined($2) ;       
            #      # add tex extension unless there is a three letter extension already 
            $fname .= ".tex" unless $fname =~ m|\.\w{3}|;
            print STDERR "Include file $fname\n" if $verbose;
            print STDERR "DEBUG looking for file ",File::Spec->catfile($dirname,$fname), "\n";
            # content of file becomes replacement value, add \newpage if the command was include
            $replacement=read_file_with_encoding(File::Spec->catfile($dirname,$fname), $encoding) or die
                "Couldn't find file ",File::Spec->catfile($dirname,$fname),": $!";
	    $newpage=(defined($2)? " \\newpage " : "") ;
	    "$newpage$replacement$newpage";
          }/exg;

  return($text);
}


# print_regex_arr(@arr)
# prints regex array without x-ism expansion put in by pearl to stdout
sub print_regex_arr {
  my $dumstring;
  $dumstring = join(" ",@_);     # PERL generates string (?-xism:^ref$) for quoted refex ^ref$
  $dumstring =~ s/\(\?-xism:\^(.*?)\$\)/$1/g;   # remove string and ^,$ marks before output
  print $dumstring,"\n";
}


# @lines=extrapream($type)
# reads line from appendix (end of file after __END__ token)
sub extrapream {
  my $type;
  my @retval=("%DIF PREAMBLE EXTENSION ADDED BY LATEXDIFF") ;
  my ($copy);

  while (@_) {
    $copy=0;
    $type=shift ;
    if ( -f $type ) {
      open (FILE,$type) or die "Cannot open preamble file $type: $!";
      print STDERR "Reading preamble file $type\n" if $verbose ;
      while (<FILE>) {
	chomp ;
	if ( $_ =~ m/%DIF PREAMBLE/ ) {
	  push (@retval,"$_"); 
	} else {
	  push (@retval,"$_ %DIF PREAMBLE"); 
	}
      }
    } 
    else {    # not (-f $type)
      $type=uc($type);   # upcase argument
      print STDERR "Preamble Internal Type $type\n" if $verbose;
      while (<DATA>) {
	if ( m/^%DIF $type/ ) {
	  $copy=1; }
	elsif ( m/^%DIF END $type/ ) {
	  last; }
	chomp;
	push (@retval,"$_ %DIF PREAMBLE") if $copy;
      }
      if ( $copy == 0 ) {
	print STDERR "\nPreamble style $type not implemented.\n";
        print STDERR "Write latexdiff -h to get help with available styles\n";
        exit(2);
      }
      seek DATA,0,0;    # rewind DATA handle to file begin
    }
  }
  push (@retval,"%DIF END PREAMBLE EXTENSION ADDED BY LATEXDIFF")  ;
  return @retval;
}


# ($part1,$part2,$part3)=splitdoc($text,$word1,$word2)
# splits $text into 3 parts at $word1 and $word2.
# if neither $word1 nor $word2 exist, $part1 and $part3 are empty, $part2 is $text
# If only $word1 or $word2 exist but not the other, output an error message.

# NB this version avoids $` and $' for performance reason although it only makes a tiny difference
# (in one test gain a tenth of a second for a 30s run)
sub splitdoc {
  my ($text,$word1,$word2)=@_;
  my ($part1,$part2,$part3)=("","","");
  my ($rest,$pos);

  if ( $text =~ m/(^[^%]*)($word1)/mg ) {
    $pos=pos $text;
    $part1=substr($text,0,$pos-length($2));
    $rest=substr($text,$pos);
    if ( $rest =~ m/(^[^%]*)($word2)/mg ) {
      $pos=pos $rest;
      $part2=substr($rest,0,$pos-length($2));
      $part3=substr($rest,$pos);
    } 
    else {
      die "$word1 and $word2 not in the correct order or not present as a pair." ;
    }
  } else {
    $part2=$text;
    die "$word2 present but not $word1." if ( $text =~ m/(^[^%]*)$word2/ms );
  }
  return ($part1,$part2,$part3);
}





# bodydiff($old,$new)
sub bodydiff {
  my ($oldwords, $newwords) = @_;
  my @retwords;

  print STDERR "(",exetime()," s)\n","Splitting into latex tokens \n" if $verbose;
  print STDERR "Parsing $oldfile \n" if $verbose;
  my @oldwords = splitlatex($oldwords);
  print STDERR "Parsing $newfile \n" if $verbose;
  my @newwords = splitlatex($newwords);
  my $token;

  print STDERR "(",exetime()," s)\n","Pass 1: Expanding text commands and merging isolated identities with changed blocks  " if $verbose;
  pass1(\@oldwords, \@newwords);


  print STDERR "(",exetime()," s)\n","Pass 2: inserting DIF tokens and mark up.  " if $verbose;

  @retwords=pass2(\@oldwords, \@newwords);

  return(@retwords);
}




# @words=splitlatex($string)
# split string according to latex rules
# Each element of words is either
# a word (including trailing spaces and punctuation)
# a latex command
sub splitlatex {
  my ($string) = @_ ;
  my @retval=($string =~ m/$pat/osg);  

  if (length($string) != length(join("",@retval))) {
    print STDERR "\nWARNING: Inconsistency in length of input string and parsed string:\n     This often indicates faulty or non-standard latex code.\n     In many cases you can ignore this and the following warning messages.\n Note that character numbers in the following are counted beginning after \\begin{document} and are only approximate." unless $ignorewarnings;
    print STDERR "DEBUG Original length ",length($string),"  Parsed length ",length(join("",@retval)),"\n" if $debug;
    print STDERR "DEBUG Input string:  |$string|\n" if (length($string)<500) && $debug;
    print STDERR "DEBUG Token parsing: |",join("+",@retval),"|\n" if (length($string)<500) && $debug ;
    @retval=();
    # slow way only do this if other m//sg method fails
    my $last = 0;
    while ( $string =~ m/$pat/osg ) {
      my $match=$&;
      if ($last + length $& != pos $string  ) {
	my $pos=pos($string);
	my $offset=30<$last ? 30 : $last;
	my $dum=substr($string,$last-$offset,$pos-$last+2*$offset);
	my $dum1=$dum;
	my $cnt=$#retval;
	my $i;
	$dum1 =~ s/\n/ /g;
	unless ($ignorewarnings) {
	  print STDERR "\n$dum1\n";
	  print STDERR " " x 30,"^" x ($pos-$last)," " x 30,"\n";
	  print STDERR "Missing characters near word " . (scalar @retval) . " character index: " . $last . "-" .  pos($string) . " Length: " . length($match) . " Match: |$match| (expected match marked above).\n";
	}
	  # put in missing characters `by hand'
	push (@retval, substr($dum,$offset,$pos-$last-length($match)));
#       Note: there seems to be a bug in substr with utf8 that made the following line output substr which were too long,
#             using dum instead appears to work
#	push (@retval, substr($string,$last, pos($string)-$last-length($match)));
      }
      push (@retval, $match);
      $last=pos $string;
    }

  }
  return @retval;
}


# pass1( \@seq1,\@seq2)
# Look for differences between seq1 and seq2.
# Where an common-subsequence block is flanked by deleted or appended blocks, 
# and is shorter than $MINWORDSBLOCK words it is appended
# to the last deleted or appended word.  If the block contains tokens other than words 
# or punctuation it is not merged.
# Deleted or appended block consisting of words and safe commands only are
# also merged, to prevent break-up in pass2 (after previous isolated words have been removed)
# If there are commands with textual arguments (e.g. \caption) both in corresponding 
# appended and deleted blocks split them such that the command and opening bracket 
# are one token, then the rest is split up following standard rules, and the closing 
# bracket is a separate token, ie. turn
# "\caption{This is a textual argument}" into 
# ("\caption{","This ","is ","a ","textual ","argument","}")
# No return value.  Destructively changes sequences
sub pass1 {
  my $seq1 = shift ;
  my $seq2 = shift ;

  my $len1 = scalar @$seq1;
  my $len2 = scalar @$seq2;
  my $wpat=qr/^(?:[a-zA-Z.,'`:;?()!]*)[\s~]*$/;   #'

  my ($last1,$last2)=(-1,-1) ;
  my $cnt=0;
  my $block=[];
  my $addblock=[];
  my $delblock=[];
  my $todo=[];
  my $instruction=[];
  my $i;
  my (@delmid,@addmid,@dummy);

  my ($addcmds,$delcmds,$matchindex);
  my ($addtextblocks,$deltextblocks);
  my ($addtokcnt,$deltokcnt,$mattokcnt)=(0,0,0);
  my ($addblkcnt,$delblkcnt,$matblkcnt)=(0,0,0);

  my $adddiscard = sub {
                      if ($cnt > 0 ) {
			$matblkcnt++;
			# just after an unchanged block 
#			print STDERR "Unchanged block $cnt, $last1,$last2 \n";
                        if ($cnt < $MINWORDSBLOCK 
			    && $cnt==scalar (
				     grep { /^$wpat/ || ( /^\\([\w\d\*]+)((?:\[$brat0\]|\{$pat4\})*)/o 
							   && iscmd($1,\@SAFECMDLIST,\@SAFECMDEXCL) 
							   && scalar(@dummy=split(" ",$2))<3 ) }
					     @$block) )  {
			  # merge identical blocks shorter than $MINWORDSBLOCK 
			  # and only containing ordinary words
			  # with preceding different word
			  # We cannot carry out this merging immediately as this
			  # would change the index numbers of seq1 and seq2 and confuse
			  # the algorithm, instead we store in @$todo where we have to merge
                          push(@$todo, [ $last1,$last2,$cnt,@$block ]);
			}
			$block = []; 
			$cnt=0; $last1=-1; $last2=-1;
		      }
		    };
  my $discard=sub { $deltokcnt++;
                    &$adddiscard; #($_[0],$_[1]);
		    push(@$delblock,[ $seq1->[$_[0]],$_[0] ]);
		    $last1=$_[0] };		      

  my $add =   sub { $addtokcnt++;
                    &$adddiscard; #($_[0],$_[1]);
		    push(@$addblock,[ $seq2->[$_[1]],$_[1] ]);
		    $last2=$_[1] };		      

  my $match = sub { $mattokcnt++;
                    if ($cnt==0) {   # first word of matching sequence after changed sequence or at beginning of word sequence
		      $deltextblocks = extracttextblocks($delblock); 
		      $delblkcnt++ if scalar @$delblock;
		      $addtextblocks = extracttextblocks($addblock);
		      $addblkcnt++ if scalar @$addblock;

		      $delcmds = extractcommands($delblock);
      		      $addcmds = extractcommands($addblock);
		      # keygen(third argument of _longestCommonSubsequence) implies to sort on command (0th elements of $addcmd elements)
		      # the calling format for longestCommonSubsequence has changed between versions of
		      # Algorithm::Diff so we need to check which one we are using
		      if ( $algodiffversion  > 1.15 ) {
			### Algorithm::Diff 1.19
			$matchindex=Algorithm::Diff::_longestCommonSubsequence($delcmds,$addcmds, 0, sub { $_[0]->[0] } );
		      } else {
			### Algorithm::Diff 1.15	
			$matchindex=Algorithm::Diff::_longestCommonSubsequence($delcmds,$addcmds, sub { $_[0]->[0] } );
		      }

		      for ($i=0 ; $i<=$#$matchindex ; $i++) {
			if (defined($matchindex->[$i])){
			  $j=$matchindex->[$i];
			  @delmid=splitlatex($delcmds->[$i][3]);
			  @addmid=splitlatex($addcmds->[$j][3]);
			  while (scalar(@$deltextblocks)  && $deltextblocks->[0][0]<$delcmds->[$i][1]) {
			    my ($index,$block,$cnt)=@{ shift(@$deltextblocks) };
			    push(@$todo, [$index,-1,$cnt,@$block]);
			  }
			  push(@$todo, [ $delcmds->[$i][1],-1,-1,$delcmds->[$i][2],@delmid,$delcmds->[$i][4]]);

			  while (scalar(@$addtextblocks) && $addtextblocks->[0][0]<$addcmds->[$j][1]) {
			    my ($index,$block,$cnt)=@{ shift(@$addtextblocks) };
			    push(@$todo, [-1,$index,$cnt,@$block]);
			  }
			  push(@$todo, [ -1,$addcmds->[$j][1],-1,$addcmds->[$j][2],@addmid,$addcmds->[$j][4]]);
			}
		      }
		      # mop up remaining textblocks
		      while (scalar(@$deltextblocks)) {
			my ($index,$block,$cnt)=@{ shift(@$deltextblocks) } ;
			push(@$todo, [$index,-1,$cnt,@$block]);
		      }
		      while (scalar(@$addtextblocks)) {
			my ($index,$block,$cnt)=@{ shift(@$addtextblocks) };
			push(@$todo, [-1,$index,$cnt,@$block]);
		      }
		      
		      $addblock=[];
		      $delblock=[];
		    }
		    push(@$block,$seq2->[$_[1]]);  
		    $cnt++  };

  my $keyfunc = sub { join("  ",split(" ",shift())) };

  traverse_sequences($seq1,$seq2, { MATCH=>$match, DISCARD_A=>$discard, DISCARD_B=>$add }, $keyfunc );


  # now carry out the merging/splitting.  Refer to elements relative from 
  # the end (with negative indices) as these offsets don't change before the instruction is executed
  # cnt>0: merged small unchanged groups with previous changed blocks
  # cnt==-1: split textual commands into components
  foreach $instruction ( @$todo) {
    ($last1,$last2,$cnt,@$block)=@$instruction ;
    if ($cnt>=0) {
      splice(@$seq1,$last1-$len1,1+$cnt,join("",$seq1->[$last1-$len1],@$block)) if $last1>=0;
      splice(@$seq2,$last2-$len2,1+$cnt,join("",$seq2->[$last2-$len2],@$block)) if $last2>=0;
    } else {
      splice(@$seq1,$last1-$len1,1,@$block) if $last1>=0;
      splice(@$seq2,$last2-$len2,1,@$block) if $last2>=0;
    }
  }

  if ($verbose) { 
    print STDERR "\n";
    print STDERR "  $mattokcnt matching  tokens in $matblkcnt blocks.\n";
    print STDERR "  $deltokcnt discarded tokens in $delblkcnt blocks.\n";
    print STDERR "  $addtokcnt appended  tokens in $addblkcnt blocks.\n";
  }
}


# extracttextblocks(\@blockindex)
# $blockindex has the following format 
# [ [ token1, index1 ], [token2, index2],.. ] 
# where index refers to the index in the original old or new word sequence 
# Returns: reference to an array of the form  
# [[ $index, $textblock, $cnt ], ..
# where $index index of block to be merged
#       $textblock contains all the words to be merged with the word at $index (but does not contain this word)
#       $cnt   is length of block
#
# requires: iscmd
#
sub extracttextblocks { 
  my $block=shift;
  my ($i,$token,$index);
  my $textblock=[];
  my $last=-1;
  my $wpat=qr/^(?:[a-zA-Z.,'`:;?()!]*)[\s~]*$/;  #'
  my $retval=[];

  for ($i=0;$i< scalar @$block;$i++) {
    ($token,$index)=@{ $block->[$i] };
    # store pure text blocks
    if ($token =~ /$wpat/ ||  ( $token =~/^\\([\w\d\*]+)((?:${extraspace}\[$brat0\]${extraspace}|${extraspace}\{$pat4\})*)/o 
				&& iscmd($1,\@SAFECMDLIST,\@SAFECMDEXCL) 
				&& !iscmd($1,\@TEXTCMDLIST,\@TEXTCMDEXCL))) {
      # we have text or a command which can be treated as text
      if ($last<0) {
	# new pure-text block
	$last=$index;
      } else {
	# add to pure-text block
	push(@$textblock, $token); 
      }
    } else {
      # it is not text
      if (scalar(@$textblock)) {
	push(@$retval,[ $last, $textblock, scalar(@$textblock) ]);
      }
      $textblock=[];
      $last=-1;
    }
  }
  # finish processing a possibly unfinished block before returning
  if (scalar(@$textblock)) {
    push(@$retval,[ $last, $textblock, scalar(@$textblock) ]);
  }
  return($retval)
}



# extractcommands( \@blockindex )
# $blockindex has the following format 
# [ [ token1, index1 ], [token2, index2],.. ] 
# where index refers to the index in the original old or new word sequence 
# Returns: reference to an array of the form  
# [ [ "\cmd1", index, "\cmd1[optarg]{arg1}{", "arg2" ,"} " ],.. 
# where index is just taken from input array 
# command must have a textual argument as last argument 
# 
# requires: iscmd 
# 
sub extractcommands { 
  my $block=shift;
  my ($i,$token,$index,$cmd,$open,$mid,$closing);
  my $retval=[];

  for ($i=0;$i< scalar @$block;$i++) {
    ($token,$index)=@{ $block->[$i] };
    # check if token is an alphanumeric command sequence with at least one non-optional argument
    # \cmd[...]{...}{last argument}  
    # Capturing in the following results in these associations
    # $1: \cmd[...]{...}{
    # $2: \cmd
    # $3: last argument
    # $4: }  + trailing spaces
    if ( ( $token =~ m/^(\\([\w\d\*]+)(?:${extraspace}\[$brat0\]|${extraspace}\{$pat4\})*${extraspace}\{)($pat4)(\}\s*)$/so )
	 && iscmd($2,\@TEXTCMDLIST,\@TEXTCMDEXCL) ) {
      #      push(@$retval,[ $2,$index,$1,$3,$4 ]);
      ($cmd,$open,$mid,$closing) = ($2,$1,$3,$4) ;
      $closing =~ s/\}/\\RIGHTBRACE/ ;
      push(@$retval,[ $cmd,$index,$open,$mid,$closing ]);
    }
  }
  return $retval;
}

# iscmd($cmd,\@regexarray,\@regexexcl) checks
# return 1 if $cmd matches any of the patterns in the 
# array $@regexarray, and none of the patterns in \@regexexcl, otherwise return 0
sub iscmd {
  my ($cmd,$regexar,$regexexcl)=@_;
  my ($ret)=0;
  foreach $pat ( @$regexar ) {
    if ( $cmd =~ m/^${pat}$/ ) {
      $ret=1 ; 
      last;
    }
  }
  return 0 unless $ret;
  foreach $pat ( @$regexexcl ) {
    return 0 if ( $cmd =~ m/^${pat}$/ );
  }
  return 1;
}


# pass2( \@seq1,\@seq2)
# Look for differences between seq1 and seq2.  
# Mark begin and end of deleted and appended sequences with tags $DELOPEN and $DELCLOSE
# and $ADDOPEN and $ADDCLOSE, respectively, however exclude { } & and all comands, unless
# they match an element of the whitelist (SAFECMD)
# For words in TEXTCMD but not in SAFECMD, enclose interior with $ADDOPEN and $ADDCLOSE brackets
# Deleted comment lines are marked with %DIF < 
# Added comment lines are marked with %DIF > 
sub pass2 {
  my $seq1 = shift ;
  my $seq2 = shift ;

  my ($addtokcnt,$deltokcnt,$mattokcnt)=(0,0,0);
  my ($addblkcnt,$delblkcnt,$matblkcnt)=(0,0,0);

  my $retval = [];
  my $delhunk   = [];
  my $addhunk   = [];

  my $discard = sub { $deltokcnt++;
                      push ( @$delhunk, $seq1->[$_[0]]) };

  my $add = sub { $addtokcnt++;
                  push ( @$addhunk, $seq2->[$_[1]]) };

  my $match = sub { $mattokcnt++;
		    if ( scalar @$delhunk ) {
                      $delblkcnt++;
		      # mark up changes, but comment out commands
                      push @$retval,marktags($DELMARKOPEN,$DELMARKCLOSE,$DELOPEN,$DELCLOSE,$DELCMDOPEN,$DELCMDCLOSE,$DELCOMMENT,$delhunk);
		      $delhunk = [];
		    }
                    if ( scalar @$addhunk ) {
                      $addblkcnt++;
                      # we mark up changes, but simply quote commands
                      push @$retval,marktags($ADDMARKOPEN,$ADDMARKCLOSE,$ADDOPEN,$ADDCLOSE,"","",$ADDCOMMENT,$addhunk);
		      $addhunk = [];
		    }
		    push(@$retval,$seq2->[$_[1]]) };
 
  my $keyfunc = sub { join("  ",split(" ",shift())) };

  traverse_sequences($seq1,$seq2, { MATCH=>$match, DISCARD_A=>$discard, DISCARD_B=>$add }, $keyfunc );
  # clear up unprocessed hunks
  push @$retval,marktags($DELMARKOPEN,$DELMARKCLOSE,$DELOPEN,$DELCLOSE,$DELCMDOPEN,$DELCMDCLOSE,$DELCOMMENT,$delhunk) if scalar @$delhunk;
  push @$retval,marktags($ADDMARKOPEN,$ADDMARKCLOSE,$ADDOPEN,$ADDCLOSE,"","",$ADDCOMMENT,$addhunk) if scalar @$addhunk;


  if ($verbose) { 
    print STDERR "\n";
    print STDERR "  $mattokcnt matching  tokens. \n";
    print STDERR "  $deltokcnt discarded tokens in $delblkcnt blocks.\n";
    print STDERR "  $addtokcnt appended  tokens in $addblkcnt blocks.\n";
  }

  return(@$retval);
}

# marktags($openmark,$closemark,$open,$close,$opencmd,$closecmd,$comment,\@block)
# returns ($openmark,$open,$block,$close,$closemark) if @block only contains no commands (except white-listed ones),
# braces, ampersands, or comments
# mark comments with $comment
# exclude all other exceptions from scope of open, close like this
# ($openmark, $open,...,$close, $opencomd,command, command,$closecmd, $open, ..., $close, $closemark)
# If $opencmd begins with "%" marktags assumes it is operating on a deleted block, otherwise on an added block
sub marktags {
  my ($openmark,$closemark,$open,$close,$opencmd,$closecmd,$comment,$block)=@_;
  my $word;
  my (@argtext);
  my $retval=[];
  my $noncomment=0;
  my $cmd=-1;    # -1 at beginning 0: last token written is a ordinary word 
                 # 1: last token written is a command
                # for keeping track whether we are just in a command sequence or in a word sequence
  my $cmdcomment= ($opencmd =~ m/^%/);  # Flag to indicate whether opencmd is a comment (i.e. if we intend to simply comment out changed commands)
  my ($command,$commandword,$closingbracket) ; # temporary variables needed below to remember sub-pattern matches

# split this block to flatten out sequences joined in pass1
  @$block=splitlatex(join "",@$block);
  foreach (@$block) {
    $word=$_; 
    if ( $word =~ s/^%/%$comment/ ) {
      # a comment
      if ($cmd==1) {
	push (@$retval,$closecmd) ;
	$cmd=-1;
      }
      push (@$retval,$word); 
      next;
    }
    if (! $noncomment) {
      push (@$retval,$openmark); 
      $noncomment=1;
    }
    # negative lookahead pattern (?!) in second clause is put in to avoid mathcing \( .. \) patterns
    if ( $word =~ /^[&{}\[\]]/ || ( $word =~ /^\\(?!\()([\w*@]*)/ && !iscmd($1,\@SAFECMDLIST,\@SAFECMDEXCL)) ) {
      # word is a command or other significant token (not in SAFECMDLIST)
	## same conditions as in subroutine extractcommand:
	# check if token is an alphanumeric command sequence with at least one non-optional argument
	# \cmd[...]{...}{last argument}  
	# Capturing in the following results in these associations
	# $1: \cmd[...]{...}{
	# $2: \cmd
	# $3: last argument
	# $4: }  + trailing spaces
	### pre-0.3    if ( ( $token =~ m/^(\\([\w\d\*]+)(?:\[$brat0\]|\{$pat4\})*\{)($pat4)(\}\s*)$/so )
      if ( ( $word =~ m/^(\\([\w\d\*]+)(?:${extraspace}\[$brat0\]|${extraspace}\{$pat4\})*${extraspace}\{)($pat4)(\}\s*)$/so )
	   && iscmd($2,\@TEXTCMDLIST,\@TEXTCMDEXCL)  && ( !$cmdcomment || !iscmd($2,\@CONTEXT2CMDLIST, \@CONTEXT2CMDEXCL) )  ) {	 
	# word is a text command - we mark up the interior of the word. But if we are in a deleted block ($cmdcomment=1) and
        # $2 (the command) is in context2, just treat it as an ordinary command (i.e. comment it open with $opencmd)
        # Because we do not want to disable this command
	# here we do not use $opencmd and $closecmd($opencmd is empty) 
	if ($cmd==1) {
	  push (@$retval,$closecmd) ;
	} elsif ($cmd==0) { 
	  push (@$retval,$close) ;
	}
        $command=$1; $commandword=$2; $closingbracket=$4;
	@argtext=splitlatex($3);   # split textual argument into tokens
	# and mark it up (but we do not need openmark and closemark)
        # insert command with initial arguments, marked-up final argument, and closing bracket
	if ( $cmdcomment && iscmd($commandword,\@CONTEXT1CMDLIST, \@CONTEXT1CMDEXCL) ) {
	  # context1cmd in a deleted environment; delete command itself but keep last argument, marked up
	  push (@$retval,$opencmd);
	  $command =~ s/\n/\n${opencmd}/sg ; # repeat opencmd at the beginning of each line
	  # argument, note that the additional comment character is included
          # to suppress linebreak after opening parentheses, which is important
          # for latexrevise
          push (@$retval,$command,"%\n{$AUXCMD\n",marktags("","",$open,$close,$opencmd,$closecmd,$comment,\@argtext),$closingbracket);
	} else {
	  # normal textcmd or context1cmd in an added block
	  push (@$retval,$command,marktags("","",$open,$close,$opencmd,$closecmd,$comment,\@argtext),$closingbracket);  
	}
	push (@$retval,$AUXCMD,"\n") if $cmdcomment ;
	$cmd=-1 ;
      } else {
	# ordinary command
	push (@$retval,$opencmd) if $cmd==-1 ;
	push (@$retval,$close,$opencmd) if $cmd==0 ;
	$word =~ s/\n/\n${opencmd}/sg if $cmdcomment ;   # if opencmd is a comment, repeat this at the beginning of every line
	push (@$retval,$word);
	$cmd=1;
      }
    } else {
      # just an ordinary word or word in SAFECMD
      push (@$retval,$open) if $cmd==-1 ;
      push (@$retval,$closecmd,$open) if $cmd==1 ;
      push (@$retval,$word);
      $cmd=0;
    }
  }
  push (@$retval,$close) if $cmd==0;
  push (@$retval,$closecmd) if $cmd==1;

  push (@$retval,$closemark) if ($noncomment);
  return @$retval;
}

# preprocess($string, ..)
# carry out the following pre-processing steps for all arguments:
# 1. Remove leading white-space
# 2. mark all first empty line (in block of several) with \PAR tokens
# 3. Convert all '\%' into '\PERCENTAGE ' to make parsing regular expressions easier
# 4. Convert all \verb|some verbatim text| commands (where | can be an arbitrary character)
#    into \verb{hash}
# 5. Convert \begin{verbatim} some verbatim text \end{verbatim} into \verbatim{hash}
# 6. Convert _n into \SUBSCRIPTNB{n} and _{nnn} into \SUBSCRIPT{nn}
# 7. Convert ^n into \SUPERSCRIPTNB{n} and ^{nnn} into \SUPERSCRIPT{nn}
# 8. a. Convert $$ $$ into \begin{DOLLARDOLLAR} \end{DOLLARDOLLAR}
#    b. Convert \[ \] into \begin{SQUAREBRACKET} \end{SQUAREBRACKET}

# 9. Add final token STOP to the very end.  This is put in because the algorithm works better if the last token is identical.  This is removed again in postprocessing.
#
# NB: step 6 and 7 is likely to  convert some "_" inappropriately, e.g. in file
#     names or labels but it does not matter because they are converted back in the postprocessing step
# Returns: leading white space removed in step 1
sub preprocess {
  my @leadin=() ;
  for (@_) { 
    s/^(\s*)//s;
    push(@leadin,$1);
    s/\n(\s*?)\n((?:\s*\n)*)/\n$1\\PAR\n$2/g ;
    s/(?<!\\)\\%/\\PERCENTAGE /g ;  # (?<! is negative lookbehind assertion to prevent \\% from being converted
    s/(\\verb\*?)(\S)(.*?)\2/"${1}{". tohash(\%verbhash,"${2}${3}${2}") ."}"/esg;
    s/\\begin\{(verbatim\*?)\}(.*?)\\end\{\1\}/"\\${1}{". tohash(\%verbhash,"${2}") . "}"/esg;
    # Convert _n or _\cmd into \SUBSCRIPTNB{n} or \SUBSCRIPTNB{\cmd} and _{nnn} into \SUBSCRIPT{nn}
    s/_([^{\\]|\\\w+)/\\SUBSCRIPTNB{$1}/g ;
    s/_{($pat4)}/\\SUBSCRIPT{$1}/g ;
    # Convert ^n into \SUPERSCRIPTNB{n} and ^{nnn} into \SUPERSCRIPT{nn}
    s/\^([^{\\]|\\\w+)/\\SUPERSCRIPTNB{$1}/g ;
    s/\^{($pat4)}/\\SUPERSCRIPT{$1}/g ;
    # Convert $$ $$ into \begin{DOLLARDOLLAR} \end{DOLLARDOLLAR}
    s/\$\$(.*?)\$\$/\\begin{DOLLARDOLLAR}$1\\end{DOLLARDOLLAR}/sg;
    # Convert \[ \] into \begin{SQUAREBRACKET} \end{SQUAREBRACKET}
    s/(?<!\\)\\\[/\\begin{SQUAREBRACKET}/sg;
    s/\\\]/\\end{SQUAREBRACKET}/sg;
    # add final token " STOP"
    $_ .= " STOP"
  }
  return(@leadin);
}

#hashstring=tohash(\%hash,$string)
# creates a hash value based on string and stores in %hash
sub tohash {
  my ($hash,$string)=@_;
  my (@arr,$val);
  my ($sum,$i)=(0,1);
  my ($hstr);

  @arr=unpack('c*',$string);

  foreach $val (@arr) {
    $sum += $i*$val;
    $i++;
  }
  $hstr= "$sum";
  if (defined($hash->{$hstr}) && $string ne $hash->{$hstr}) {
    warn "Repeated hash value for verbatim mode in spite of different content.";
    $hstr="-$hstr";
  }
  $hash->{$hstr}=$string;
  return($hstr);
}

#string=fromhash(\%hash,$fromstring)
# restores string value stored in hash
#string=fromhash(\%hash,$fromstring,$prependstring)
# additionally begins each line with prependstring
sub fromhash {
  my ($hash,$hstr)=($_[0],$_[1]);
  my $retstr=$hash->{$hstr};
  if ( $#_ >= 2) {
    $retstr =~ s/^/$_[2]/mg;
  }
  return $retstr;
}


# postprocess($string, ..)
# carry out the following post-processing steps for all arguments:
# * Remove STOP token from the end
# * Replace \RIGHTBRACE by }
# 1. Check all deleted blocks: 
#    a.where a deleted block contains a matching \begin and
#      \end environment (these will be disabled by a %DIFDELCMD statements), for selected environment enable enable
#      these commands again (such that for example displayed math in a deleted equation
#      is properly within math mode.  For math mode environments replace numbered equation
#      environments with their display only variety (so that equation numbers in new file and
#      diff file are identical).  Where the correct type of math environment cannot be determined
#      use a place holder MATHMODE
#    b.where one of the commands matching $COUNTERCMD is used as a DIFAUXCMD, add a statement
#      subtracting one from the respective counter to keep numbering consistent with new file
#    Replace all MATHMODE environment commands by the correct environment to achieve matching
#    pairs
#    c. If in-line math mode contains array environment, enclose the whole environment in \mbox'es
# 2. Remove DIFadd, DIFdel, DIFFaddbegin , ... from picture environments
# 3. Convert DIFadd, DIFdel, DIFFaddbegin , ... into FL varieties
#    within floats (currently recognised float environments: plate,table,figure
#    plus starred varieties).
# 4. Remove empty %DIFDELCMD < lines 
# 4. Convert \begin{SQUAREBRACKET} \end{SQUAREBRACKET} into \[ \]
#    Convert \begin{DOLLARDOLLAR} \end{DOLLARDOLLAR} into $$ $$
# 5. Convert  \SUPERSCRIPTNB{n} into ^n  and  \SUPERSCRIPT{nn} into ^{nnn}
# 6. Convert  \SUBSCRIPTNB{n} into _n  and  \SUBCRIPT{nn} into _{nnn}
# 7. Expand hashes of verb and verbatim environments
# 8. Convert '\PERCENTAGE ' back into '\%'
# 9.. remove all \PAR tokens
# 10.  package specific processing:  endfloat: make sure \begin{figure} and \end{figure} are always
#      on a line by themselves, similarly for table environment
#  4, undo renaming of the \begin and \end in comments

#
# Note have to manually synchronize substitution commands below and 
# DIF.. command names in the header
sub postprocess {
  my ($begin,$len,$cnt,$float,$delblock,$addblock);
  # second level blocks
  my ($begin2,$cnt2,$len2,$eqarrayblock,$mathblock);

  for (@_) { 

    # change $'s in comments to something harmless
    1 while s/(%.*)\$/$1DOLLARDIF/mg ;

    # Remove final STOP token
    s/ STOP$//;
    # Replace \RIGHTBRACE by }    
    s/\\RIGHTBRACE/}/g;
    # Check all deleted blocks: where a deleted block contains a matching \begin and
    #    \end environment (these will be disabled by a %DIFDELCMD statements), enable
    #    these commands again (such that for example displayed math in a deleted equation
    #    is properly within math mode.  For math mode environments replace numbered equation
    #    environments with their display only variety (so that equation numbers in new file and
    #    diff file are identical
    while ( m/\\DIFdelbegin.*?\\DIFdelend/sg ) {
      $cnt=0;
      $len=length($&);
      $begin=pos($_) - $len;
      $delblock=$&;


      ### (.*?[^\n]?)\n? construct is necessary to avoid empty lines in math mode, which result in
      ### an error
      # displayed math environments
      $delblock=~ s/(\%DIFDELCMD < \s*\\begin\{((?:$MATHENV)|SQUAREBRACKET)\}\s*?(?:$DELCMDCLOSE|\n))(.*?[^\n]?)\n?(\%DIFDELCMD < \s*\\end\{\2\})/\\begin{$MATHREPL}$AUXCMD\n$1$3\n\\end{$MATHREPL}$AUXCMD\n$4/sg;
      # also transform the opposite pair \end{displaymath} .. \begin{displaymath} but we have to be careful not to interfere with the results of the transformation in the line directly above
      $delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\end\{((?:$MATHENV)|SQUAREBRACKET)\}\s*?(?:$DELCMDCLOSE|\n))(.*?[^\n]?)\n?(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\begin\{\2\})/\\end{MATHMODE}$AUXCMD\n$1$3\n\\begin{MATHMODE}$AUXCMD\n$4/sg;

      # now look for unpaired %DIFDELCMD < \begin{MATHENV}; if found add \begin{$MATHREPL} and insert \end{$MATHREPL} 
      # just before end of block; again we use look-behind assertion to avoid matching constructions which have already been converted
      if ($delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\begin\{((?:$MATHENV)|SQUAREBRACKET)\}\s*?(?:$DELCMDCLOSE|\n))/$1\\begin{$MATHREPL}$AUXCMD\n/sg ) {
	$delblock =~ s/(\\DIFdelend$)/\\end{$MATHREPL}$AUXCMD\n$1/s ;
      }
      # now look for unpaired %DIFDELCMD < \end{MATHENV}; if found add \end{MATHMODE} and insert \begin{MATHMODE} 
      # just before end of block; again we use look-behind assertion to avoid matching constructions which have already been converted
      if ($delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\end\{((?:$MATHENV)|SQUAREBRACKET)\}\s*?(?:$DELCMDCLOSE|\n))/$1\\end{MATHMODE}$AUXCMD\n/sg ) {
	$delblock =~ s/(\\DIFdelend$)/\\begin{MATHMODE}$AUXCMD\n$1/s ;
      }


      # equation array environment
      $delblock=~ s/(\%DIFDELCMD < \s*\\begin\{($MATHARRENV)\}\s*?(?:$DELCMDCLOSE|\n))(.*?[^\n]?)\n?(\%DIFDELCMD < \s*\\end\{\2\})/\\begin{$MATHARRREPL}$AUXCMD\n$1$3\n\\end{$MATHARRREPL}$AUXCMD\n$4/sg;
      $delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\end\{($MATHARRENV)\}\s*?(?:$DELCMDCLOSE|\n))(.*?[^\n]?)\n?(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\begin\{\2\})/\\end{MATHMODE}$AUXCMD\n$1$3\n\\begin{MATHMODE}$AUXCMD\n$4/sg;

      # now look for unpaired %DIFDELCMD < \begin{MATHARRENV}; if found add \begin{$MATHARRREPL} and insert \end{$MATHARRREPL} 
      # just before end of block; again we use look-behind assertion to avoid matching constructions which have already been converted
      if ($delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\begin\{($MATHARRENV)\}\s*?(?:$DELCMDCLOSE|\n))/$1\\begin{$MATHARRREPL}$AUXCMD\n/sg ) {
	$delblock =~ s/(\\DIFdelend$)/\\end{$MATHARRREPL}$AUXCMD\n$1/s ;
      }
      # now look for unpaired %DIFDELCMD < \end{MATHENV}; if found add \end{MATHMODE} and insert \begin{MATHMODE} 
      # just before end of block; again we use look-behind assertion to avoid matching constructions which have already been converted
      if ($delblock=~ s/(?<!${AUXCMD}\n)(\%DIFDELCMD < \s*\\end\{($MATHARRENV)\}\s*?(?:$DELCMDCLOSE|\n))/$1\\end{MATHMODE}$AUXCMD\n/sg ) {
	$delblock =~ s/(\\DIFdelend$)/\\begin{MATHMODE}$AUXCMD\n$1/s ;
      }

      # parse $delblock for deleted and reinstated eqnarray* environments - within those reinstate \\ and & commands
      while ( $delblock =~ m/\\begin\Q{$MATHARRREPL}$AUXCMD\E\n.*?\n\\end\Q{$MATHARRREPL}$AUXCMD\E\n/sg ) {
	$cnt2=0;
	$len2=length($&);
	$begin2=pos($delblock) - $len2;
	$eqarrayblock=$&;
	# reinstate deleted & and \\ commands
	$eqarrayblock=~ s/(\%DIFDELCMD < \s*(\&|\\\\)\s*?(?:$DELCMDCLOSE|\n))/$1$2$AUXCMD\n/sg ;

	substr($delblock,$begin2,$len2)=$eqarrayblock;
	pos($delblock) = $begin2 + length($eqarrayblock);
      }



#    b.where one of the commands matching $COUNTERCMD is used as a DIFAUXCMD, add a statement
#      subtracting one from the respective counter to keep numbering consistent with new file
      $delblock=~ s/\\($COUNTERCMD)((?:${extraspace}\[$brat0\]${extraspace}|${extraspace}\{$pat4\})*\s*${AUXCMD}\n)/\\$1$2\\addtocounter{$1}{-1}${AUXCMD}\n/sg ;
#     c. If in-line math mode contains array environment, enclose the whole environment in \mbox'es
      while ( $delblock =~ m/($math)(\s*)/sg ) {
	$cnt2=0;
	$len2=length($&);
	$begin2=pos($delblock) - $len2;
	$mathblock="%\n\\mbox{$AUXCMD\n$1\n}$AUXCMD\n";
        next unless $mathblock =~ m/\{$ARRENV\}/ ;
	substr($delblock,$begin2,$len2)=$mathblock;
	pos($delblock) = $begin2 + length($mathblock);
      }

#     splice in modified delblock
      substr($_,$begin,$len)=$delblock;
      pos = $begin + length($delblock);
    }
    # make the array modification in added blocks
    while ( m/\\DIFaddbegin.*?\\DIFaddend/sg ) {
      $cnt=0;
      $len=length($&);
      $begin=pos($_) - $len;
      $addblock=$&;
      while ( $addblock =~ m/($math)(\s*)/sg ) {
	$cnt2=0;
	$len2=length($&);
	$begin2=pos($addblock) - $len2;
	$mathblock="%\n\\mbox{$AUXCMD\n$1\n}$AUXCMD\n";
        next unless $mathblock =~ m/\{$ARRENV\}/ ;
	substr($addblock,$begin2,$len2)=$mathblock;
	pos($addblock) = $begin2 + length($mathblock);
      }

#     splice in modified addblock
      substr($_,$begin,$len)=$addblock;
      pos = $begin + length($addblock);
    }


    ### old place for BEGINDIF, ENDDIF replacement
    # change begin and end commands  within comments such that they
    # don't disturb the pattern matching (if there are several \begin or \end in one line
    # this substitution is insufficient but that appears unlikely)
    s/(%.*)\\begin\{(.*)$/$1\\BEGINDIF\{$2/mg ;
    s/(%.*)\\end\{(.*)$/$1\\ENDDIF\{$2/mg ;

    # Replace MATHMODE environments from step 1a above by the correct Math environment

    # The next line is complicated.  The negative look-ahead insertion makes sure that no \end{$MATHENV} (or other mathematical
    # environments) are between the \begin{$MATHENV} and \end{MATHMODE} commands. This is necessary as the minimal matching 
    # is not globally minimal but only 'locally' (matching is beginning from the left side of the string)
    1 while s/\\begin{((?:$MATHENV)|(?:$MATHARRENV)|SQUAREBRACKET)}((?:.(?!(?:\\end{(?:(?:$MATHENV)|(?:$MATHARRENV)|SQUAREBRACKET)}|\\begin{MATHMODE})))*?)\\end{MATHMODE}/\\begin{$1}$2\\end{$1}/s;
    1 while s/\\begin{MATHMODE}((?:.(?!\\end{MATHMODE}))*?)\\end{((?:$MATHENV)|(?:$MATHARRENV)|SQUAREBRACKET)}/\\begin{$2}$1\\end{$2}/s;
    # convert remaining \begin{MATHMODE} \end{MATHMODE} (and not containing & or \\ )into MATHREPL environments
    s/\\begin{MATHMODE}((?:(.(?!(?<!\\)\&|\\\\))*)?)\\end{MATHMODE}/\\begin{$MATHREPL}$1\\end{$MATHREPL}/sg;
    # others into MATHARRREPL
    s/\\begin{MATHMODE}(.*?)\\end{MATHMODE}/\\begin{$MATHARRREPL}$1\\end{$MATHARRREPL}/sg;

    # now look for AUXCMD math-mode pairs which have only comments (or empty lines between them), and remove the added commands
    s/\\begin{((?:$MATHENV)|(?:$MATHARRENV)|SQUAREBRACKET)}$AUXCMD\n((?:\s*%.[^\n]*\n)*)\\end{\1}$AUXCMD\n/$2/sg; 


    # Remove all mark up within picture environments
    while ( m/\\begin\{($PICTUREENV)\}.*?\\end\{\1\}/sg ) {
      $cnt=0;
      $len=length($&);
      $begin=pos($_) - $len;
      $float=$&;
      $float =~ s/\\DIFaddbegin //g;
      $float =~ s/\\DIFaddend //g;
      $float =~ s/\\DIFadd\{($pat4)\}/$1/g;
      $float =~ s/\\DIFdelbegin //g;
      $float =~ s/\\DIFdelend //g;
      $float =~ s/\\DIFdel\{($pat4)\}//g;
      substr($_,$begin,$len)=$float;
      pos = $begin + length($float);
    }
    # Convert DIFadd, DIFdel, DIFFaddbegin , ... into  varieties
    #    within floats (currently recognised float environments: plate,table,figure
    #    plus starred varieties).
    while ( m/\\begin\{($FLOATENV)\}.*?\\end\{\1\}/sg ) {
      $cnt=0;
      $len=length($&);
      $begin=pos($_) - $len;
      $float=$&;
      $float =~ s/\\DIFaddbegin /\\DIFaddbeginFL /g;
      $float =~ s/\\DIFaddend /\\DIFaddendFL /g;
      $float =~ s/\\DIFadd\{/\\DIFaddFL{/g;
      $float =~ s/\\DIFdelbegin /\\DIFdelbeginFL /g;
      $float =~ s/\\DIFdelend /\\DIFdelendFL /g;
      $float =~ s/\\DIFdel\{/\\DIFdelFL{/g;
      substr($_,$begin,$len)=$float;
      pos = $begin + length($float);
    }
    ### former location of undo renaming of \begin and \end in comments

    # remove empty DIFCMD < lines
    s/^\Q${DELCMDOPEN}\E\n//msg;

    # Expand hashes of verb and verbatim environments (note negative look behind assertion to not leak out of DIFDELCMD comments
    s/(\\verb\*?)\{([-\d]*?)\}/"${1}". fromhash(\%verbhash,$2)/esg;
    s/${DELCMDOPEN}\\(verbatim\*?)\{([-\d]*?)\}/"${DELCMDOPEN}\\begin{${1}}".fromhash(\%verbhash,$2,$DELCMDOPEN)."${DELCMDOPEN}\\end{${1}}"/esg;
    s/\\(verbatim\*?)\{([-\d]*?)\}/"\\begin{${1}}".fromhash(\%verbhash,$2)."\\end{${1}}"/esg;
    # Convert '\PERCENTAGE ' back into '\%'			       
    s/\\PERCENTAGE /\\%/g;
    # remove all \PAR tokens (taking care to properly keep commented out PAR's
    # from introducing uncommented newlines - next line)
    s/(%DIF < )([^\n]*?)\\PAR\n/$1$2\n$1\n/sg;
    # convert PAR commands which are on a line by themselves
    s/\n(\s*?)\\PAR\n/\n\n/sg;
    # convert remaining PAR commands (which are preceded by non-white space characters, usually "}" ($ADDCLOSE)
    s/\\PAR\n/\n\n/sg;

    #  package specific processing: 
    if ( defined($packages{"endfloat"})) {
      #endfloat: make sure \begin{figure} and \end{figure} are always
      #      on a line by themselves, similarly for table environment
      print STDERR "endfloat package detected.\n" if $verbose ;
      # eliminate whitespace before and after
      s/^(\s*)(\\(?:begin|end)\{(?:figure|table)\})(\s*)$/$2/mg;
      # split lines with remaining characters before float enviroment conmmand
      s/^(.+)(\\(?:begin|end)\{(?:figure|table)\})/$1\n$2/mg;
      # split lines with remaining characters after float enviroment conmmand
      s/(\\(?:begin|end)\{(?:figure|table)\})(.+)$/$1\n$2/mg;
    }
    # undo renaming of the \begin and \end  and dollars in comments 
    s/(%.*)\\BEGINDIF\{(.*)$/$1\\begin\{$2/mg ;
    s/(%.*)\\ENDDIF\{(.*)$/$1\\end\{$2/mg ;
    1 while s/(%.*)DOLLARDIF/$1\$/mg ;
#   Convert \begin{SQUAREBRACKET} \end{SQUAREBRACKET} into \[ \]
    s/\\end{SQUAREBRACKET}/\\\]/sg;
    s/\\begin{SQUAREBRACKET}/\\\[/sg;
# 4. Convert \begin{DOLLARDOLLAR} \end{DOLLARDOLLAR} into $$ $$
    s/\\begin\{DOLLARDOLLAR\}(.*?)\\end\{DOLLARDOLLAR\}/\$\$$1\$\$/sg;
# 5. Convert  \SUPERSCRIPTNB{n} into ^n  and  \SUPERSCRIPT{nn} into ^{nnn}
    s/\\SUPERSCRIPTNB{($pat0)}/^$1/g ;
    s/\\SUPERSCRIPT{($pat4)}/^{$1}/g ;
    # Convert  \SUBSCRIPNB{n} into _n  and  \SUBCRIPT{nn} into _{nnn}
    s/\\SUBSCRIPTNB{($pat0)}/_$1/g ;
    s/\\SUBSCRIPT{($pat4)}/_{$1}/g ;

  return;
  }
}


# @diffs=linediff(\@seq1, \@seq2)
# mark up lines like this
#%DIF mm-mmdnn
#%< old deleted line(s)
#%DIF -------
#%DIF mmann-nn
#new appended line %< 
#%DIF -------
# Future extension: mark change explicitly
# Assumes: traverse_sequence traverses deletions before insertions in changed sequences
#          all line numbers relative to line 0 (first line of real file)
sub linediff {
  my $seq1 = shift ;
  my $seq2 = shift ;

  my $block = [];
  my $retseq = [];
  my @begin=('','',''); # dummy initialisation
  my $instring ; 

  my $discard = sub { @begin=('d',$_[0],$_[1]) unless scalar @$block ; 
                      push(@$block, "%DIF < " . $seq1->[$_[0]]) };
  my $add = sub { if (! scalar  @$block) {
		    @begin=('a',$_[0],$_[1]) ;}
		  elsif ( $begin[0] eq 'd' ) {
                    $begin[0]='c'; $begin[2]=$_[1];
		    push(@$block, "%DIF -------") }
                  push(@$block,  $seq2->[$_[1]] . " %DIF > " ) };
  my $match = sub { if ( scalar @$block ) {
                      if ( $begin[0] eq 'd' && $begin[1]!=$_[0]-1) {
			$instring = sprintf "%%DIF %d-%dd%d",$begin[1],$_[0]-1,$begin[2]; }
		      elsif ( $begin[0] eq 'a' && $begin[2]!=$_[1]-1) {
			$instring = sprintf "%%DIF %da%d-%d",$begin[1],$begin[2],$_[1]-1; }
		      elsif ( $begin[0] eq 'c' ) {
			$instring = sprintf "%%DIF %sc%s",
			                     ($begin[1]==$_[0]-1) ? "$begin[1]" : $begin[1]."-".($_[0]-1)  , 
			                     ($begin[2]==$_[1]-1) ? "$begin[2]" : $begin[2]."-".($_[1]-1)  ; }
		      else {
			$instring = sprintf "%%DIF %d%s%d",$begin[1],$begin[0],$begin[2]; }
		      push @$retseq, $instring,@$block, "%DIF -------" ; 
		      $block = []; 
		    }
		    push @$retseq, $seq2->[$_[1]]
		  };
  # key function: remove multiple spaces (such that insertion or deletion of redundant white space is not reported)
  my $keyfunc = sub { join("  ",split(" ",shift())) };

  traverse_sequences($seq1,$seq2, { MATCH=>$match, DISCARD_A=>$discard, DISCARD_B=>$add }, $keyfunc );
  push @$retseq, @$block if scalar @$block; 

  return wantarray ? @$retseq : $retseq ;
}



# init_regex_arr_data(\@array,"TOKEN INIT")
# scans DATA file handel for line "%% TOKEN INIT" line
# then appends each line not beginning with % into array (as a quoted regex)
sub init_regex_arr_data {
  my ($arr,$token)=@_;
  my ($copy);
  while (<DATA>) {
    if ( m/^%%BEGIN $token\s*$/ ) {
      $copy=1; }
    elsif ( m/^%%END $token\s*/ )  {
      last; }
    chomp;
    push (@$arr,qr/^$_$/) if ( $copy && !/^%/ ) ;
  }
  seek DATA,0,0;    # rewind DATA handle to file begin
}


# init_regex_arr_ext(\@array,$arg)
# fills array with regular expressions.
# if arg is a file name, then read in list of regular expressions from that file
# (one expression per line)
# Otherwise treat arg as a comma separated list of regular expressions
sub init_regex_arr_ext {
  my ($arr,$arg)=@_;
  my $regex;
  if ( -f $ arg ) {
    open(FILE,"$arg") or die ("Couldn't open $arg: $!");
    while (<FILE>) {
      chomp;
      next if /^\s*#/ || /^\s*%/ || /^\s*$/ ;
      push (@$arr,qr/^$_$/);
    }
    close(FILE);
  }
  else {
    # assume it is a comma-separated list of reg-ex
    foreach $regex (split(qr/(?<!\\),/,$arg)) {
      $regex =~ s/\\,/,/g;
      push (@$arr,qr/^$regex$/);
    }
  }
}

#exetime() returns time since last execution of this command
#exetime(1) resets this time
my $lasttime=-1;   # global variable for persistence
sub exetime {
  my $reset=0;
  my $retval;
  if ((scalar @_) >=1) {
    $reset=shift;
  }
  if ($reset) {
    $lasttime=times();
  }
  else {
    $retval=times()-$lasttime;
    $lasttime=$lasttime+$retval;
    return($retval);
  }
}


sub usage {
  die <<"EOF"; 
Usage: $0 [options] old.tex new.tex > diff.tex

Compares two latex files and writes tex code to stdout, which has the same
format as new.tex but has all changes relative to old.tex marked up or commented.

--type=markupstyle
-t markupstyle         Add code to preamble for selected markup style
                       Available styles: UNDERLINE CTRADITIONAL TRADITIONAL CFONT FONTSTRIKE INVISIBLE 
                                         CHANGEBAR CCHANGEBAR CULINECHBAR CFONTCBHBAR
                       [ Default: UNDERLINE ]

--subtype=markstyle
-s markstyle           Add code to preamble for selected style for bracketing
                       commands (e.g. to mark changes in  margin)
                       Available styles: SAFE MARGINAL DVIPSCOL
                       [ Default: SAFE ]

--floattype=markstyle
-f markstyle           Add code to preamble for selected style which 
                       replace standard marking and markup commands within floats
                       (e.g., marginal remarks cause an error within floats
                       so marginal marking can be disabled thus)
                       Available styles: FLOATSAFE IDENTICAL
                       [ Default: FLOATSAFE ]

--encoding=enc
-e enc                 Specify encoding of old.tex and new.tex. Typical encodings are
                       ascii, utf8, latin1, latin9.  A list of available encodings can be 
                       obtained by executing 
                       perl -MEncode -e 'print join ("\\n",Encode->encodings( ":all" )) ;'
                       [Default encoding is utf8 unless the first few lines of the preamble contain
                       an invocation "\\usepackage[..]{inputenc} in which case the 
                       encoding chosen by this command is asssumed. Note that ASCII (standard
                       latex) is a subset of utf8]

--preamble=file
-p file                Insert file at end of preamble instead of auto-generating
                       preamble.  The preamble must define the following commands
                       \\DIFaddbegin,\\DIFaddend,\\DIFadd{..},
                       \\DIFdelbegin,\\DIFdelend,\\DIFdel{..},
                       and varieties for use within floats
                       \\DIFaddbeginFL,\\DIFaddendFL,\\DIFaddFL{..},
                       \\DIFdelbeginFL,\\DIFdelendFL,\\DIFdelFL{..}
                       (If this option is set -t, -s, and -f options
                       are ignored.)

--exclude-safecmd=exclude-file
--exclude-safecmd="cmd1,cmd2,..."
-A exclude-file 
--replace-safecmd=replace-file
--append-safecmd=append-file
--append-safecmd="cmd1,cmd2,..."
-a append-file         Exclude from, replace or append to the list of regex
                       matching commands which are safe to use within the 
                       scope of a \\DIFadd or \\DIFdel command.  The file must contain
                       one Perl-RegEx per line (Comment lines beginning with # or % are
                       ignored). A literal comma within the comma-separated list must be
                       escaped thus "\\,",   Note that the RegEx needs to match the whole of 
                       the token, i.e., /^regex\$/ is implied and that the initial
                       "\\" of the command is not included. The --exclude-safecmd
                       and --append-safecmd options can be combined with the --replace-safecmd 
                       option and can be used repeatedly to add cumulatively to the lists.

--exclude-textcmd=exclude-file 
--exclude-textcmd="cmd1,cmd2,..."
-X exclude-file
--replace-textcmd=replace-file
--append-textcmd=append-file
--append-textcmd="cmd1,cmd2,..."
-x append-file         Exclude from, replace or append to the list of regex
                       matching commands whose last argument is text.  See
                       entry for --exclude-safecmd directly above for further details.

--replace-context1cmd=replace-file
--append-context1cmd=append-file
--append-context1cmd="cmd1,cmd2,..."
                       Replace or append to the list of regex matching commands
                       whose last argument is text but which require a particular
                       context to work, e.g. \\caption will only work within a figure
                       or table.  These commands behave like text commands, except when 
                       they occur in a deleted section, when they are disabled, but their
                       argument is shown as deleted text.

--replace-context2cmd=replace-file
--append-context2cmd=append-file
--append-context2cmd="cmd1,cmd2,..."
                       As corresponding commands for context1.  The only difference is that
                       context2 commands are completely disabled in deleted sections, including
                       their arguments.


--config var1=val1,var2=val2,...
-c var1=val1,..        Set configuration variables.
-c configfile           Available variables: 
                          MINWORDSBLOCK (integer)
                          FLOATENV (RegEx)
                          PICTUREENV (RegEx)
                          MATHENV (RegEx)
                          MATHREPL (String)
                          MATHARRENV (RegEx)
                          MATHARRREPL (String)
                          ARRENV (RegEx)
                          COUNTERCMD (RegEx)
                       This option can be repeated.


--packages=pkg1,pkg2,..
                       Tell latexdiff that .tex file is processed with the packages in list 
                       loaded.  This is normally not necessary if the .tex file includes the
                       preamble, as the preamble is automatically scanned for \\usepackage commands.
                       Use of the --packages option disables automatic scanning, so if for any
                       reason package specific parsing needs to be switched off, use --packages=none.
                       The following packages trigger special behaviour:
                       endfloat hyperref amsmath
                       [ Default: scan the preamble for \\usepackage commands to determine
                         loaded packages.]

--show-preamble        Print generated or included preamble commands to stdout.

--show-safecmd         Print list of regex matching and excluding safe commands.

--show-textcmd         Print list of regex matching and excluding commands with text argument.

--show-config          Show values of configuration variables

--show-all             Show all of the above

   NB For all --show commands, no old.tex or new.tex file needs to be given, and no 
      differencing takes place.

--allow-spaces         Allow spaces between bracketed or braced arguments to commands
                       [Default requires arguments to directly follow each other without 
                                intervening spaces]

--flatten              Replace \\input and \\include commands within body by the content
                       of the files in their argument.  If \\includeonly is present in the
                       preamble, only those files are expanded into the document. However, 
                       no recursion is done, i.e. \\input and \\include commands within 
                       included sections are not expanded.  The included files are assumed to 
                       be located in the same directories as the old and new master files,
                       respectively, making it possible to organise files into old and new directories.

--help
-h                     Show this help text.

--ignore-warnings      Suppress warnings about inconsistencies in length between input
                       and parsed strings and missing characters. 

--verbose
-V                     Output various status information to stderr during processing.
                       Default is to work silently.

--version              Show version number.
EOF
}

=head1 NAME

latexdiff - determine and markup differences between two latex files

=head1 SYNOPSIS

B<latexdiff> [ B<OPTIONS> ] F<old.tex> F<new.tex> > F<diff.tex>

=head1 DESCRIPTION

Briefly, I<latexdiff> is a utility program to aid in the management of
revisions of latex documents. It compares two valid latex files, here
called C<old.tex> and C<new.tex>, finds significant differences
between them (i.e., ignoring the number of white spaces and position
of line breaks), and adds special commands to highlight the
differences.  Where visual highlighting is not possible, e.g. for changes
in the formatting, the differences are
nevertheless marked up in the source.

The program treats the preamble differently from the main document.
Differences between the preambles are found using line-based
differencing (similarly to the Unix diff command, but ignoring white
spaces).  A comment, "S<C<%DIF E<gt>>>" is appended to each added line, i.e. a 
line present in C<new.tex> but not in C<old.tex>.  Discarded lines 
 are deactivated by prepending "S<C<%DIF E<lt>>>". Changed blocks are preceded  by
comment lines giving information about line numbers in the original files.  Where there are insignificant
differences, the resulting file C<diff.tex> will be similar to
C<new.tex>.  At the end of the preamble, the definitions for I<latexdiff> markup commands are inserted.
In differencing the main body of the text, I<latexdiff> attempts to
satisfy the following guidelines (in order of priority):

=over 3

=item 1

If both C<old.tex> and C<new.tex> are valid LaTeX, then the resulting
C<diff.tex> should also be valid LateX. (NB If a few plain TeX commands
are used within C<old.tex> or C<new.tex> then C<diff.tex> is not
guaranteed to work but usually will).

=item 2

Significant differences are determined on the level of
individual words. All significant differences, including differences
between comments should be clearly marked in the resulting source code
C<diff.tex>.

=item 3

If a changed passage contains text or text-producing commands, then
running C<diff.tex> through LateX should produce output where added
and discarded passages are highlighted.

=item 4

Where there are insignificant differences, e.g. in the positioning of
line breaks, C<diff.tex> should follow the formatting of C<new.tex>

=back

For differencing the same algorithm as I<diff> is used but words
instead of lines are compared.  An attempt is made to recognize
blocks which are completely changed such that they can be marked up as a unit.
Comments are differenced line by line
but the number of spaces within comments is ignored. Commands including
all their arguments are generally compared as one unit, i.e., no mark-up
is inserted into the arguments of commands.  However, for a selected
number of commands (for example, C<\caption> and all sectioning
commands) the last argument is known to be text. This text is
split into words and differenced just as ordinary text (use options to
show and change the list of text commands, see below). As the
algorithm has no detailed knowledge of LaTeX, it assumes all pairs of
curly braces immediately following a command (i.e. a sequence of
letters beginning with a backslash) are arguments for that command.
As a restriction to condition 1 above it is thus necessary to surround
all arguments with curly braces, and to not insert
extraneous spaces.  For example, write 

  \section{\textem{This is an emphasized section title}}

and not

  \section {\textem{This is an emphasized section title}}

or

  \section\textem{This is an emphasized section title}

even though all varieties are the same to LaTeX (but see
B<--allow-spaces> option which allows the second variety).

For environments whose content does not conform to standard LaTeX or
where graphical markup does not make sense all markup commands can be
removed by setting the PICTUREENV configuration variable, set by
default to C<picture> and C<DIFnomarkup> environments; see B<--config>
option).  The latter environment (C<DIFnomarkup>) can be used to
protect parts of the latex file where the markup results in illegal
markup. You have to surround the offending passage in both the old and
new file by C<\begin{DIFnomarkup}> and C<\end{DIFnomarkup}>. You must
define the environment in the preambles of both old and new
documents. I prefer to define it as a null-environment,

C<\newenvironment{DIFnomarkup}{}{}>

but the choice is yours.  Any markup within the environment will be
removed, and generally everything within the environment will just be
taken from the new file.

It is also possible to difference files which do not have a preamble. 
 In this case, the file is processed in the main document
mode, but the definitions of the markup commands are not inserted.

All markup commands inserted by I<latexdiff> begin with "C<\DIF>".  Added
blocks containing words, commands or comments which are in C<new.tex>
but not in C<old.tex> are marked by C<\DIFaddbegin> and C<\DIFaddend>.
Discarded blocks are marked by C<\DIFdelbegin> and C<\DIFdelend>.
Within added blocks all text is highlighted with C<\DIFadd> like this:
C<\DIFadd{Added text block}>
Selected `safe' commands can be contained in these text blocks as well
(use options to show and change the list of safe commands, see below).
All other commands as well as braces "{" and "}" are never put within
the scope of C<\DIFadd>.  Added comments are marked by prepending
"S<C<%DIF E<gt> >>".

Within deleted blocks text is highlighted with C<\DIFdel>.  Deleted
comments are marked by prepending "S<C<%DIF E<lt> >>".  Non-safe command
and curly braces within deleted blocks are commented out with 
"S<C<%DIFDELCMD E<lt> >>".



=head1 OPTIONS

=head2 Preamble

The following options determine the visual markup style by adding the appropriate
command definitions to the preamble. See the end of this section for a description of 
available styles.

=over 4

=item B<--type=markupstyle> or
B<-t markupstyle>

Add code to preamble for selected markup style. This option defines
C<\DIFadd> and C<\DIFdel> commands.
Available styles: 

C<UNDERLINE CTRADITIONAL TRADITIONAL CFONT FONTSTRIKE INVISIBLE 
CHANGEBAR CCHANGEBAR CULINECHBAR CFONTCBHBAR>

[ Default: C<UNDERLINE> ]

=item B<--subtype=markstyle> or
B<-s markstyle> 

Add code to preamble for selected style for bracketing
commands (e.g. to mark changes in  margin). This option defines
C<\DIFaddbegin>, C<\DIFaddend>, C<\DIFdelbegin> and C<\DIFdelend> commands.
Available styles: C<SAFE MARGINAL DVIPSCOL>

[ Default: C<SAFE> ]

=item B<--floattype=markstyle> or
B<-f markstyle>

Add code to preamble for selected style which 
replace standard marking and markup commands within floats
(e.g., marginal remarks cause an error within floats
so marginal marking can be disabled thus). This option defines all 
C<\DIF...FL> commands.
Available styles: C<FLOATSAFE TRADITIONALSAFE IDENTICAL>

[ Default: C<FLOATSAFE> ]

=item B<--encoding=enc> or 
B<-e enc>

Specify encoding of old.tex and new.tex. Typical encodings are
C<ascii>, C<utf8>, C<latin1>, C<latin9>.  A list of available encodings can be 
obtained by executing 

C<perl -MEncode -e 'print join ("\n",Encode->encodings( ":all" )) ;' >

[Default encoding is utf8 unless the first few lines of the preamble contain
an invocation C<\usepackage[..]{inputenc}> in which case the 
encoding chosen by this command is asssumed. Note that ASCII (standard
latex) is a subset of utf8]

=item B<--preamble=file> or
B<-p file>

Insert file at end of preamble instead of generating
preamble.  The preamble must define the following commands
C<\DIFaddbegin, \DIFaddend, \DIFadd{..},
\DIFdelbegin,\DIFdelend,\DIFdel{..},>
and varieties for use within floats
C<\DIFaddbeginFL, \DIFaddendFL, \DIFaddFL{..},
\DIFdelbeginFL, \DIFdelendFL, \DIFdelFL{..}>
(If this option is set B<-t>, B<-s>, and B<-f> options
are ignored.)

=item B<--packages=pkg1,pkg2,..> 

Tell latexdiff that .tex file is processed with the packages in list
loaded.  This is normally not necessary if the .tex file includes the
preamble, as the preamble is automatically scanned for C<\usepackage> commands.
Use of the B<--packages> option disables automatic scanning, so if for any
reason package specific parsing needs to be switched off, use B<--packages=none>.
The following packages trigger special behaviour:

=over 8

=item C<amsmath> 

Configuration variable amsmath is set to C<align*> (Default: C<eqnarray*>)

=item C<endfloat> 

Ensure that C<\begin{figure}> and C<\end{figure}> always appear by themselves on a line.

=item C<hyperref>

Change name of C<\DIFadd> and C<\DIFdel> commands to C<\DIFaddtex> and C<\DIFdeltex> and 
define new C<\DIFadd> and C<\DIFdel> commands, which provide a wrapper for these commands,
using them for the text but not for the link defining command (where any markup would cause
errors).

=back

[ Default: scan the preamble for C<\\usepackage> commands to determine
  loaded packages.]



=item B<--show-preamble>

Print generated or included preamble commands to stdout.

=back

=head2 Configuration

=over 4

=item B<--exclude-safecmd=exclude-file> or
B<-A exclude-file> or  B<--exclude-safecmd="cmd1,cmd2,...">

=item B<--replace-safecmd=replace-file>

=item B<--append-safecmd=append-file> or 
B<-a append-file> or B<--append-safecmd="cmd1,cmd2,...">

Exclude from, replace or append to the list of regular expressions (RegEx)
matching commands which are safe to use within the 
scope of a C<\DIFadd> or C<\DIFdel> command.  The file must contain
one Perl-RegEx per line (Comment lines beginning with # or % are
ignored).  Note that the RegEx needs to match the whole of 
the token, i.e., /^regex$/ is implied and that the initial
"\" of the command is not included. 
The B<--exclude-safecmd> and B<--append-safecmd> options can be combined with the -B<--replace-safecmd> 
option and can be used repeatedly to add cumulatively to the lists.
 B<--exclude-safecmd>
and B<--append-safecmd> can also take a comma separated list as input. If a
comma for one of the regex is required, escape it thus "\,". In most cases it
will be necessary to protect the comma-separated list from the shell by putting
it in quotation marks.

=item B<--exclude-textcmd=exclude-file> or
B<-X exclude-file> or B<--exclude-textcmd="cmd1,cmd2,...">

=item B<--replace-textcmd=replace-file>

=item B<--append-textcmd=append-file> or 
B<-x append-file> or B<--append-textcmd="cmd1,cmd2,...">

Exclude from, replace or append to the list of regular expressions
matching commands whose last argument is text.  See
entry for B<--exclude-safecmd> directly above for further details.


=item B<--replace-context1cmd=replace-file> 

=item B<--append-context1cmd=append-file> or
=item B<--append-context1cmd="cmd1,cmd2,...">

Replace or append to the list of regex matching commands
whose last argument is text but which require a particular
context to work, e.g. \caption will only work within a figure
or table.  These commands behave like text commands, except when 
they occur in a deleted section, when they are disabled, but their
argument is shown as deleted text.

=item B<--replace-context1cmd=replace-file> 

=item B<--append-context2cmd=append-file> or
=item B<--append-context2cmd="cmd1,cmd2,...">
As corresponding commands for context1.  The only difference is that
context2 commands are completely disabled in deleted sections, including
their arguments.



=item B<--config var1=val1,var2=val2,...> or B<-c var1=val1,..>

=item B<-c configfile>

Set configuration variables.  The option can be repeated to set different
variables (as an alternative to the comma-separated list).
Available variables (see below for further explanations): 

C<MINWORDSBLOCK> (integer)

C<FLOATENV> (RegEx)

C<PICTUREENV> (RegEx)

C<MATHENV> (RegEx)

C<MATHREPL> (String)

C<MATHARRENV> (RegEx)

C<MATHARRREPL> (String)

C<ARRENV> (RegEx)

C<COUNTERCMD> (RegEx)

=item B<--show-safecmd>

Print list of RegEx matching and excluding safe commands.

=item B<--show-textcmd>

Print list of RegEx matching and excluding commands with text argument.

=item B<--show-config>

Show values of configuration variables.

=item B<--show-all>

Combine all --show commands.

NB For all --show commands, no C<old.tex> or C<new.tex> file needs to be specified, and no 
differencing takes place.


=back

=head2 Miscellaneous

=over 4

=item B<--verbose> or B<-V>

Output various status information to stderr during processing.
Default is to work silently.

=item B<--ignore-warnings>

Suppress warnings about inconsistencies in length between input and
parsed strings and missing characters.  These warning messages are
often related to non-standard latex or latex constructions with a
syntax unknown to C<latexdiff> but the resulting difference argument
is often fully functional anyway, particularly if the non-standard
latex only occurs in parts of the text which have not changed.

=item B<--allow-spaces>

Allow spaces between bracketed or braced arguments to commands.  Note
that this option might have undesirable side effects (unrelated scope
might get lumpeded with preceding commands) so should only be used if the
default produces erroneous results.  (Default requires arguments to
directly follow each other without intervening spaces).

=item B<--flatten>

Replace C<\input> and C<\include> commands within body by the content
of the files in their argument.  If C<\includeonly> is present in the
preamble, only those files are expanded into the document. However, 
no recursion is done, i.e. C<\input> and C<\include> commands within 
included sections are not expanded.  The included files are assumed to 
 be located in the same directories as the old and new master files,
respectively, making it possible to organise files into old and new directories. 

Use of this option is not recommended
primarily the processing time for the large documents is prohibitive, and
the resulting difference document no longer reflects the structure of the 
input documents. 

=item B<--help> or
B<-h>

Show help text

=item B<--version>

Show version number

=back

=head2 Predefined styles 

=head2 Major types

The major type determine the markup of plain text and some selected latex commands outside floats by defining the markup commands C<\DIFadd{...}> and C<\DIFdel{...}> .

=over 10

=item C<UNDERLINE>

Added text is wavy-underlined and blue, discarded text is struck out and red
(Requires color and ulem packages).  Overstriking does not work in displayed math equations such that deleted parts of equation are underlined, not struck out (this is a shortcoming inherent to the ulem package).

=item C<CTRADITIONAL>

Added text is blue and set in sans-serif, and a red footnote is created for each discarded 
piece of text. (Requires color package)

=item C<TRADITIONAL>

Like C<CTRADITIONAL> but without the use of color.

=item C<CFONT>

Added text is blue and set in sans-serif, and discarded text is red and very small size.

=item C<FONTSTRIKE>

Added tex is set in sans-serif, discarded text small and struck out

=item C<CCHANGEBAR>

Added text is blue, and discarded text is red.  Additionally, the changed text is marked with a bar in the margin (Requires color and changebar packages).

=item C<CFONTCHBAR>

Like C<CFONT> but with additional changebars (Requires color and changebar packages).

=item C<CULINECHBAR>

Like C<UNDERLINE> but with additional changebars (Requires color, ulem and changebar packages).

=item C<CHANGEBAR>

No mark up of text, but mark margins with changebars (Requires changebar package).

=item C<INVISIBLE>

No visible markup (but generic markup commands will still be inserted.

=back

=head2 Subtypes

The subtype defines the commands that are inserted at the begin and end of added or discarded blocks, irrespectively of whether these blocks contain text or commands (Defined commands: C<\DIFaddbegin, \DIFaddend, \DIFdelbegin, \DIFdelend>) 

=over 10

=item C<SAFE>

No additional markup (Recommended choice)

=item C<MARGIN>

Mark beginning and end of changed blocks with symbols in the margin nearby (using
the standard C<\marginpar> command - note that this sometimes moves somewhat
from the intended position.

=item C<DVIPSCOL>

An alternative way of marking added passages in blue, and deleted ones in red. Note
that C<DVIPSCOL> only works with the dvips converter, e.g. not pdflatex.
(it is recommeneded to use instead the main types to effect colored markup,
although in some cases coloring with dvipscol can be more complete).

=back

=head2 Float Types

Some of the markup used in the main text might cause problems when used within 
floats (e.g. figures or tables).  For this reason alternative versions of all
markup commands are used within floats. The float type defines these alternative commands.

=over 10

=item C<FLOATSAFE>

Use identical markup for text as in the main body, but set all commands marking the begin and end of changed blocks to null-commands.  You have to choose this float type if your subtype is C<MARGIN> as C<\marginpar> does not work properly within floats.

=item C<TRADITIONALSAFE>

Mark additions the same way as in the main text.  Deleted environments are marked by angular brackets \[ and \] and the deleted text is set in scriptscript size. This float type should always be used with the C<TRADITIONAL> and  C<CTRADITIONAL> markup types as the \footnote command does not work properly in floating environments.

=item C<IDENTICAL>

Make no difference between the main text and floats.

=back


=head2 Configuration Variables

=over 10

=item C<MINWORDSBLOCK>

Minimum number of tokens required to form an independent block. This value is
used in the algorithm to detect changes of complete blocks by merging identical text parts of less than C<MINWORDSBLOCK> to the preceding added and discarded parts.

[ Default: 3 ]

=item C<FLOATENV>

Environments whose name matches the regular expression in C<FLOATENV> are 
considered floats.  Within these environments, the I<latexdiff> markup commands
are replaced by their FL variaties.

[ Default: S<C<(?:figure|table|plate)[\w\d*@]*> >]

=item C<PICTUREENV>

Within environments whose name matches the regular expression in C<PICTUREENV>
all latexdiff markup is removed (in pathologic cases this might lead to
 inconsistent markup but this situation should be rare).

[ Default: S<C<(?:picture|DIFnomarkup)[\w\d*@]*> >]

=item C<MATHENV>,C<MATHREPL>

If both \begin and \end for a math environment (environment name matching C<MATHENV>
or \[ and \])
are within the same deleted block, they are replaced by a \begin and \end commands for C<MATHREPL>
rather than being commented out.

[ Default: C<MATHENV>=S<C<(?:displaymath|equation)> >, C<MATHREPL>=S<C<displaymath> >]

=item C<MATHARRENV>,C<MATHARRREPL>

as C<MATHENV>,C<MATHREPL> but for equation arrays

[ Default: C<MATHARRENV>=S<C<eqnarray\*?> >, C<MATHREPL>=S<C<eqnarray> >]

=item C<ARRENV>

If a match to C<ARRENV> is found within an inline math environment within a deleted or added block, then the inlined math 
is surrounded by C<\mbox{>...C<}>.  This is necessary as underlining does not work within inlined array environments.

[ Default: C<ARRENV>=S<C<(?:array|[pbvBV]matrix)> >

=item C<COUNTERCMD>

If a command in a deleted block which is also in the textcmd list matches C<COUNTERCMD> then an
additional command C<\addtocounter{>F<cntcmd>C<}{-1}>, where F<cntcmd> is the matching command, is appended in the diff file such that the numbering in the diff file remains synchronized with the
numbering in the new file.

[ Default: C<COUNTERCMD>=C<(?:footnote|part|section|subsection> ...

C<|subsubsection|paragraph|subparagraph)>  ]

=back

=head1 BUGS

UTF-8 support requires a relatively new version of perl (5.8.0 is sufficient 
but 5.6.2 up would work OK, too).

Option allow-spaces not implemented entirely consistently. It breaks
the rules that number and type of white space does not matter, as
different numbers of inter-argument spaces are treated as significant.

Please send bug reports
to I<tilmann@esc.cam.ac.uk>.  Include the serial number of I<latexdiff>
(from comments at the top of the source or use B<--version>).  If you come across latex
files that are error-free and conform to the specifications set out
above, and whose differencing still does not result in error-free
latex, please send me those files, ideally edited to only contain the
offending passage as long as that still reproduces the problem. 

=head1 SEE ALSO

L<latexrevise>

=head1 PORTABILITY

I<latexdiff> does not make use of external commands and thus should run
on any platform  supporting Perl 5.6 or higher.  If files with encodings 
other than ASCII or UTF-8 are processed, Perl 5.8 or higher is required.

The standard version of I<latexdiff> requires installation of the Perl package
C<Algorithm::Diff> (available from I<www.cpan.org> - 
I<http://search.cpan.org/~nedkonz/Algorithm-Diff-1.15>) but a stand-alone
version, I<latexdiff-so>, which has this package inlined, is available, too.
I<latexdiff-fast> requires the I<diff> command to be present.

=head1 AUTHOR

Copyright (C) 2004-2007 Frederik Tilmann

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License Version 2

Contributors of fixes and additions: V. Kuhlmann, J. Paisley, N. Becker, T. Doerges, K. Huebner
Thanks to everyone who send in bug reports.

=cut

__END__
%%BEGIN SAFE COMMANDS
% Regex matching commands which can safely be in the
% argument of a \DIFadd or \DIFdel command (leave out the \)
arabic
dashbox
emph
fbox
framebox
hspace
math.*
makebox
mbox
pageref
ref
symbol
raisebox
rule
text.*
shortstack
usebox
dag
ddag
copyright
pounds
S
P
oe
OE
ae
AE
aa
AA
o
O
l
L
frac
ss
sqrt
ldots
cdots
vdots
ddots
alpha
beta
gamma
delta
epsilon
varepsilon
zeta
eta
theta
vartheta
iota
kappa
lambda
mu
nu
xi
pi
varpi
rho
varrho
sigma
varsigma
tau
upsilon
phi
varphi
chi
psi
omega
Gamma
Delta
Theta
Lambda
Xi
Pi
Sigma
Upsilon
Phi
Psi
Omega
ps
mp
times
div
ast
star
circ
bullet
cdot
cap
cup
uplus
sqcap
vee
wedge
setminus
wr
diamond
(?:big)?triangle.*
lhd
rhd
unlhd
unrhd
oplus
ominus
otimes
oslash
odot
bigcirc
d?dagger
amalg
leq
prec
preceq
ll
(?:sq)?su[bp]set(?:eq)?
in
vdash
geq
succ(?:eq)?
gg
ni
dashv
equiv
sim(?:eq)?
asymp
approx
cong
neq
doteq
propto
models
perp
mid
parallel
bowtie
Join
smile
frown
.*arrow
(?:long)?mapsto
.*harpoon.*
leadsto
aleph
hbar
imath
jmath
ell
wp
Re
Im
mho
prime
emptyset
nabla
surd
top
bot
angle
forall
exists
neg
flat
natural
sharp
backslash
partial
infty
Box
Diamond
triangle
clubsuit
diamondsuit
heartsuit
spadesuit
sum
prod
coprod
int
oint
big(?:sq)?c[au]p
bigvee
bigwedge
bigodot
bigotimes
bigoplus
biguplus
(?:arc)?(?:cos|sin|tan|cot)h?
csc
arg
deg
det
dim
exp
gcd
hom
inf
ker
lg
lim
liminf
limsup
ln
log
max
min
Pr
sec
sup
(SUPER|SUB)SCRIPTNB
(SUPER|SUB)SCRIPT
%%END SAFE COMMANDS

%%BEGIN TEXT COMMANDS
% Regex matching commands with a text argument (leave out the \)
addcontents.*
cc
closing
chapter
dashbox
emph
encl
fbox
framebox
footnote
footnotetext
framebox
part
(sub){0,2}section\*?
(sub)?paragraph\*?
makebox
mbox
opening
parbox
raisebox
savebox
sbox
shortstack
signature
text.*
value
underline
sqrt
(SUPER|SUB)SCRIPT
%%END TEXT COMMANDS 

%%BEGIN CONTEXT1 COMMANDS
% Regex matching commands with a text argument (leave out the \), which will fail out of context, but who's arguemtn should be printed as plain text
caption
%%END CONTEXT1 COMMANDS 

%%BEGIN CONTEXT2 COMMANDS
% Regex matching commands with a text argument (leave out the \), which will fail out of context, but who's arguemtn should be printed as plain text
title
author
%%END CONTEXT2 COMMANDS 


%% TYPES (Commands for highlighting changed blocks)

%DIF UNDERLINE PREAMBLE
\RequirePackage[normalem]{ulem}
\RequirePackage{color}\definecolor{RED}{rgb}{1,0,0}\definecolor{BLUE}{rgb}{0,0,1}
\providecommand{\DIFadd}[1]{{\protect\color{blue}\uwave{#1}}}
\providecommand{\DIFdel}[1]{{\protect\color{red}\sout{#1}}}                     
%DIF END UNDERLINE PREAMBLE

%DIF CTRADITIONAL PREAMBLE
\RequirePackage{color}\definecolor{RED}{rgb}{1,0,0}\definecolor{BLUE}{rgb}{0,0,1}
\RequirePackage[stable]{footmisc}
\providecommand{\DIFadd}[1]{{\protect\color{blue} \sf #1}}
\providecommand{\DIFdel}[1]{{\protect\color{red} [..\footnote{removed: #1} ]}}
%DIF END CTRADITIONAL PREAMBLE

%DIF TRADITIONAL PREAMBLE
\RequirePackage[stable]{footmisc}
\providecommand{\DIFadd}[1]{{\sf #1}}
\providecommand{\DIFdel}[1]{{[..\footnote{removed: #1} ]}}
%DIF END TRADITIONAL PREAMBLE

%DIF CFONT PREAMBLE
\RequirePackage{color}\definecolor{RED}{rgb}{1,0,0}\definecolor{BLUE}{rgb}{0,0,1}
\providecommand{\DIFadd}[1]{{\protect\color{blue} \sf #1}}
\providecommand{\DIFdel}[1]{{\protect\color{red} \scriptsize #1}}
%DIF END CFONT PREAMBLE

%DIF FONTSTRIKE PREAMBLE
\RequirePackage[normalem]{ulem}
\providecommand{\DIFadd}[1]{{\sf #1}}
\providecommand{\DIFdel}[1]{{\footnotesize \sout{#1}}}
%DIF END FONTSTRIKE PREAMBLE

%DIF CCHANGEBAR PREAMBLE
\RequirePackage[dvips]{changebar}
\RequirePackage{color}\definecolor{RED}{rgb}{1,0,0}\definecolor{BLUE}{rgb}{0,0,1}
\providecommand{\DIFadd}[1]{\protect\cbstart{\protect\color{blue}#1}\protect\cbend}
\providecommand{\DIFdel}[1]{\protect\cbdelete{\protect\color{red}#1}\protect\cbdelete}
%DIF END CCHANGEBAR PREAMBLE

%DIF CFONTCHBAR PREAMBLE
\RequirePackage[dvips]{changebar}
\RequirePackage{color}\definecolor{RED}{rgb}{1,0,0}\definecolor{BLUE}{rgb}{0,0,1}
\providecommand{\DIFadd}[1]{\protect\cbstart{\protect\color{blue}\sf #1}\protect\cbend}
\providecommand{\DIFdel}[1]{\protect\cbdelete{\protect\color{red}\scriptsize #1}\protect\cbdelete}
%DIF END CFONTCHBAR PREAMBLE

%DIF CULINECHBAR PREAMBLE
\RequirePackage[normalem]{ulem}
\RequirePackage[dvips]{changebar}
\RequirePackage{color}
\providecommand{\DIFadd}[1]{\protect\cbstart{\protect\color{blue}\uwave{#1}}\protect\cbend}
\providecommand{\DIFdel}[1]{\protect\cbdelete{\protect\color{red}\sout{#1}}\protect\cbdelete}
%DIF END CULINECHBAR PREAMBLE

%DIF CHANGEBAR PREAMBLE
\RequirePackage[dvips]{changebar}
\providecommand{\DIFadd}[1]{\protect\cbstart{#1}\protect\cbend}
\providecommand{\DIFdel}[1]{\protect\cbdelete}
%DIF END CHANGEBAR PREAMBLE

%DIF INVISIBLE PREAMBLE
\providecommand{\DIFadd}[1]{#1}
\providecommand{\DIFdel}[1]{}
%DIF END INVISIBLE PREAMBLE


%% SUBTYPES (Markers for beginning and end of changed blocks)

%DIF SAFE PREAMBLE
\providecommand{\DIFaddbegin}{}
\providecommand{\DIFaddend}{}
\providecommand{\DIFdelbegin}{}
\providecommand{\DIFdelend}{}
%DIF END SAFE PREAMBLE

%DIF MARGIN PREAMBLE
\providecommand{\DIFaddbegin}{\protect\marginpar{a[}}
\providecommand{\DIFaddend}{\protect\marginpar{]}}
\providecommand{\DIFdelbegin}{\protect\marginpar{d[}}
\providecommand{\DIFdelend}{\protect\marginpar{]}}
%DIF END BRACKET PREAMBLE

%DIF DVIPSCOL PREAMBLE
%Note: only works with dvips converter
\RequirePackage{color}
\RequirePackage{dvipscol}
\providecommand{\DIFaddbegin}{\protect\nogroupcolor{blue}}
\providecommand{\DIFaddend}{\protect\nogroupcolor{black}}
\providecommand{\DIFdelbegin}{\protect\nogroupcolor{red}}
\providecommand{\DIFdelend}{\protect\nogroupcolor{black}}
%DIF END DVIPSCOL PREAMBLE


%% FLOAT TYPES 

%DIF FLOATSAFE PREAMBLE
\providecommand{\DIFaddFL}[1]{\DIFadd{#1}}
\providecommand{\DIFdelFL}[1]{\DIFdel{#1}}
\providecommand{\DIFaddbeginFL}{}
\providecommand{\DIFaddendFL}{}
\providecommand{\DIFdelbeginFL}{}
\providecommand{\DIFdelendFL}{}
%DIF END FLOATSAFE PREAMBLE

%DIF IDENTICAL PREAMBLE
\providecommand{\DIFaddFL}[1]{\DIFadd{#1}}
\providecommand{\DIFdelFL}[1]{\DIFdel{#1}}
\providecommand{\DIFaddbeginFL}{\DIFaddbegin}
\providecommand{\DIFaddendFL}{\DIFaddend}
\providecommand{\DIFdelbeginFL}{\DIFdelbegin}
\providecommand{\DIFdelendFL}{\DIFdelend}
%DIF END IDENTICAL PREAMBLE

%DIF TRADITIONALSAFE PREAMBLE
% procidecommand color to make this work for TRADITIONAL and CTRADITIONAL
\providecommand{\color}[1]{}
\providecommand{\DIFaddFL}[1]{\DIFadd{#1}}
\providecommand{\DIFdel}[1]{{\protect\color{red}[..{\scriptsize {removed: #1}} ]}}
\providecommand{\DIFaddbeginFL}{}
\providecommand{\DIFaddendFL}{}
\providecommand{\DIFdelbeginFL}{}
\providecommand{\DIFdelendFL}{}
%DIF END FLOATSAFE PREAMBLE

%% SPECIAL PACKAGE PREAMBLE COMMANDS

% Standard \DIFadd and \DIFdel are redefined as \DIFaddtex and \DIFdeltex
% when hyperref package is included.
%DIF HYPERREF PREAMBLE
\providecommand{\DIFadd}[1]{\texorpdfstring{\DIFaddtex{#1}}{#1}}
\providecommand{\DIFdel}[1]{\texorpdfstring{\DIFdeltex{#1}}{}}
%DIF END HYPERREF PACKAGE
