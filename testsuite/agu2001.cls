\def\currversion{November 3}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This file is agu2001.cls/sty 
%%
%% To use with LaTeX2e, this file should be named agu2001.cls
%% To use with LaTeX2.09, this file should be named agu2001.sty
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% AGU2001: LaTeX Class file for 
%% Journals Published by the
%%
%% American Geophysical Union
%%
%% Prepared by Amy Hendrickson, 
%% TeXnology Inc.
%% www.texnology.com                                                           
%% amyh@TeXnology.com
%%                                                           
%% Original version: June 24, 2001 
%%
%% Two column macros copyright 1999, 2000, 2001
%% Amy Hendrickson, TeXnology Inc.                
%%
%% Natbib Module: Copyright 1993-1999 Patrick W Daly
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\typeout{^^J^^J
AGU2001 Journal Style, American Geophysical Union
^^J
This version is dated \currversion^^J^^J}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 2e switch:

\newif\ifll
\expandafter\ifx\csname LaTeXe\endcsname\relax % LaTeX2.09 is used
\else% LaTeX2e is being used, so set ll true
\global\lltrue\fi

\ifll
\else
\long\def\DeclareOption#1#2{\toks@ {#2}%
\expandafter \edef \csname ds@#1\endcsname {\the \toks@ }}
%
\gdef\usepackage#1#{%
  \@latex@error
    {\noexpand \usepackage before \string\documentclass}%
    {\noexpand \usepackage may only appear in the document
      preamble, i.e.,\MessageBreak
      between \noexpand\documentclass and
      \string\begin{document}.}%
  \@gobble}
\def\mathrm#1{{\rm #1}}

%% Fonts to make bold in super- and sub-scripts be the right size.
  \font\sevbf =cmbx7
  \font\fivbf =cmbx5
\gdef\baselinestretch{1}
\gdef\@plus{plus}
\gdef\@minus{minus}
\global\@maxsep 20pt
\global\@dblmaxsep 20pt
\fi


%  \c@topnumber            : Number of floats allowed at the top of a column.
%  \topfraction            : Fraction of column that can be devoted to floats.
%  \c@dbltopnumber, \dbltopfraction : Same as above, but for double-column
%                          floats.
%  \c@bottomnumber, \bottomfraction : Same as above for bottom of page.
%  \c@totalnumber          : Number of floats allowed in a single column, 
%                          including in-text floats.
%  \textfraction         : Minimum fraction of column that must contain text.
%  \floatpagefraction    : Minimum fraction of page that must be taken
%                          up by float page.

%% These aren't relevant, but LaTeX looks for them anyway:
\setcounter{topnumber}{10}
\def\topfraction{.99}
\setcounter{bottomnumber}{10}
\def\bottomfraction{.99}
\setcounter{totalnumber}{20}  
\def\textfraction{.01}
\def\floatpagefraction{.5}
\setcounter{dbltopnumber}{2}
\def\dbltopfraction{.7}
\def\dblfloatpagefraction{.5}

%% Need for galley style
\newif\ifgalley

%% Need for font family baselineskip changes:
\newif\ifjdraft % keep draft for graphicx, or other graphic inclusion
                % packages

%% to get rid of a command with an argument \let\command=\eatone
\def\eatone#1{}

\ifll
\ProvidesClass{agu2001}
              [09/27/2001]

\renewcommand{\normalsize}{%
\ifjdraft
   \@setfontsize\normalsize\@xiipt{28pt}
% C&G 11/5/01  \@setfontsize\normalsize\@xpt\@xviipt
\else
   \@setfontsize\normalsize\@xpt\@xiipt
\fi
   \abovedisplayskip 10\p@ %\@plus2\p@ 
\@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}

\newcommand{\bignormalsize}{%
\ifjdraft
\@setfontsize\bignormalsize\@xiipt{28pt}
% C&G 11/5/01   \@setfontsize\bignormalsize\@xipt\@xviipt
\else
   \@setfontsize\bignormalsize\@xipt{13pt}
\fi
   \abovedisplayskip 10\p@ %\@plus2\p@ 
\@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \def\@listi{\leftmargin\leftmargini
               \topsep 0\p@ %\@plus .001pt 
               \parsep 0\p@ %\@plus .001pt 
               \itemsep \parsep}%
}
%
%C&G 
% We need to reduce the negative elasticity on the baselineskip
% \baselineskip=11pt plus .001pt minus 0.25pt
% this change moved to production.sty
%
\newcommand{\small}{%
\ifjdraft
   \@setfontsize\small\@ixpt{22pt}%
%  C&G 11/5/01  \@setfontsize\small\@ixpt{17}%
\else
   \@setfontsize\small\@ixpt{11}%
\fi
\ifgalley
\baselineskip=10pt
\else
\baselineskip=10pt plus .001pt minus 1pt
\parskip=0pt % plus .001pt %% amyh
\fi
   \abovedisplayskip 10\p@ %\@plus.001\p@ 
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 1\p@ %\@plus .001pt 
               \parsep 1\p@ %\@plus .001pt 
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}

%C&G 6/26/01 Change footnotesize to 8/9
\newcommand{\footnotesize}{%
\ifjdraft
% C&G 11/5/01  \@setfontsize\footnotesize\@viiipt{17}%
   \@setfontsize\footnotesize\@viiipt{20pt}%
\else
   \@setfontsize\footnotesize\@viiipt{9}%
\ifgalley\else
\baselineskip=9 pt plus .001pt minus .5pt
\fi\fi
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep 3\p@ \@plus\p@ \@minus\p@
               \parsep 2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}

\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}
\newcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\newcommand{\large}{\@setfontsize\large\@xiipt{14}
\ifjdraft\baselineskip=28pt\else\ifgalley\else
\baselineskip 14pt plus .01pt minus 2pt\fi\fi
   \def\@listi{\leftmargin\leftmargini
               \topsep 1\p@ \@plus .001pt 
               \parsep 1\p@ \@plus .001pt 
               \itemsep \parsep}%
}
\newcommand{\Large}{\@setfontsize\Large\@xivpt{18}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{22}}
\newcommand{\huge}{\@setfontsize\huge\@xxpt{25}}
\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{30}}

\@maxdepth\maxdepth
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*{\cal}{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*{\mit}{\@fontswitch{\relax}{\mathnormal}}

\else %% LaTeX2.09
%% To get bold super and sub-scripts in the right size:
\gdef\xpt{\textfont\z@\tenrm
  \scriptfont\z@\sevrm \scriptscriptfont\z@\fivrm
\textfont\@ne\tenmi \scriptfont\@ne\sevmi \scriptscriptfont\@ne\fivmi
\textfont\tw@\tensy \scriptfont\tw@\sevsy \scriptscriptfont\tw@\fivsy
\textfont\thr@@\tenex \scriptfont\thr@@\tenex \scriptscriptfont\thr@@\tenex
\def\unboldmath{\relax}
\def\boldmath{\relax}
\def\prm{\fam\z@\tenrm}%
\def\pit{\fam\itfam\tenit}\textfont\itfam\tenit \scriptfont\itfam\sevit
    \scriptscriptfont\itfam\sevit
\def\psl{\fam\slfam\tensl}\textfont\slfam\tensl
     \scriptfont\slfam\tensl \scriptscriptfont\slfam\tensl
\def\pbf{\fam\bffam\tenbf}\textfont\bffam\tenbf
    \scriptfont\bffam\sevbf \scriptscriptfont\bffam\fivbf
\def\ptt{\fam\ttfam\tentt}\textfont\ttfam\tentt
    \scriptfont\ttfam\tentt \scriptscriptfont\ttfam\tentt
\def\psf{\fam\sffam\tensf}\textfont\sffam\tensf
    \scriptfont\sffam\tensf \scriptscriptfont\sffam\tensf
\def\psc{\@getfont\psc\scfam\@xpt{\@mcsc}}%
\def\ly{\fam\lyfam\tenly}\textfont\lyfam\tenly
   \scriptfont\lyfam\sevly \scriptscriptfont\lyfam\fivly
\@setstrut \rm}
% 11/5/01 C&G baselineskip increased to 28pt
\gdef\@normalsize{\ifjdraft
\@setsize\normalsize{12pt}\xpt\@xpt
\baselineskip=28pt
\else
\@setsize\normalsize{12pt}\xpt\@xpt
\fi
\abovedisplayskip 10\p@ plus2\p@ minus5\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip  \z@ plus3\p@
\belowdisplayshortskip  6\p@ plus3\p@ minus3\p@
\let\@listi\@listI}
% 11/5/01 C&G baselineskip increased to 28pt
\newcommand{\bignormalsize}{%
\ifjdraft%
   \@setsize\bignormalsize{22pt}\@xipt\@xviipt%
\baselineskip=28pt%
\else%
   \@setsize\bignormalsize{13pt}\@xipt\@xipt%
\fi%
\abovedisplayskip 10\p@ plus2\p@ minus5\p@%
\belowdisplayskip \abovedisplayskip%
\abovedisplayshortskip  \z@ plus3\p@%
\belowdisplayshortskip  6\p@ plus3\p@ minus3\p@%
\let\@listi\@listI}
% 11/5/01 C&G bselineskip increased to 28pt
\gdef\small{\ifjdraft
\@setsize\small{22pt}\ixpt\@ixpt
\baselineskip=28pt
\else
\@setsize\small{11pt}\ixpt\@ixpt
\fi
\abovedisplayskip 4\p@ %plus3\p@ minus4\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip \z@ plus2\p@
\belowdisplayshortskip 4\p@ plus2\p@ minus2\p@
\def\@listi{\leftmargin\leftmargini
\topsep 4\p@ plus2\p@ minus2\p@\parsep 0\p@ plus\p@ minus\p@
\itemsep \parsep}}
\gdef\footnotesize{\ifjdraft
\@setsize\footnotesize{22pt}\viiipt\@viiipt
\baselineskip=24pt
\else
\@setsize\footnotesize{9.5pt}\viiipt\@viiipt
\fi
\abovedisplayskip 6\p@ plus2\p@ minus4\p@
\belowdisplayskip \abovedisplayskip
\abovedisplayshortskip \z@ plus\p@
\belowdisplayshortskip 3\p@ plus\p@ minus2\p@
\def\@listi{\leftmargin\leftmargini
\topsep 3\p@ plus\p@ minus\p@\parsep 2\p@ plus\p@ minus\p@
\itemsep \parsep}}
%
\gdef\scriptsize{\@setsize\scriptsize{8pt}\viipt\@viipt
\ifjdraft\baselineskip=16pt\fi}
\gdef\tiny{\@setsize\tiny{6pt}\vpt\@vpt
\ifjdraft\baselineskip=16pt\fi}
\gdef\large{\@setsize\large{14pt}\xiipt\@xiipt
\ifjdraft\baselineskip=28pt\fi}
\gdef\Large{\@setsize\Large{18pt}\xivpt\@xivpt
\ifjdraft\baselineskip=28pt\fi}
\gdef\LARGE{\@setsize\LARGE{22pt}\xviipt\@xviipt
\ifjdraft\baselineskip=28pt\fi}
\gdef\huge{\@setsize\huge{25pt}\xxpt\@xxpt}
\gdef\Huge{\@setsize\Huge{30pt}\xxvpt\@xxvpt}
%
\gdef\bfseries{\bf}
\fi

\normalsize
\let\savenormalsize\normalsize

\ifll\else
% this causes too many errors, let's get rid of it in 2.09 version:
\global\let\boldmath\relax \global\let\unboldmath\relax
\fi

%%
\newif\if@openbib
%\@openbibtrue
\@openbibfalse

%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% <===== end 2e switches
%%%%%

\def\@ptsize{0}

\@twosidetrue     %  Defines twoside option.
\@mparswitchtrue  %  Marginpars go on outside of page.

%% Special text placement: quotation, quote

\def\quotation{\footnotesize\list{}{\listparindent 1.5em
    \itemindent\listparindent
    \rightmargin\leftmargin
\parsep=0pt plus .001pt \topsep=6.5pt plus.001pt}\item[]}
\let\endquotation=\endlist

\def\quote{\list{}{\rightmargin\leftmargin}\item[]\ignorespaces}
\let\endquote=\endlist

%%%%%
%% Default Dimension Settings

\arraycolsep 3pt % was 5pt 
% Half the space between columns in an array environment.

\tabcolsep 4pt 
% Half the space between columns in a tabular environment.

\arrayrulewidth .4pt 
% Width of rules in array and tabular environment.

\doublerulesep 2pt 
% Space between adjacent rules in array or tabular env.

\tabbingsep \labelsep 
% Space used by the \' command.  (See LaTeX manual.)

\skip\@mpfootins = \skip\footins

\fboxsep = 3pt    
% Space left between box and text by \fbox and \framebox.

\fboxrule = .4pt  
% Width of rules in box made by \fbox and \framebox.

%% Setting up counters
\newcounter {chapter} %% used to reset other counters in article.
\newcounter {section}[chapter]
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]

\@addtoreset{equation}{chapter}   % Makes \chapter reset 'equation' counter.
\def\theequation{\ifappendon\Alph{section}\fi%
\arabic{equation}\themathletter}
\let\savetheequation\theequation


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%
%% Figure and table counters and parameters.

\newcounter{figure}[chapter]
\newcounter{table}[chapter]
\def\thefigure{\@arabic\c@figure\theletter}
\def\thetable{\@arabic\c@table\theletter}

\def\fps@figure{tbp}
\def\ftype@figure{1}

\def\fnum@figure{\figurename~\thefigure}

\def\figure{\@float{figure}}
\def\endfigure{\end@float\gdef\@currentlabel{}}

%% Table counters and parameters.

\def\fps@table{tbp}
\def\ftype@table{2}

\def\fnum@table{\tablename~\thetable}

%%%%
%% Listing defaults:

\def\labelenumi{\theenumi}
\def\theenumi{\normalsize\rm\arabic{enumi}.}

\def\labelenumii{\theenumii}
\def\theenumii{\hss(\roman{enumii})}
\def\p@enumii{\theenumii}

\def\labelenumiii{\normalsize\theenumiii}
\def\theenumiii{\normalsize\alph{enumiii}.}
\def\p@enumiii{\theenumiii}

\def\labelenumiv{\theenumiv}
\def\theenumiv{\normalsize\Alph{enumiv}}
\def\p@enumiv{\theenumiv}

\def\enumerate{\ifnum \@enumdepth >\thr@@ \@toodeep \else 
\advance \@enumdepth \@ne 
\edef\@enumctr{enum\romannumeral\the\@enumdepth }%
\expandafter\list\csname label\@enumctr \endcsname 
{\usecounter \@enumctr \def\makelabel ##1{%
\ifdim\leftmargin=1sp\relax\hskip\saveparindent\fi
\ifdim\leftmargin=2sp\relax\hskip2\saveparindent\fi
\hskip\@itemdepth\saveparindent\relax%
\hskip\@enumdepth\saveparindent\relax ##1}}
\fi}

\def\itemize{\ifnum \@itemdepth >\thr@@ \@toodeep \else 
\advance \@itemdepth \@ne 
\edef \@itemitem {labelitem\romannumeral\the\@itemdepth}%
\expandafter\list\csname \@itemitem \endcsname {\def\makelabel ##1{%
\ifdim\leftmargin=1sp\relax\hskip\saveparindent\fi
\ifdim\leftmargin=2sp\relax\hskip2\saveparindent\fi
\hskip\@enumdepth\saveparindent\relax%
\hskip\@itemdepth\saveparindent\relax##1}}\fi}

\newenvironment{description}
{\leftmargini=0pt \leftmarginii=1sp \leftmarginiii=2sp
\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand*\descriptionlabel[1]{\hspace\labelsep
\ifdim\leftmargin=0pt \hskip\saveparindent 
\else \ifdim\leftmargin=1sp \hskip2\saveparindent
\else \ifdim\leftmargin=2sp \hskip3\saveparindent\fi\fi\fi
                                \normalsize\it #1}

\def\labelitemi{\normalsize$\m@th\bullet$}
\def\labelitemii{{\bf --}}
\def\labelitemiii{\normalsize$\m@th\ast$}
\def\labelitemiv{\normalsize$\m@th\cdot$}

\leftmargini 0pt 
\leftmarginii 0pt
\leftmarginiii 0pt
\leftmarginiv 0 pt
\leftmarginv 0pt 
\leftmarginvi 0pt
\leftmargin\leftmargini

\labelsep 4pt
\labelwidth\leftmargini\advance\labelwidth-\labelsep

\def\@endparenv{%
  \addpenalty\@endparpenalty%\addvspace\@topsepadd\@endpetrue
}

\def\@listI{\leftmargin\leftmargini 
\rightmargin\leftmargini 
\parsep 1sp plus.001\p@ 
\topsep 1sp plus.001\p@ 
\itemsep 1sp plus.001\p@ 
}

\let\@listi\@listI
\@listi

\def\@listii{\leftmargin\leftmarginii
   \labelwidth\leftmarginii\advance\labelwidth-\labelsep
   \topsep 4\p@ plus2\p@ minus\p@
   \parsep 2\p@ plus\p@ minus\p@
   \itemsep \parsep}

\def\@listiii{\leftmargin\leftmarginiii
    \labelwidth\leftmarginiii\advance\labelwidth-\labelsep
    \topsep 2\p@ plus\p@ minus\p@
    \parsep \z@ \partopsep \p@ plus\z@ minus\p@
    \itemsep \topsep}

\def\@listiv{\leftmargin\leftmarginiv
     \labelwidth\leftmarginiv\advance\labelwidth-\labelsep}

\def\@listv{\leftmargin\leftmarginv
     \labelwidth\leftmarginv\advance\labelwidth-\labelsep}

\def\@listvi{\leftmargin\leftmarginvi
     \labelwidth\leftmarginvi\advance\labelwidth-\labelsep}

%%%%%%% 

% Makes \chapter reset 'footnote' counter:
\@addtoreset{footnote}{chapter}   
\@addtoreset{subsubsubsection}{chapter}   
\@addtoreset{subsubsubsection}{section}   
\@addtoreset{subsubsubsection}{subsection}   
\@addtoreset{subsubsubsection}{subsubsection}   


%%%%%%%
%%% General tools: Macros added or changed from original LaTeX, 

%% i) Math macros: Special equation numbers; bolding math characters
%%   that don't get bold with \mathbf; Lettered equation numbers.
%%   aguleftmath, to make second line of equation indent by parindent

%% ii)  Lettered captions for tables and figures,
%%      Multiple caption lines may center automatically.

%% iii) Tables, captions will adjust horizontal size to match width
%%      of table. Ruled lines added to top or bottom of table.
%%      Table content will extend to the left and right of columns,
%%      no extra horizontal space left.

%% iv) Date and time macros for use in Draft line

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% i) Math macros: Special equation numbers; 
%%    \bbf for making math characters bold that
%%    won't turn bold with \mathbf; Lettered equation numbers. 
%%    Aguleftmath, for second line indenting only width of parindent

%% Special equation numbers, such as 16'
%% Equation counter will not advance

\def\specialeqnum#1{\global\firsttimefalse
\mathletter{xxx}\gdef\theequation{#1}}
\let\seteqnum\specialeqnum
\let\eqnum\specialeqnum

\def\xa{a}
\def\xA{A}

%% Bold math, for making math characters bold that
%%    won't turn bold with \mathbf

\def\bbf#1{\hbox{\savenormalsize\boldmath$\displaystyle#1$}}

%% Math Letters:

\def\themathletter{\relax}
\def\mathletter#1{\gdef\themathletter{#1}}
\def\xrelax{\relax}

\let\templabel\relax
\def\xlabel#1{\gdef\templabel{#1}}
\def\ylabel#1{\gdef\ytemplabel{#1}}

\newif\iffirsttime
\global\firsttimetrue

\def\equation{$$ % $$ BRACE MATCHING HACK
\setbox0=\hbox\bgroup $ \displaystyle%
\let\label\xlabel}

\let\savelabel\label

\def\endequation{$\egroup%
%
\ifx\themathletter\xrelax\global\firsttimetrue%
\refstepcounter{equation}\else%
\ifx\themathletter\xa\global\firsttimetrue\fi
\ifx\themathletter\xA\global\firsttimetrue\fi
\iffirsttime\global\firsttimefalse\refstepcounter{equation}\fi\fi%
%
\setbox1=\hbox{\copy0\@eqnnum}%
%
\ifdim\wd1>\linewidth%
\vbox{\unskip\noindent\hbox to\hsize{\hss\unhbox0\hss}\vskip3pt%
\noindent\hbox to\hsize{\hfill\displaywidth\linewidth\llap{\@eqnnum}}}%
\else%
\vbox{\unskip\noindent\hbox to\linewidth{%
\hfil\unhbox0\hfil\displaywidth\linewidth\llap{\@eqnnum}}}%
\fi%
\let\@currentlabel=\theequation%
\ifx\templabel\relax\else\savelabel{\templabel}\fi%
\global\let\templabel\relax%
\gdef\theequation{\savetheequation}%
\gdef\themathletter{\relax}%
\global\@ignoretrue$$}

\def\@@eqncr{\let\@tempa\relax 
    \ifcase\@eqcnt \def\@tempa{& & &}\or \def\@tempa{& &} 
     \else \def\@tempa{&}\fi 
     \@tempa 
\ifx\themathletter\xrelax
%% make equation letters work ==>
\if@eqnsw
\ifaguleftmath\else
\stepcounter{equation}\fi\fi
%% <==
\else
\ifx\themathletter\xa\global\firsttimetrue\fi
\ifx\themathletter\xA\global\firsttimetrue\fi
\iffirsttime\global\firsttimefalse\stepcounter{equation}
\fi\fi
\if@eqnsw\@eqnnum 
\fi
\expandafter\ifx\csname ytemplabel\endcsname\relax
\else\savelabel{\ytemplabel}\fi%%% <<=== make label
\global\let\ytemplabel\relax          % catch current number and letter
\global\let\themathletter\xrelax     % <<===
\gdef\theequation{\savetheequation}
\global\@eqnswtrue\global\@eqcnt\z@\cr}

%% variation on code taken from fleqn.clo
\def\eqnarray{%
\let\label\ylabel
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
    $$\everycr{}\halign to\linewidth% $$
    \bgroup
      \hskip\@centering
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip \tw@\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip \tw@\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%


\def\endeqnarray{\@@eqncr\egroup\global\@ignoretrue$$%
\global\firsttimetrue%
\global\let\ytemplabel\relax%
\gdef\theequation{\savetheequation}%
\def\themathletter{\relax}}

\@namedef{eqnarray*}{\def\@eqncr{\nonumber\@seqncr}\eqnarray}
\@namedef{endeqnarray*}{\nonumber\endeqnarray}

%%%%%% AGUleftmath

%% Making AGU math indent by a parindent 

\newdimen\mathindent
\mathindent=0pt
\def\new@xeqncr[#1]{%
\nonumber
   \ifnum0=`{\fi}%
   \@@eqncr
   \noalign{\penalty\@eqpen\vskip\jot\vskip #1\relax}%
\hspace*{\parindent}}

\newif\ifaguleftmath
\newenvironment{aguleftmath}{%
\global\aguleftmathtrue
    \stepcounter{equation}%
    \def\@currentlabel{\p@equation\theequation}%
    \global\@eqnswtrue\m@th
    \global\@eqcnt\z@
    \tabskip\mathindent
    \let\\=\@eqncr
\let\@xeqncr=\new@xeqncr
    $$\everycr{}\halign to\hsize% $$
    \bgroup
      $\displaystyle\tabskip\z@skip{##}$\@eqnsel&%
      \global\@eqcnt\@ne \hskip \tw@\arraycolsep \hfil${##}$\hfil&%
      \global\@eqcnt\tw@ \hskip \tw@\arraycolsep
        $\displaystyle{##}$\hfil \tabskip\@centering&%
      \global\@eqcnt\thr@@
        \hb@xt@\z@\bgroup\hss##\egroup\tabskip\z@skip\cr}%
      {\@@eqncr
    \egroup
%    \global\advance\c@equation\m@ne
$$% 
\global\aguleftmathfalse
    \@ignoretrue}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ii)  Lettered captions for tables and figures,
%%      Multiple caption lines may center automatically.

\def\theletter{\relax}
\newif\ifxfirsttime
\xfirsttimetrue
\def\xtable{table}
\def\xplate{plate}
\def\xrelax{\relax}

\newif\ifcontinued
\def\continuedcaption{\global\continuedtrue\caption{(continued)}}

\def\caption{\ifx\@captype\xtable
%
\ifx\theletter\xrelax\global\xfirsttimetrue
   \ifcontinued\global\continuedfalse\else
%\ifappendon\else% don't advance counter because using another counter
   \refstepcounter{table}
%\fi
   \fi
\else
  \ifxfirsttime\global\xfirsttimefalse
     \ifcontinued\global\continuedfalse
     \else \refstepcounter{table}
     \fi
  \fi
\fi
%
\else% figure and plate
     \ifx\theletter\xrelax\global\xfirsttimetrue
       \ifcontinued\global\continuedfalse\else%
%         \ifappendon
%\ifx\@captype\xplate \refstepcounter{plate}\fi %% don't know why this works!
%\else% don't advance counter because using another counter
     \refstepcounter{\@captype}
      \fi%\fi
  \else%
    \ifxfirsttime\global\xfirsttimefalse%
      \ifcontinued\global\continuedfalse\else%
%\ifappendon
%\ifx\@captype\xplate \refstepcounter{plate}\fi %% don't know why this works!
%\else% don't advance counter because using another counter
       \refstepcounter{\@captype}
%\fi
\fi\fi\fi\fi%
\xdef\currcaptype{\@captype}%
\xdef\@currentlabel{\expandafter\csname p@\@captype\endcsname%
\expandafter\csname the\@captype\endcsname}%
\@dblarg{\@caption\@captype}}

\def\letteredcaption#1{\gdef\theletter{#1}\caption}
\def\letteredcontinuedcaption#1{\gdef\theletter{#1}\continuedcaption}

\def\appcaption#1{%
\ifx\@captype\xtable\centermultiplelinesfalse
     \ifx\theletter\xrelax%
     \global\xfirsttimetrue \ifcontinued\global\continuedfalse\else%
     \global\advance\c@apptable by 1\fi\else%
     \ifxfirsttime\global\xfirsttimefalse%
     \ifcontinued\global\continuedfalse\else%
     \global\advance\c@apptable by1\relax
\fi\fi\fi
\else%
\ifx\@captype\xplate
     \ifx\theletter\xrelax%
     \global\xfirsttimetrue\ifcontinued\global\continuedfalse\else%
     \global\advance\c@appplate by 1\fi\else%
     \ifxfirsttime\global\xfirsttimefalse%
     \ifcontinued\global\continuedfalse\else%
     \global\advance\c@appplate by1\relax
\fi\fi\fi
\else
     \ifx\theletter\xrelax%
     \global\xfirsttimetrue\ifcontinued\global\continuedfalse\else%
     \global\advance\c@appfigure by 1\fi\else%
     \ifxfirsttime\global\xfirsttimefalse%
     \ifcontinued\global\continuedfalse\else%
     \global\advance\c@appfigure by1\relax
\fi\fi\fi
\fi\fi%
%
\def\thefigure{\Alph{section}\the\c@appfigure}
\def\thetable{\Alph{section}\the\c@apptable}
\def\theplate{\Alph{section}\the\c@appplate}
\xdef\currcaptype{\@captype}%
\xsavecaption{#1}}

\newskip\abovefigcaptionskip
\newskip\abovetabcaptionskip
\newskip\abovetableskip
\newif\ifcentermultiplelines
\newif\ifcentersingleline
\newif\ifcentersingletabline
\newif\iflineabovetabcaption
\newif\iflinebelowtabcaption
\newdimen\belowtabcaptionskip

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Landscape figures and tables. Need \usepackage{graphicx} to work.

\newif\iflandscapetable
\newif\iflandscapetaborfig
\newif\iflandscape

\newbox\landscapebox
\def\landscapeonecoltable{%
\expandafter\ifx\csname rotatebox\endcsname\relax
\show\landscapeerror\fi
\advance\textheight by-8pt %to compensate for topskip
\ifgalley
\global\setbox\landscapebox\vbox\bgroup
\hsize\textheight
\captionwidth=\landscapecaptionwidth
\centering
\def\@captype{table}\captypefigfalse
\doonecolfighere
\landscapetaborfigtrue
\else
\vskip-1.5pt
\goodbreak
\global\setbox\landscapebox\vbox\bgroup\hsize\textheight
\global\landscapetaborfigtrue
\begin{table}[h]
\hsize=\textheight
\captionwidth=\hsize
\parindent=0pt
\centering
\fi}

\def\endlandscapeonecoltable{
\ifgalley
\endonecolfighere\egroup
\insert\figinsert{\newpage\vbox to\textheight{\vss
\rotatebox{90}{\vbox{\vskip-1.5pc
\landscapetaborfigtrue
\captionwidth=\landscapecaptionwidth
\hsize=\textheight
\unvbox\landscapebox
}}\vskip-12pt}\newpage}
\else
%% not galley, normal text:
\end{table}
\egroup
\vbox to\textheight{\vskip3pt
\rotatebox{90}{\vbox to\mycolumnwidth{%
\vfill
\vbox to \mycolumnwidth{\vskip-\columnsep 
\vskip-6pt
\noindent
\unvbox\landscapebox
\vfill}}}
\vss}\vskip24pt\fi}

\def\landscapetwocoltable{%
\expandafter\ifx\csname rotatebox\endcsname\relax
\show\landscapeerror\fi
\ifgalley
\global\setbox\landscapebox\vbox\bgroup\hsize\textheight
\captionwidth=\landscapecaptionwidth
\centering
\def\@captype{table}\captypefigfalse
\doonecolfighere
\landscapetaborfigtrue
\else
\begin{table*}[p]
\newpage
\advance\textheight by-6pt
\global\setbox\landscapebox\vbox\bgroup\hsize\textheight
\landscapetaborfigtrue
\begin{table}[h]
\fi}

\def\endlandscapetwocoltable{\ifgalley
\endonecolfighere\egroup
\insert\figinsert{\newpage\vbox to\textheight{
\vskip12pt
\rotatebox{90}{\vbox{\vskip-1.5pc
\landscapetaborfigtrue
\captionwidth=\landscapecaptionwidth
\hsize=\textheight
\unvbox\landscapebox
}}\vss}\newpage}
\else
\end{table}
\egroup
\vbox to\textheight{\vskip-14pt
\rotatebox{90}{\vbox{
\landscapetaborfigtrue
\hsize=\textheight
\unvbox\landscapebox
}}\vss}\newpage
\end{table*}
\fi}

%%%

\def\landscapeonecolfigure{%
\vskip1pt
\goodbreak
\expandafter\ifx\csname rotatebox\endcsname\relax
\show\landscapeerror\fi
\advance\textheight by-6pt %to compensate for topskip
\ifgalley
\global\setbox\landscapebox\vbox to \textheight\bgroup\hsize\textheight
\captionwidth=\landscapecaptionwidth
\centering
\landscapetaborfigtrue
\def\@captype{figure}\captypefigtrue
\doonecolfighere
\landscapetaborfigtrue
\else
\vskip-1.5pt
\goodbreak
\hsize=\textheight
\global\setbox\landscapebox\vbox\bgroup\hsize\textheight
\vfill
\vskip-\intextfloatskip
\landscapetaborfigtrue
\begin{figure}[h]
\centering
\fi}

\def\endlandscapeonecolfigure{\ifgalley
\endonecolfighere\egroup
\insert\figinsert{\newpage\vbox to\textheight{\vss
\rotatebox{90}{\vbox{\landscapetaborfigtrue
\captionwidth=\landscapecaptionwidth
\hsize=\textheight
\unvbox\landscapebox
}}}}
\else
\end{figure}
\vskip-\intextfloatskip
\vskip-12pt
\vfill\egroup
\vbox to\textheight{\vskip4pt\vfill %%
\rotatebox{90}{\vbox to\mycolumnwidth{\vss
\landscapetaborfigtrue
\hsize=\textheight
\unvbox\landscapebox
\vskip\columnsep
\vskip6pt
}}\vfill}\vskip24pt\goodbreak\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\landscapetwocolfigure{%
\expandafter\ifx\csname rotatebox\endcsname\relax
\show\landscapeerror\fi
\ifgalley
\global\setbox\landscapebox\vbox to \textwidth\bgroup\hsize\textheight
\captionwidth=\landscapecaptionwidth
\centering
\landscapetaborfigtrue
\def\@captype{figure}\captypefigtrue
\doonecolfighere
\landscapetaborfigtrue
\else
\begin{figure*}[p]
\newpage
\global\setbox\landscapebox\vbox\bgroup\hsize\textheight
\landscapetaborfigtrue
\begin{figure}[h]
\centering
\fi}

\def\endlandscapetwocolfigure{\ifgalley
\endonecolfighere\egroup
\insert\figinsert{\newpage\vbox to\textheight{\vskip\topskip
\rotatebox{90}{\vbox to\textwidth{\vfill
\landscapetaborfigtrue
\captionwidth=\landscapecaptionwidth
\hsize=\textheight
\unvbox\landscapebox
}}\vss}}
\else
\end{figure}
\egroup
\vbox to\textheight{\vskip12pt
\rotatebox{90}{\vbox to0pt{\vbox to \textwidth{\vfill
\landscapetaborfigtrue
\hsize=\textheight
\unvbox\landscapebox
\vskip12pt
}\vss}}\vss}\newpage\end{figure*}\fi}

\let\landscapetable\landscapeonecoltable
\let\endlandscapetable\endlandscapeonecoltable

\expandafter%
\def\csname landscapetable*\endcsname{\landscapetwocoltable}

\expandafter%
\def\csname endlandscapetable*\endcsname{\endlandscapetwocoltable}

\let\landscapefigure\landscapeonecolfigure
\let\endlandscapefigure\endlandscapeonecolfigure

\expandafter%
\def\csname landscapefigure*\endcsname{\landscapetwocolfigure}

\expandafter%
\def\csname endlandscapefigure*\endcsname{\endlandscapetwocolfigure}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\long\def\@makecaption#1#2{%
\ifjdraft\captionwidth=\textwidth\fi%% Amy, 2/05/02
\ifx\@captype\xtable% TABLE CAPTION
\iflandscapetaborfig
\hsize=\textheight
\advance\hsize by-36pt
\captionwidth=\hsize
\vbadness=10000 \hbadness=10000
    \fi
%%
 \iflineabovetabcaption\hrule\fi%
 \vskip\abovetabcaptionskip%
%%
  \setbox\@tempboxa\hbox{\captionsize
  \tablenamefont #1. \tabletextfont#2}%
%
\ifdim \wd\@tempboxa >\hsize
\hbox to\hsize{\hfill\vbox{
\hsize=\captionwidth 
\iflandscapetaborfig
\raggedright
\fi
\parindent=0pt
\noindent\captionsize
\tablenamefont
#1.~\tabletextfont#2\vskip1sp}\hfill}%
      \par
   \else
%
\hbox to\hsize{\ifcentersingletabline\hfill\fi%
\captionsize\tablenamefont
#1.~\tabletextfont#2\hfill}%
   \fi
\vskip\belowtabcaptionskip
%
\else% FIGURE CAPTION
    \iflandscapetaborfig
\captionwidth=\landscapecaptionwidth
    \vbadness=10000 \hbadness=10000
\vskip12pt
    \fi
 \centermultiplelinesfalse
 \vskip\abovefigcaptionskip
 \iflandscape \hsize=\textheight \fi
%
  \setbox\@tempboxa\hbox{\captionsize\captionnamefont#1~~%
  \captiontextfont#2}%
%
 \ifdim \wd\@tempboxa >\hsize
   % \iflandscape\moveright26pt\fi
\hbox to\hsize{\hfill\vbox{\hsize=\captionwidth 
\captionsize\captionnamefont%
#1.~\captiontextfont#2\vskip1sp}\hfill}\par%
 \else% less than hsize in caption
\noindent\hbox to\hsize{%
\captionsize%
  \ifcentersingleline\hfill\fi%
  \captionnamefont
#1.~\captiontextfont#2\hfill}
 \fi%
\fi% end figure caption
%%%
%% either figure or table
\edef\@currentlabel{\expandafter\csname p@\@captype\endcsname%
\expandafter\csname the\@captype\endcsname}%
%
\ifx\@captype\xtable
  \iflinebelowtabcaption\vskip\belowtabcaptionskip\thetablelines\fi
  \vskip\abovetableskip
\fi
\ifhere\else\gdef\theletter{\relax}\fi%
\global\landscapetaborfigfalse}

%% Plate definitions %%

\newcounter{plate}
\def\theplate{\@arabic\c@plate}
\def\platename{Plate}
\def\fps@plate{bp}
\def\ftype@plate{4}
\def\ext@plate{lof}
\def\fnum@plate{{\bf Plate \theplate}}
\def\plate{\@float{plate}}
\let\endplate\end@float
\def\platewidth#1{\hsize=#1\relax}
\let\saveplate\plate
\let\saveendplate\endplate
%%  end plate definitions %%

%% To number captions specifically

\def\platenum#1{\let\caption\savecaption
\def\@captype{plate}
\def\theplate{#1} \let\@currentlabel\theplate  \let\label\savelabel}
\let\setplatenum\platenum

\def\setfigurenum#1{\let\caption\savecaption
\def\@captype{figure}
\def\thefigure{#1} \let\@currentlabel\thefigure \let\label\savelabel}

\def\settablenum#1{\let\caption\savecaption
\def\@captype{table}
\def\thetable{#1} \let\@currentlabel\thetable  \let\label\savelabel}

%%%% side by side captions

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% to use: 
% \begin{figure or table} \sidebyside{}{} \end{figure or table}
%
% \begin{table} 
% \sidebyside{\caption{table caption} first table}
% {\caption{table caption} second table}
% \end{table}

% or

% \begin{figure} 
%\vskip<dimen>
% \sidebyside{\caption{first fig caption}}
% {\caption{second fig caption}}
% \end{figure}

% Or, if you want different spaces above the two
% figure captions, you can put the \vskip or \vspace
% <inside> the {}{}, ie.:

% \begin{figure} 
% \sidebyside{\vskip<dimen>\caption{fig caption}}
% {\vskip<dimen>\caption{fig caption}}
% \end{figure}

% To call for line breaks, you can use \\ , but
% also supply [], i.e., \caption[]{asdf}.
% This will send whatever is in [] to the List of Tables. If
% you are not using that you can just have facing square
% brackets. If you are using List of Tables, you can supply
% a title without \\ in it: 
% \caption[$hA_3f_4K_2l_5$ 60-01-05]{$hA_3f_4K_2l_5$\\ 60-01-05}}

% If you are not using List of Tables, just supply []'s, i.e.,
%\begin{figure}[h]
%\vspace{15pc}
%\sidebyside{
%\caption[]{$hA_3f_4K_2l_5$\\ 60-01-05}}
%{\caption[]{$hD_8p_4F_xd_7$\\ 60-01-10}}
%\end{figure}

% xref labels work the same as normally:
%\begin{figure}[h]
%\vspace{4pc}
%\sidebyside{\caption{Hexiamond board.\label{three}}}
%{\caption{O'Beirne's?\label{four}}}
%\end{figure}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\specialendtable{\vskip1sp\end@float}

\long\def\sidebyside#1#2{%
\hbox to\hsize{\let\caption\savecaption
\ifcaptypefig\def\@captype{figure}\else\def\@captype{table}
\footnotesize
\fi%
\vtop{\hsize=.5\hsize%
\advance\hsize by -.5\columnsep
\parindent=0pt
\centering
 
#1}\hskip\columnsep\vtop{\hsize=.5\hsize%
\advance\hsize by -.5\columnsep
\parindent=0pt\centering
#2

}}}

%% make a caption on the right hand side with illustration to the left
\long\def\sidecaption#1#2{\setbox0=\vbox{#1}
\dimen0=\ht0 \advance\dimen0 by\dp0
\hbox to\textwidth{\let\label\savelabel
\vbox{\hsize=.65\textwidth\noindent\relax#1\vskip1sp}\hfill
\vbox to\dimen0{\hsize=.3\textwidth
\vfill
\savecaption{\hsize=.3\textwidth #2}\vfill}}\aftergroup{\let\label\savelabel}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% iii) Tables, captions will adjust horizontal size to match width
%%      of table. Ruled lines added to top or bottom of table.
%%      Table content will extend to the left and right of columns,
%%      no extra horizontal space left.

\long\def\@caption#1[#2]#3{\par
\begingroup
    \@parboxrestore
    \normalsize
    \@makecaption{\csname fnum@#1\endcsname}{\ignorespaces#3}\par
  \endgroup}

\def\catchlabel{}

\def\savetable{\@float{table}}
\let\saveendtable\end@float

%% Made \begin{specialtable}... \end{specialtable} for cases in which there
%% is a tabular inside another tabular, or for when author wants to
%% use \begin{table}...\end{table} with something other than 
%% \begin{tabular}...\end{tabular} in it.

\def\specialtable{\def\@captype{table}%
\ifcontinued\else\refstepcounter{table}\fi%
\let\tabular\savetabular\let\endtabular\saveendtabular}

\def\endspecialtable{\ifnobottomtabline\global\nobottomtablinefalse\else
\vskip6pt
\thetablelines\fi}

\def\tableterms{\bgroup\everycr={\noalign{\vskip1pt}}%
\let\\=\cr\halign\bgroup\hfill## :&\ ##\hfill\cr}

\def\endtableterms{\crcr\egroup\vskip4pt\egroup}

\newif\iffullwidthtable
\def\table{\def\tabular{\tabletextsize\xtabular}
\let\endtabular\endxtabular
\expandafter\def\csname tabular*\endcsname ##1{%
\global\setbox\savecurrtable\hbox\bgroup\tabletextsize%
\def\@halignto{to ##1}\@tabular}
\expandafter \let \csname endtabular*\endcsname = \endxtabular
\def\label##1{\gdef\catchlabel{##1}}%
\def\caption##1{\gdef\catchcaption{##1}}%
\tabletextsize%\@float{table}
}

\newif\ifnobottomtabline
\def\nobottomline{\global\nobottomtablinetrue}
\let\nobottomlines\nobottomline

\def\endtable{%
\ifx\catchcaption\empty\else
\ifx\theletter\xrelax
\global\xfirsttimetrue\ifcontinued\global\continuedfalse\else
\refstepcounter{table}\fi\else
\ifxfirsttime\global\xfirsttimefalse\ifcontinued\global\continuedfalse
\else\refstepcounter{table}\fi\fi\fi\fi
\vskip1sp
\noindent
\iflandscapefigortab
\dimen0=\textheight
\advance\dimen0 by-\textwidth 
\hsize=\textheight\else%\hsize=\textwidth
\hskip-.5\dimen0\fi%
%%??
\hbox to\hsize{\hss%
\vbox{\ifdim\wd\savecurrtable>0pt% 
      \iffullwidthtable%\hsize=\textwidth 
\centering\else%
      \hsize=\wd\savecurrtable\fi\fi%
\ifx\catchcaption\empty\else\vskip1sp{\savecaption{\catchcaption}}\fi%
%
\ifdim\wd\savecurrtable>0pt\relax%
\unhbox\savecurrtable%
\ifnobottomtabline\global\nobottomtablinefalse\else
\vskip1sp%??
\thetablelines\fi
\vskip3pt
\thetabnotes%
\gdef\thetabnotes{\relax}
\else\vskip1sp\fi
}\hss}%
%
\ifx\catchlabel\empty\else%
\xdef\@currentlabel{\thetable}%
\savelabel{\catchlabel}\fi%
\gdef\@currentlabel{}%
\gdef\catchlabel{}%
\gdef\catchcaption{}%
%\saveendtable%
\global\wd\savecurrtable=0pt}

\let\thetabnotes\relax
\let\catchcaption\empty
\newbox\savecurrtable
\let\savetabular\tabular
\let\saveendtabular\endtabular
\newskip\abovetabularskip
\newskip\belowtabularskip

\def\tabular{\vskip\abovetabularskip\vbox\bgroup
\parindent=0pt\savetabular}
\def\endtabular{\saveendtabular\egroup
\vskip\belowtabularskip}

\def\xtabular{\global\setbox\savecurrtable\hbox\bgroup%
\tabletextsize\unskip\savetabular}
\def\endxtabular{\saveendtabular
\vskip1sp
\ifnobottomtabline\global\nobottomtablinefalse\else
\vskip1sp%??
\thetablelines\fi
\egroup}

%% Change to default LaTeX table macros to make
%% table contents spread to full width of horizontal rules:

\def\xtable{table}
\def\xplate{plate}

\def\@array[#1]#2{\setbox\@arstrutbox=\hbox{\vrule 
     height\arraystretch \ht\strutbox
     depth\arraystretch \dp\strutbox
     width\z@}\@mkpream{#2}\edef\@preamble{\halign \noexpand\@halignto
\bgroup%
\tabskip\z@\@arstrut\@preamble
\ifx\@captype\xtable\hskip-\tabcolsep\fi%% <==== Changed
\tabskip\z@ \cr}%
\let\@startpbox\@@startpbox \let\@endpbox\@@endpbox%
  \if #1t\vtop \else \if#1b\vbox \else \vcenter \fi\fi%
  \bgroup\let\par\relax%
  \let\@sharp##\let\protect\relax \lineskip\z@\baselineskip\z@\@preamble}

\def\new@tabacol{\edef\@preamble{\@preamble\hskip0pt}}

\def\@tabclassz{\ifcase \@lastchclass\@acolampacol% 
\or \@ampacol \or
   \or \or \@addamp \or \@acolampacol\or \@firstampfalse 
\ifx\@captype\xtable \new@tabacol\else\@tabacol \fi%
\fi%
\edef\@preamble{\@preamble%
  \ifcase \@chnum%
     \hfil\ignorespaces\@sharp\unskip\hfil%
     \or \ignorespaces\@sharp\unskip\hfil%
     \or \hfil\hskip\z@ \ignorespaces\@sharp\unskip\fi}}

%%%%%%%%%%%%%%%%%%
%% iv) Draft macros, including Date and time for Draft line at bottom of page:

\def\draft{\global\jdrafttrue
\def\@oddfoot{\vtop to 0pt{\vskip24pt\large\tt\hsize=\textwidth
\everypar{}
D R A F T\hfill\today, \realtime\hfill D R A F T\global\titlefalse\vss}}
\def\@evenfoot{\@oddfoot}}

\def\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}

\def\fix{\ifcase\oldtime 0\or0\or0\or%
0\or0\or0\or0\or0\or0\or0\fi}
\def\fixtiming{\ifcase\timing 0\or0\or0\or% 
0\or0\or0\or0\or0\or0\or0\fi}
\newcount\timing 
\newcount\hourcount
\newcount\oldtime 

\def\realtime{\timing=\time \oldtime=\time
\ifnum\timing>60 \divide\timing by 60
\hourcount=\the\timing
\multiply\timing by 60
\advance\oldtime by-\timing
\ifnum\hourcount<12 \number\hourcount:\fix\number\oldtime am\fi%
\ifnum\hourcount=12 \number\hourcount:\fix\number\oldtime pm\fi%
\ifnum\hourcount>12 \advance\hourcount by-12
\number\hourcount:\fix\number\oldtime pm\fi
\else12:\fixtiming\number\timing am\fi}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
%% Generic macros to make specific style possible:

%% 1) Running Head and Folio
%% 2) Article title page, including capability for multiple \thanks,
%%    end article.
%% 3) Footnotes, endnotes
%% 4) Acknowledgments
%% 5) Appendices

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%
%% 1) Running Head and Folio

\def\ps@headings{%
\def\@oddfoot{\jfootline}\def\@evenfoot{\jfootline}
\def\@evenhead{\jheadline}%
\def\@oddhead{\jheadline}%
}

\ps@headings 
\pagenumbering{arabic} 
\onecolumn 

%%%%%%
%% 2) Article title page, including capability for multiple \thanks,
%%    end article.

\newcount\totpages
\def\mrule{\raise.75ex\hbox{\vrule width6pt height.5pt}}

\def\lastpage{%
\expandafter\ifx\csname endpage\the\c@chapter\endcsname\relax%
 ?? \else
--%
\csname endpage\the\c@chapter\endcsname\fi}

\def\smcopyright{%
\ooalign {\hfil\raise .17ex\hbox{\footnotesize c}\hfil\crcr%
\raise.17ex\hbox{$\scriptstyle\bigcirc$}}}

\def\yearofpublication#1{\def\theyear{#1}}
\def\monthofpublication#1{\def\themonth{#1}}
\def\volume#1{\def\thevolume{#1}}
\def\issuenumber#1{\def\theissuenumber{#1}}
\def\journame#1{\def\thejourname{\uppercase{#1}}}
\def\articlenumber#1{\def\thearticlenumber{#1}}

\yearofpublication{Year ??}
\volume{Volume ??}
\issuenumber{Number ??}

\def\editor#1{%
\def\theeditor{\vskip\aboveacceptedskip\noindent Recommending editors: #1}} 

%% To be used in specific style part of file, below:

\newif\ifauthorUC
\newif\iftitleUC

\def\authorrunninghead#1{\def\theauthors{\ifauthorUC\uppercase\fi{#1}}}
\def\titlerunninghead#1{\def\thetitle{\iftitleUC\uppercase\fi{#1}}}

\newdimen\belowtitleskip
\newdimen\abovesubtitleskip
\newdimen\belowsubtitleskip
\newdimen\aboveauthorskip
\newdimen\belowauthorskip

%% Making \thanks work multiple times in the title and in 
%% authors line.

\let\savefootnotetext\footnotetext
\long\def\@makefntext#1{#1}

\newcount\thanksnum
\newcount\dothanks
\def\dothankssymbol{\ifcase\thanksnum\or *\or $\dagger$\or
$\ddagger$\or {$\mathchar "278$}\or {$\mathchar "27B$}\or $\|$\or 
$\dagger\dagger$ \or $\ddagger\ddagger$ \else\@ctrerr\fi\relax}

\newcount\thankscounter
\def\thanks#1{\global\advance\thanksnum by1\relax
\global\advance\dothanks by1
\setbox1=\hbox{X}\ifnum\thanksnum=1\relax\else
\raise.25\ht1\fi\vbox{\hbox{\dothankssymbol}\vfill}}

\def\maketemp#1{\global\advance\thankscounter by1\relax
{\footnotesize%
\expandafter\gdef\csname tempthanks\the\thankscounter\endcsname{#1}}}
%% gdef instead of xdef

\newif\iftitle

\def\StartOnNewPage{\clearpage
\ifodd\c@page\else\null\clearpage\fi}

%%%%%%%%%%%%%%%%%%%%
%% Separate \thanks environment for title so we get number instead of
%%   symbol

\newcount\titlethanksnum
\newcount\dotitlethanks
\newcount\titlethankscounter

\long\def\titlethanks{\futurelet\next\lookforast}
\def\lookforast{\ifx\next*\let\go\authorthanks\else%
\let\go\xtitlethanks\fi\go}

\long\def\xtitlethanks#1{\global\advance\c@footnote by1\relax%
\global\advance\titlethanksnum by1\relax%
\global\advance\dotitlethanks by1\relax%
\setbox1=\hbox{X}% 
\unskip\raise.7ex\vbox{%
\hbox{\normalsize\titlethanksfont\dotitlethankssymbol}\vfill}}

\long\def\smalltitlethanks{\futurelet\next\lookforaster}
\def\lookforaster{\ifx\next*\let\go\authorthanks\else
\let\go\xsmalltitlethanks\fi\go}

\long\def\xsmalltitlethanks#1{\global\advance\titlethanksnum by1\relax
\global\advance\dotitlethanks by1 
\raise.3\ht1\hbox{\footnotesize\dotitlethankssymbol}}

\long\def\secondaffil#1{\global\advance\titlethanksnum by1\relax
\global\advance\dotitlethanks by1 
\raise.8\ht1\hbox{\footnotesize,\the\titlethanksnum}}

\def\titlethankssymbol{\titlethanksfont\the\thanksnum}

\long\def\titlemaketemp{\futurelet\next\tempast}
\long\def\tempast{\ifx\next*\let\go\maketemp\else\let\go\xtitlemaketemp\fi\go}

\long\def\xtitlemaketemp#1{\global\advance\titlethankscounter by1\relax
\expandafter\gdef\csname temptitlethanks\the\titlethankscounter\endcsname{#1}}

%% Making \thanks work multiple times in the title and in 
%% authors line.

%% \dothankssymbol may be used later, even if it is not being use now==>
\let\savefootnotetext\footnotetext
\newcount\thanksnum
\newcount\dothanks
\def\dothankssymbol{\ifcase\thanksnum\or*\or$\dagger$\or
$\ddagger$\or $\mathchar "278$\or $\mathchar "27B$\or $\|$\or $\dagger\dagger$
   \or $\ddagger\ddagger$ \else\@ctrerr\fi\relax}

\def\dotitlethankssymbol{\ifcase\titlethanksnum\or*\or$\dagger$\or
$\ddagger$\or $\mathchar "278$\or $\mathchar "27B$\or $\|$\or $\dagger\dagger$
   \or $\ddagger\ddagger$ \else\@ctrerr\fi\relax}

\newcount\thankscounter
\long\def\thanks#1{\global\advance\thanksnum by1\relax
\global\advance\dothanks by1
\setbox1=\hbox{X}\vbox to\ht1{\hbox{\dothankssymbol}\vfill}}

%%% Now used for unnumbered thanks:
\long\def\authorthanks#1#2{\global\advance\thanksnum by1\relax
\global\advance\dothanks by1\relax}

\long\def\maketemp#1#2{\global\advance\thankscounter by1\relax
\expandafter\gdef\csname tempthanks\the\thankscounter\endcsname{#2}}

%%%%%%%%%%%%%%%%%%%%

\newif\ifCenterArticleHead 

\long\def\repeataffil#1{\setbox1=\hbox{X}\raise.8\ht1
\hbox{\footnotesize#1}}

\newdimen\authorwidth
\newdimen\authorbaselineskip

\long\def\author#1{%
\vskip\aboveauthorskip
\vbox{\hsize=\authorwidth
\baselineskip=\authorbaselineskip
\raggedright
\hyphenpenalty=10000
\let\thanks\titlethanks
\frenchspacing\ifjdraft\large\else\authorfont\fi\noindent#1\vrule width0pt depth\belowauthorskip\hss}
%C&G 11/9/01 Removed bold font for draft author names 
%\frenchspacing\ifjdraft\large\bf\else\authorfont\fi\noindent#1\vrule width0pt depth\belowauthorskip\hss}
\setbox1=\hbox{\let\altaffilmark\eatone
\let\\ \relax\let\thanks\titlemaketemp #1
}
\vskip1sp}

\let\authors\author
\newdimen\aboveaffilskip
\newdimen\belowaffilskip
\newdimen\affilwidth

\long\def\affil#1{%
\vskip\aboveaffilskip
{\parindent=0pt
\hyphenpenalty=10000
\raggedright
\hsize=\affilwidth
{\let\thanks\smalltitlethanks\frenchspacing
\ifjdraft\large\else\affilsize\affilfont\fi#1
\vskip1sp}}
\setbox1=\hbox{\let\thanks\titlemaketemp#1}\vskip1sp}

\def\reviewauthors{\typeout{^^J^^J The command 
\string\begin\string{reviewauthors\string}\space should be 
used only^^J for articles in Reviews of Geophysics^^J^^J }}

\long\def\dedication#1{\def\thededication{\uppercase{#1}}}

\def\xdedication{\vskip2pt\hbox to \textwidth{\hss \dedicationfont
\thededication\hss}\vskip-2pt}

\newif\ifabstractname
\newdimen\aboveabstractskip
\newdimen\belowabstractskip
\newdimen\belowabstractnameskip
\newdimen\abstractmargin

\abstractmargin=0pt

\def\xabstract{abstract}
\long\def\abstract#1\end#2{\def\two{#2}\ifx\two\xabstract 
\long\gdef\theabstract{\parindent=\saveparindent\ignorespaces#1}
\def\go{\end{abstract}}\else
\typeout{^^J^^J PLEASE DO NOT USE ANY \string\begin\space \string\end^^J
COMMANDS WITHIN ABSTRACT^^J^^J}#1\end{#2}
\gdef\theabstract{\vskip12pt BADLY FORMED ABSTRACT: PLEASE DO
NOT USE {\tt\string\begin...\string\end} COMMANDS WITHIN
THE ABSTRACT\vskip12pt}\let\go\relax\fi
\go}


%% If ABSTRACT should be printed, set to true
\abstractnamefalse


%%%%%%%%%%%%
%% Begin, End article

\newskip\abovereceivedskip
\newskip\aboverevisedskip
\newskip\aboveacceptedskip
%C&G - addition For newcommand \published
\newskip\abovepublishededskip
\newbox\barticle
\newbox\thanksbox
\newbox\titlethanksbox

\newcount\c@appendnum
\newif\ifdocumentationextraspace

%%%%%%%%%%
%% 3) Footnotes, endnotes

 \newcount\footnum
 \newcount\savefootnum

\def\notes{\global\let\section\savesection \global\appendonfalse
{\ifnum\footnum=0\else
\savefootnum=\footnum
\footnum=0
\section*{Notes}%
\noindent\loop\ifnum\savefootnum>\footnum%
\global\advance\footnum by1\relax%
\csname foot\the\footnum\endcsname\relax%
\expandafter\gdef\csname foot\the\footnum\endcsname{\relax}\relax%
\repeat\global\footnum=0\relax\fi}}


\long\def\endnotes#1{\global\advance\footnum by 1\relax$^{\the\footnum}$%
\long\expandafter\gdef\csname foot\the\footnum\endcsname{%
\vbox{\footnotesize\everypar={\hskip-10pt\everypar={}}
\leftskip=10pt\relax
\noindent\hbox to10pt{\the\footnum.\hfill}{\def\@currentlabel{\the\footnum}%
#1\strut\vskip1sp}}\vskip1pt}}

\def\endnotetext#1{\global\advance\footnum by 1\relax
\long\expandafter\gdef\csname foot\the\footnum\endcsname{%
\vtop{\footnotesize%
\leftskip=12pt\relax\parindent=-12pt
\indent\hbox to12pt{\the\footnum.\hfill}{#1\strut\vskip1sp}}\vskip1pt}}

%%%%%%%%
%% 4) Acknowledgments

\newskip\ackskip

%%%%%%%%
%% 5) Appendices
% \appendix resets counters and redefines section heads
% but doesn't print anything. 
% After typing
% \appendix 
%
% \section{Here is Appendix Title}
% will print 
% Appendix A: Here is Appendix Title
%
% \section*{Appendix}
% will print 
% Appendix 
%
% \section*{Appendix: Here is Appendix Title}
% will print 
% Appendix: Here is Appendix Title 

\newif\ifappendon
\newif\ifupperappend

\def\appendix{%\let\caption\appcaption
\def\@currentlabel{\Alph{section}}
\global\appendontrue\goodbreak
\global\advance\c@appendnum by 1
\refstepcounter{section}%
\global\c@section=0
\global\c@equation=0
\def\thesection{\Alph{section}}
\def\thesubsection{\Alph{section}\@arabic{\c@subsection}}
\def\thesubsubsection{\thesubsection.\@arabic{\c@subsubsection}}
\def\thesubsubsubsection{\thesubsubsection.\@arabic{\c@subsubsection}}
\resetappcounters
}

\def\resetappcounters{
\global\c@equation=0
\global\c@appfigure=0
\global\c@apptable=0
\global\c@appplate=0
}

\let\savefigure\figure
\let\saveendfigure\endfigure

\newif\iftwocolfigortab


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                                                                      %%
%% LaTeX Style for Multiple Columns with Floating Insertions            %%
%%                                                                      %%
%% Copyright 1999--2001, Amy Hendrickson, TeXnology Inc.                %%
%% All rights reserved                                                  %%
%%                                                                      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% 
%%% Double column output routines, 
%%% with single and double column insertions,
%%% to be positioned at page or column top, page or column bottom, page 
%%% or column center, or full page floating insertion.
%%% This code was originally based on Frank Mittlebach's multicol.sty.
%%% The concept of how to balance columns is due to Donald Knuth. The
%%% way to integrate the changed output routine into the standard LaTeX 
%%% output routine is due to Frank. 
%%% The method of making the single and double column insertions and the
%%% changes in the output routines to accomodate these features are mine.
%%% A.H., April 2001
%%


%% Parameters you can set:
\columnsep=12pt
\newdimen\saveparskip
\saveparskip=\parskip

%%
\newdimen\captionskip %% space between caption and figure or table
\captionskip=0pt
%%%

\newdimen\PushOneColTopFig
\newdimen\PushOneColBotFig

\PushOneColTopFig=5.5pt %% push down from top of text page
\PushOneColBotFig=-4.5pt % 

%%
\newdimen\PushOneColTopTab
\newdimen\PushOneColBotTab

\PushOneColTopTab=2.5pt  %% push down from top of text page
\PushOneColBotTab=0pt %% push up from bottom of text page

%%
\newdimen\PushTwoColTopFig
\newdimen\PushTwoColBotFig

\PushTwoColTopFig=2.5pt %% push down from top of text page
\PushTwoColBotFig=1.5pt   %% push up from bottom of text page

%%
\newdimen\PushTwoColTopTab
\newdimen\PushTwoColBotTab

\PushTwoColTopTab=1.5pt %% push down from top of text page
\PushTwoColBotTab=1.5pt %% push up from bottom of text page

%%

\newskip\intextfloatskip
\intextfloatskip=20pt %%  Space between figure or table and text. 
         %% (Need to subtract 4pt to get what you want)

%% Normal and Appendix Figure and Table Numbers

\def\appthefigure{\Alph{section}\the\c@appfigure\theletter}
\def\appthetable{\Alph{section}\the\c@apptable\theletter}
\def\apptheplate{\Alph{section}\the\c@appplate\theletter}

\newcount\c@appfigure
\newcount\c@apptable
\newcount\c@appplate

%% <=== end of parameters you can set

%% do one column at a time so that we can get single col
%% floats for first col.

%%% New version of \@makecol that includes dbltopins and dblbotins,
%%% insertions that span both columns at the top and bottom of text page.

%%% 

\def\new@makecol{\setbox\@outputbox
     \vbox{\boxmaxdepth \maxdepth
\ifdim\ht\dbltopins<1pt\else\unvbox\dbltopins\fi
     \unvbox\@cclv
\ifdim\ht\dblbotins<1pt\else\unvbox\dblbotins\fi%
\ifvoid\footins\else\vskip\skip\footins\footnoterule\unvbox\footins\fi\vss}
%\global\savefigandtabnumber\figandtabnumber
%\global\advance\savefigandtabnumber by 1 %% Because loop stops one short 
                                         %% of the total number of figs
\global\savedblfigandtabnumber\dblfigandtabnumber
   \xdef\@freelist{\@freelist\@midlist}\gdef\@midlist{}\@combinefloats
   \setbox\@outputbox\vbox to\@colht{\boxmaxdepth\maxdepth
   \@texttop\dimen128=\dp\@outputbox\unvbox\@outputbox
   \vskip-\dimen128\@textbottom}%
   \global\maxdepth\@maxdepth}

%% 
\let\@makecol\new@makecol %%

%% Default Latex output routine, to return to after balance columns
%% This should make it possible to capture the output routine of 
%% any version of 2e as well as 2.09. ==>>

\edef\curroutput{\the\output}
\let\latexoutput\curroutput

%% table* and figure*  outside two columns keep default definitions.

\newif\ifnonewpage
\def\nonewpage{\global\nonewpagetrue}

%% Begin twocolumns ==>>
\newdimen\checkforspace
\def\twocolumns{\par \penalty\z@
\checkforspace=\pagegoal
\advance\checkforspace-\pagetotal
\advance\checkforspace-\ht\partialpage
\advance\checkforspace-\dp\partialpage
\advance\checkforspace by -2\ht\dbltopins
\advance\checkforspace by -2\dp\dbltopins
\advance\checkforspace by -2\ht\dblbotins
\advance\checkforspace by -2\dp\dblbotins
\ifdim\checkforspace<36pt\ifnonewpage\else\newpage\fi\fi
\begingroup 
%
\expandafter\gdef\csname plate*\endcsname{\twocolplate}
\expandafter\gdef\csname endplate*\endcsname{\endtwocolfloat}
%
\expandafter\gdef\csname figure*\endcsname{\twocolfig}
\expandafter\gdef\csname endfigure*\endcsname{\endtwocolfloat}
%
\expandafter\gdef\csname table*\endcsname{\twocoltable}
\expandafter\gdef\csname endtable*\endcsname{\endtwocolfloat}
%
\let\figure\onecolfig
\let\plate\onecolplate
\let\table\onecoltable
%
\let\@makecol\new@makecol %%
%%      Confines new def of \@makecol to
%%      two column material, preserves normal topskip after twocolumns is
%%      finished.
%%
\output={\global\setbox\partialpage=\vbox{\unvbox\@cclv}}
\vskip1sp %%
\eject
  \vbadness10001 \hbadness5000
  \tolerance5000
\parskip  \saveparskip %plus .01pt %
\ifjdraft
\baselineskip=28pt\fi
   \pretolerance\m@ne %keeps TeX from trying to make up paragraph
   %  without discretionary hyphens
  \advance\@colroom-\ht\partialpage
  \advance\@colroom-\dp\partialpage
\vsize=\@colroom 
% Changed to \@colroom rather than 2\@colroom. Each column is output
% separately so we can find out if there are top or bottom inserts
% in first column.
%%
  \hsize\textwidth \advance\hsize-\columnsep 
  \divide\hsize by 2 
  \linewidth\hsize %% particular to LaTeX
  \columnwidth=\hsize
%% OR, you can substitute these lines:
%\hsize=\mycolumnwidth
%\linewidth=\hsize
%%
%% Output:
%  Set output to firstcolout, which checks to see if there are inserts
%  then doubles the vsize and send material back into input stream, then
%  sets the next output routine to \makeuppage
%
\output={\firstcolout}
\vskip2sp\ignorespaces}


\def\galleycolumns{\par \penalty\z@
\checkforspace=\pagegoal
\advance\checkforspace-\pagetotal
\advance\checkforspace-\ht\partialpage
\advance\checkforspace-\dp\partialpage
\advance\checkforspace by -2\ht\dbltopins
\advance\checkforspace by -2\dp\dbltopins
\advance\checkforspace by -2\ht\dblbotins
\advance\checkforspace by -2\dp\dblbotins
\ifdim\checkforspace<36pt\newpage\fi
\begingroup 
\expandafter\gdef\csname plate*\endcsname{\twocolplate}
\expandafter\gdef\csname endplate*\endcsname{\endtwocolfloat}
%
\expandafter\gdef\csname figure*\endcsname{\twocolfig}
\expandafter\gdef\csname endfigure*\endcsname{\endtwocolfloat}
%
\expandafter\gdef\csname table*\endcsname{\twocoltable}
\expandafter\gdef\csname endtable*\endcsname{\endtwocolfloat}
%
\let\figure\onecolfig
\let\plate\onecolplate
\let\table\onecoltable
%
\global\firstsectionfalse
\hsize=\mycolumnwidth
\linewidth=\mycolumnwidth
  \vbadness10001 
\hbadness5000
  \tolerance5000
\widowpenalty=0 \clubpenalty=0
\parskip  \saveparskip %plus .0001pt %
\vskip1sp\ignorespaces}

\def\draftcolumns{\par \penalty\z@
\begingroup 
\expandafter\gdef\csname plate*\endcsname{\twocolplate}
\expandafter\gdef\csname endplate*\endcsname{\endtwocolfloat}
%
\expandafter\gdef\csname figure*\endcsname{\twocolfig}
\expandafter\gdef\csname endfigure*\endcsname{\endtwocolfloat}
%
\expandafter\def\csname table*\endcsname{\twocoltable}
\expandafter\def\csname endtable*\endcsname{\endtwocolfloat}
%
\let\figure\onecolfig
\let\plate\onecolplate
\let\table\onecoltable
%
\marginparsep=4pt
\oddsidemargin-.25in
\evensidemargin-.25in
\advance\textwidth-.5in
\hsize=\textwidth
\linewidth=\textwidth
  \vbadness10001 \hbadness5000
  \tolerance5000
\parskip  \saveparskip 
\vskip1sp\ignorespaces}

\newbox\savetopinsert
\newbox\savebotinsert
\newbox\secondsavetopinsert
\newbox\secondsavebotinsert
\newbox\firstcolbox
\newbox\secondcolbox
\newbox\thefirstbox
\newbox\thesecondbox

\newdimen\firstcol
\newdimen\secondcol
\newdimen\checkheight

\newcount\loopnum
\newcount\firstcolsavefignum

\def\firstcolout{%
%% The point of having firstcolout is to find out
%% which figures/tables have been entered in the first column:
\global\firstcolsavefignum=\figandtabnumber
\global\advance\vsize by\@colroom
\topskip=11pt %% ??
       \unvbox\@cclv
       \penalty\outputpenalty
\global\output={\makeuppage}}

%% This is where the floats and text are put together to make page:

\newif\iffirstpage
\newbox\footnotebox

\newdimen\ColUsed
\newdimen\FigSpace
\newbox\testdblbotins

\def\makeuppage{% 
%%
\FigSpace=.9\@colroom %% 
\advance\FigSpace by-\ht\testdblbotins
\advance\FigSpace by-\dp\testdblbotins
\advance\FigSpace by-\ht\dbltopins
\advance\FigSpace by-\dp\dbltopins
%
%% Save top inserts from first column: +++
\global\setbox\savetopinsert=\vbox{%
% write top figures and tables into this box
\redefiningtrue
\global\loopnum=0 \global\checkheight=0pt
\loop\ifnum\loopnum<\firstcolsavefignum 
 %
\expandafter\ifx\csname topfloat\the\loopnum\endcsname\empty
\else
\expandafter\ifx\csname topfloat\the\loopnum\endcsname\relax
\else
\global\advance\checkheight by 
\expandafter\csname totalht\the\loopnum\endcsname\relax
\fi\fi
\ifdim\checkheight>\FigSpace \relax
\global\loopnum=10000 % jump out of loop
%
\else
\csname topfloat\the\loopnum\endcsname
\fi
  %
\global\advance\loopnum by1
\repeat\relax
}
\ColUsed=\FigSpace %%
\advance\ColUsed by-\ht\savetopinsert
\advance\ColUsed by-\dp\savetopinsert
  %%
\global\setbox\savebotinsert=\vbox{%
  %% Write bottom figures and tables into this box
\redefiningtrue
\global\loopnum=0 
\global\checkheight=0pt
\loop\ifnum\loopnum<\firstcolsavefignum 
\expandafter\ifx\csname botfloat\the\loopnum\endcsname\empty
\else
\expandafter\ifx\csname botfloat\the\loopnum\endcsname\relax
\else
\global\advance\checkheight by 
\expandafter\csname totalht\the\loopnum\endcsname\relax
\fi\fi
\ifdim\checkheight>\ColUsed
\global\loopnum=10000 % jump out of loop
\else%
\csname botfloat\the\loopnum\endcsname
\global\expandafter\expandafter\let\csname botfloat\the\loopnum\endcsname\relax
%% how come this reset is here and not in similar places????
\fi
  %
\global\advance\loopnum by1
\repeat
} %
  %
%
\iffirstpage\else
\global\setbox\secondsavetopinsert=\vbox{%
%% Write top figures and tables into this box
%
\global\loopnum=0 \global\checkheight=0pt
\redefiningtrue
\loop\ifnum\loopnum<\figandtabnumber %% ?
%
\expandafter\ifx\csname topfloat\the\loopnum\endcsname\empty
\else
\expandafter\ifx\csname topfloat\the\loopnum\endcsname\relax
\else
\global\advance\checkheight by 
\expandafter\csname totalht\the\loopnum\endcsname\relax
\fi\fi
\ifdim\checkheight>\FigSpace
\global\loopnum=10000 % jump out of loop
%
\else%
\csname topfloat\the\loopnum\endcsname
\fi
%
\global\advance\loopnum by1\repeat
%% one more, because it doesn't stop when number is =, only when it
%% is less than.
\global\advance\loopnum by1
\csname topfloat\the\loopnum\endcsname
}
\fi
%
\ColUsed=\FigSpace %% 
\advance\ColUsed by-\ht\secondsavetopinsert
\advance\ColUsed by-\dp\secondsavetopinsert
%
\iffirstpage\global\firstpagefalse\else
\global\setbox\secondsavebotinsert=\vbox{%
%% Write bottom figures and tables into this box
%
\redefiningtrue
\global\loopnum=0 \global\checkheight=0pt
\loop\ifnum\loopnum<\figandtabnumber
\expandafter\ifx\csname botfloat\the\loopnum\endcsname\empty
\else
\expandafter\ifx\csname botfloat\the\loopnum\endcsname\relax
\else
\global\advance\checkheight by 
\expandafter\csname totalht\the\loopnum\endcsname\relax
\fi\fi
\ifdim\checkheight>\ColUsed
\global\loopnum=10000 % jump out of loop
%
\else%
\csname botfloat\the\loopnum\endcsname
\fi
%
\global\advance\loopnum by1\repeat
%% one more, because it doesn't stop when number is =, only when it
%% is less than.
\global\advance\loopnum by1
\csname botfloat\the\loopnum\endcsname
}
%
\global\dp\secondsavebotinsert=2.5pt
\global\dp\savebotinsert=2.5pt
\fi
%
   \splittopskip=\topskip
   \splitmaxdepth\maxdepth
   \dimen@\@colroom
%% Leave space if there is a two-column wide bottom insertion:
%
\global\setbox\dblbotins=\vbox{% 
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dblbotins %% avoid eradicating this if it has anything in it
%% Write dblspan bottom figures and tables into this box
\redefiningtrue
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\savedblfigandtabnumber %%
\csname dblbotfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dblbotfloat\the\dblloopnum\endcsname
}
   \ifvoid\dblbotins \else
      \advance\dimen@-\ht\dblbotins   
      \advance\dimen@-\dp\dblbotins   
\fi
% 
%% Leave space if there is a two-column wide top insertion:
   \ifvoid\dbltopins\else 
      \advance\dimen@-\ht\dbltopins
      \advance\dimen@-\dp\dbltopins
\fi
%%
%% These changes are made to cut the column size down if we need
%% to fit an insert into the column. This allows the right and
%% left column to have differing amounts of text cut from box 255,
%% called box \@cclv in LaTeX. See \vsplit below.
\firstcol=\dimen@
\ifvoid\savetopinsert\else
\ifdim\ht\savetopinsert>0pt
\advance\firstcol by-\ht\savetopinsert
\advance\firstcol by-\dp\savetopinsert\fi\fi
\ifvoid\savebotinsert\else
\ifdim\ht\savebotinsert>0pt
\advance\firstcol by-\ht\savebotinsert
\advance\firstcol by-\dp\savebotinsert\fi
\fi% 
%%% KLUDGE below 
\advance\firstcol by-3pt %% We need this to avoid        
                         %% error messages about overfull boxes.
%
\secondcol=\dimen@
%%
\ifvoid\secondsavetopinsert\else
\ifdim\ht\secondsavetopinsert>0pt
\advance\secondcol by-\ht\secondsavetopinsert
\advance\secondcol by-\dp\secondsavetopinsert\fi\fi
\ifvoid\secondsavebotinsert\else
\ifdim\ht\secondsavebotinsert>0pt
\advance\secondcol by-\ht\secondsavebotinsert
\advance\secondcol by-\dp\secondsavebotinsert\fi\fi
\ifvoid\footins\else
\ifdim\ht\footins>0pt
\global\setbox\footnotebox=\vbox{\vskip\skip\footins
\footnoterule\unvbox\footins\vskip1sp}
\advance\secondcol by-\ht\footnotebox
\advance\secondcol by-\dp\footnotebox\fi\fi
%%% KLUDGE below
\advance\secondcol by-3pt %% We need this to avoid
                          %% error messages about overfull boxes.
%
%% Cutting the amount of text that will fit from box255:
   \splittopskip=\topskip %% 
   \splitmaxdepth\maxdepth
\setbox\thefirstbox \vsplit\@cclv to\firstcol
\setbox\thesecondbox \vsplit\@cclv to\secondcol
%
%% Making a text box that includes the inserts, column to the left:
\setbox\firstcolbox\vbox to\dimen@{%
\ifvoid\savetopinsert\else\unvbox\savetopinsert\fi%
\box\thefirstbox%
\ifvoid\savebotinsert\else\vfill\unvbox\savebotinsert\fi%
}
% 
%% Making a text box that includes the inserts, column to the right:
\setbox\secondcolbox\vbox to\dimen@{%
\ifvoid\secondsavetopinsert\else\unvbox\secondsavetopinsert\fi%
\box\thesecondbox%%
\ifvoid\secondsavebotinsert\else\vfill\unvbox\secondsavebotinsert\vskip1sp\fi%
\ifvoid\footnotebox\else\unvbox\footnotebox\fi%
}
% Put back any text material that is not used:
  \ifvoid\@cclv \else
       \unvbox\@cclv 
       \penalty\outputpenalty\fi
   \setbox\@cclv\vbox{\page@sofar}%
   \@makecol\@outputpage
   \global\@colroom\@colht
% Changed this so that each column will be output separately, 
% so we have a chance to see if there are any insertions in the first
% column. 
%
%% Do Page Inserts here, so that if there are any two col top inserts
%% They will be numbered after Page Inserts.
%%
\expandafter\ifx\csname pagefloat\the\pageloopnum\endcsname\relax
\else
\expandafter\ifx\csname pagefloat\the\pageloopnum\endcsname\empty
\else
\insertpage\fi\fi
%
%** doing this now gets the numbers right.
\global\setbox\dbltopins=\vbox{%
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dbltopins
%% Write dblspan bottom figures and tables into this box
\redefiningtrue %
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\savedblfigandtabnumber
\csname dbltopfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dbltopfloat\the\dblloopnum\endcsname% 
                                %Save one for next page?
%\vskip24pt
}
%**
%
%% dblfigandtabnumber rather than savedblfigandtabnumber here
\global\setbox\testdblbotins=\vbox{% 
\let\c@figure\bogus
\let\c@table\bogus
\let\c@plate\bogus
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\copy\dblbotins %% avoid eradicating this if it has anything in it
%% Write dblspan bottom figures and tables into this box
\redefiningfalse
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\dblfigandtabnumber %%
\csname dblbotfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dblbotfloat\the\dblloopnum\endcsname
}
%
\ifbalancing
\global\balancingfalse
\global\vsize=2\@colroom
\else
\global\vsize\@colroom
\global\advance\vsize -\ht\dbltopins
\global\advance\vsize -\dp\dbltopins
\global\advance\vsize -\ht\testdblbotins
\global\advance\vsize -\dp\testdblbotins
\global\output={\firstcolout}%
\fi
}


\newcount\pageloopnum

\def\secondoutput{{\makeuppage }}

\newbox\endcolsavetopinsert
\newbox\endcolsavebotinsert
\newbox\testpagesize
\newif\ifbalancing

\newdimen\savelastskip
%%+++
\def\endtwocolumns{% 
%\par\penalty0
\splittopskip=\topskip
\splitmaxdepth\maxdepth
\setboxesandredefine
\ifdim\ht\endcolsavetopinsert>1pt
\unvbox\endcolsavetopinsert%
\fi
\ifdim\ht\endcolsavebotinsert>1pt
\unvbox\endcolsavebotinsert%
\fi
\par\penalty\z@ 
\output={\global\setbox\testpagesize=\vbox{%
\unvbox\@cclv\ifdim\savelastskip>0pt \vskip-\savelastskip\fi}}\eject
 %%
 %% We reset output routine below to \latexoutput
 %% since we had to set multicolout to be the global output routine.
 %%
\dimen0=\ht\testpagesize
\advance\dimen0 by\dp\testpagesize
\unvbox\testpagesize %% 
%% Above needed to see if we have more than one page worth of text.
%%
\advance\dimen0 by \topskip
\ifdim\dimen0>2\@colroom
%\typeout{^^J^^J more than 2 colroom^^J^^J}
 %% More than one page of text:
 %%
\balancingtrue %% need this to avoid turning on firstcolout output routine.
\global\output={\settwocolboxes\makeuppage
\global\output={\setboxesandredefine
\balance@columns\global\output={\latexoutput}}}
\else
\settwocolboxes
\advance\dimen0 by 2\ht\dbltopins
\advance\dimen0 by 2\dp\dbltopins
\ifdim\dimen0>2\@colroom
%\typeout{^^J^^J Second more than 2 colroom^^J^^J}
 %%
\balancingtrue %% need this to avoid turning on firstcolout output routine.
\global\output={\makeuppage
\global\output={\balance@columns\global\output={\latexoutput}}}
\else
%\typeout{^^J^^J NOT more than 2 colroom^^J^^J}
\balancingtrue %% need this to avoid turning on firstcolout output routine.
\global\output={\balance@columns\global\output={\latexoutput}}\fi\fi
\par
\eject
\endgroup
\par\penalty\z@\relax
\hsize=\textwidth
}

%% to get rid of spurious error message when triple col is used:
\def\@checkend#1{\def\reserved@a{#1}\ifx
      \reserved@a\@currenvir \else\iftriplecol
\else\@badend{#1}\fi\fi}

\def\endgalley{\vskip1sp\endgroup\newpage
\vspace*{1in}
\unvbox\figinsert}

\def\enddraft{\vskip1sp\endgroup
\ifdim\ht\figinsert <2pt\else
\newpage
\vspace*{1in}
\unvbox\figinsert\fi}

\def\setboxesandredefine{%
\global\setbox\dbltopins=\vbox{%
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dbltopins
%% Write dblspan bottom figures and tables into this box
\redefiningtrue %
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\dblfigandtabnumber
\csname dbltopfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dbltopfloat\the\dblloopnum\endcsname% 
%                           %Save one for next page?
\vskip3pt%% kludge
\vskip-\intextfloatskip
}
%
\global\setbox\endcolsavetopinsert=\vbox{%
%% dropping figures and tables into this box
\loopnum=0
\redefiningtrue
\loop\ifnum\loopnum<\figandtabnumber
\csname topfloat\the\loopnum\endcsname
\global\advance\loopnum by1\repeat
\csname topfloat\the\loopnum\endcsname%
}
%
\global\setbox\endcolsavebotinsert=\vbox{%
%% drop figures and tables into this box
\global\loopnum=0 
\redefiningtrue
\loop\ifnum\loopnum<\figandtabnumber
\csname botfloat\the\loopnum\endcsname
\global\advance\loopnum by1\repeat
\csname botfloat\the\loopnum\endcsname}
%
\global\setbox\dblbotins=\vbox{% 
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dblbotins %% avoid eradicating this if it has anything in it
% Write dblspan bottom figures and tables into this box
\redefiningtrue
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\dblfigandtabnumber %%
\csname dblbotfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dblbotfloat\the\dblloopnum\endcsname}%
}%% end of setboxes and redefine

\def\settwocolboxes{%
\global\setbox\dbltopins=\vbox{%
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dbltopins
% Write dblspan bottom figures and tables into this box
\redefiningtrue %
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\dblfigandtabnumber
\csname dbltopfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dbltopfloat\the\dblloopnum\endcsname% 
%
%\global\setbox\dblbotins=\vbox
\hsize=\textwidth
\linewidth=\textwidth
\captionwidth=\widecaptionwidth
\unvbox\dblbotins %% avoid eradicating this if it has anything in it
% Write dblspan bottom figures and tables into this box
\redefiningtrue
\global\dblloopnum=0 
\loop\ifnum\dblloopnum<\dblfigandtabnumber %%
\csname dblbotfloat\the\dblloopnum\endcsname
\global\advance\dblloopnum by1\repeat
\csname dblbotfloat\the\dblloopnum\endcsname%
\vskip\intextfloatskip%% new++
}}

\def\setonecolboxesandredefine{%
\global\setbox\endcolsavetopinsert=\vbox{%
%% dropping figures and tables into this box
\loopnum=0
\redefiningtrue
\loop\ifnum\loopnum<\figandtabnumber
\csname topfloat\the\loopnum\endcsname
\expandafter\ifx\csname topfloat\the\loopnum\endcsname\relax\else
\vskip12pt\goodbreak\fi
\global\advance\loopnum by1\repeat
\csname topfloat\the\loopnum\endcsname%
}
%
\global\setbox\endcolsavebotinsert=\vbox{%
%% drop figures and tables into this box
\global\loopnum=0 
\redefiningtrue
\loop\ifnum\loopnum<\figandtabnumber
\csname botfloat\the\loopnum\endcsname
% we don't want a space here because it is at the bottom of a column:
%\expandafter\ifx\csname botfloat\the\loopnum\endcsname\relax\else
%\vskip12pt\goodbreak\fi
\global\advance\loopnum by1\repeat
\csname botfloat\the\loopnum\endcsname%
}
%
}%% end of setonecol boxes and redefine

\newbox\partialpage
\def\process@cols#1#2{\count@#1\relax
     \loop #2%
     \advance\count@\tw@
     \ifnum\count@<4
   \repeat}

%%%   Version for balanced column output.

%% this version to get topskip right on balanced page at end of article.

\def\Bpage@sofar{
\unvbox\partialpage
%% major kludge! but it works ==>>
\null
\vskip-\topskip
\vskip-12pt
%% <<==
   \process@cols\z@{\wd\count@\hsize}%
   \hbox to\textwidth{%
     \process@cols\tw@{\box\count@
       \hss\vrule\@width\columnseprule\hss}%
     \box\z@}}

%%% AH: Version for two column output. %% 
\def\page@sofar{\unvbox\partialpage
\wd\firstcolbox\hsize
\wd\secondcolbox\hsize
\hbox to\textwidth{%
\box\firstcolbox
   \hss\vrule\@width\columnseprule\hss
\box\secondcolbox}%%
}


%% Variant on \@outputpage to use for floating page insert:
\def\insertpage{\begingroup\catcode`\ =10 
     \let\-\@dischyph \let\'\@acci \let\`\@accii \let\=\@acciii
     \if@twoside 
       \ifodd\count\z@ \let\@thehead\@oddhead \let\@thefoot\@oddfoot
            \let\@themargin\oddsidemargin
          \else \let\@thehead\@evenhead
          \let\@thefoot\@evenfoot \let\@themargin\evensidemargin
     \fi\fi
     \shipout
     \vbox{\normalsize \baselineskip\z@ \lineskip\z@ 
           \let\par\@@par %% 
           \vskip \topmargin \moveright\@themargin
           \vbox{\setbox\@tempboxa
                   \vbox to\headheight{\vfil \hbox to\textwidth
                                       {\let\label\@gobble \let\index\@gobble
                                         \@thehead}} %% 
                 \dp\@tempboxa\z@
                 \box\@tempboxa
                 \vskip \headsep
%% change from \@outputpage below
\vbox to\textheight{\vfil 
\hsize=\textwidth
\linewidth=\textwidth
\csname pagefloat\the\pageloopnum \endcsname
}
                 \baselineskip\footskip
                 \hbox to\textwidth{\let\label\@gobble 
                           \let\index\@gobble  %% 
                           \@thefoot}}}\global\@colht\textheight
           \endgroup\stepcounter{page}\let\firstmark\botmark
\global\advance\pageloopnum by1
\expandafter\ifx\csname pagefloat\the\pageloopnum\endcsname\relax\else%
\insertpage\fi%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\balance@columns{% can't throw in figs here because we
                % aren't doing eject, so they will be lost
\ifdim\ht\dbltopins>1pt 
  \advance\@colroom-\ht\dbltopins
  \advance\@colroom-\dp\dbltopins
\advance\@colroom-\baselineskip
\fi
\ifdim\ht\dblbotins>1pt 
 \advance\@colroom-\ht\dblbotins
  \advance\@colroom-\dp\dblbotins
\fi
  \setbox\z@\vbox{\unvbox\@cclv}
\dimen@\ht\z@
%\advance\dimen@\dp\z@
\advance\dimen@ 2\topskip
   \advance\dimen@-2\baselineskip %% ?? was 2\baselineskip, 4 gives better
                                  %topskip
   \divide\dimen@2%
%
{\vbadness\@M 
   \splittopskip=\topskip
   \loop{\process@cols\@ne{\global\setbox\count@
                             \box\voidb@x}}%
     \global\setbox\@ne\copy\z@
   {\process@cols\thr@@{\global\setbox\count@
                     \vsplit\@ne to\dimen@}}%
    \ifdim\ht\@ne >\ht\thr@@
    \global\advance\dimen@\p@
    \repeat}
%
   \dimen@\ht\thr@@
   \process@cols\z@{\@tempcnta\count@
        \advance\@tempcnta\@ne
        \setbox\count@\vtop to\dimen@ %% 
           {\unvbox\@tempcnta}}%
   \global\vsize\@colroom
   \global\advance\vsize\ht\partialpage
   \Bpage@sofar}

\@ifundefined{emergencystretch}
     {\newdimen\emergencystretch}{}

\emergencystretch 1pt

\def\setemergencystretch#1#2{%
   \emergencystretch 4pt
   \multiply\emergencystretch#1}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Figure and table captions in two column text and spanning both
%%% columns.

%%%%%%%%%%%%%%%%%%%%%%%%%
%% Single column inserts: 

\let\savecaption\caption
\let\xsavecaption\savecaption

\def\onecolfig{\ifvmode\else\unskip\fi
\global\captypefigtrue
\global\captypeplatefalse
\@ifnextchar[\lookforposition{\lookforposition[e]}}

\def\onecolplate{\ifvmode\else\unskip\fi
\global\advance\c@plate -1\relax
\global\captypeplatetrue
\global\captypefigfalse
\@ifnextchar[\lookforposition{\lookforposition[e]}}

\def\onecoltable{\ifvmode\else\unskip\vskip1pt\fi\tabletextsize
\global\captypefigfalse
\global\captypeplatefalse
\@ifnextchar[\lookforposition{\lookforposition[e]}}

%% This is used in case we get more than one letter, i.e., 
%% \begin{figure}[htp]. This macro picks up only the first letter.

\def\defone#1#2*{\def\one{#1}}

\newcount\figandtabnumber
\newbox\figandtabbox
\newif\ifcaptypefig
\newif\ifcaptypeplate

\long\def\catchcaption#1{%
\ifcaptypefig%
\expandafter\gdef\csname caption\the\figandtabnumber\endcsname{%
\def\@captype{figure}\savecaption{#1}}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname caption\the\figandtabnumber\endcsname{%
\def\@captype{plate}\savecaption{#1}}%
\else
\expandafter\gdef\csname caption\the\figandtabnumber\endcsname{%
\def\@captype{table}\savecaption{#1}}%
\fi\fi}

\long\def\dblcatchcaption#1{%
\ifcaptypefig%
\expandafter\gdef\csname dblcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{figure}\savecaption{#1}}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname dblcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{plate}\savecaption{#1}}%
\else
\expandafter\gdef\csname dblcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{table}\savecaption{#1}}%
\fi\fi}

\long\def\pcatchcaption#1{%
\ifcaptypefig%
\expandafter\gdef\csname pcaption\the\pagefloatnumber\endcsname{%
\def\@captype{figure}\savecaption{#1}}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname pcaption\the\pagefloatnumber\endcsname{%
\def\@captype{plate}\savecaption{#1}}%
\else
\expandafter\gdef\csname pcaption\the\pagefloatnumber\endcsname{%
\def\@captype{table}\savecaption{#1}}%
\fi\fi}
%%%

\long\def\catchletteredcaption#1#2{%
\ifcaptypefig%
\expandafter\gdef\csname letteredcaption\the\figandtabnumber\endcsname{%
\def\@captype{figure}\letteredcaption{#1}{#2}}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname letteredcaption\the\figandtabnumber\endcsname{%
\def\@captype{plate}\letteredcaption{#1}{#2}}%
\else
\expandafter\gdef\csname letteredcaption\the\figandtabnumber\endcsname{%
\def\@captype{table}\letteredcaption{#1}{#2}}%
\fi\fi}


\long\def\dblcatchletteredcaption#1#2{%
\ifcaptypefig%
\expandafter\gdef\csname dblletteredcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{figure}%
\letteredcaption{#1}{#2}}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname dblletteredcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{plate}%
\letteredcaption{#1}{#2}}%
\else
\expandafter\gdef\csname dblletteredcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{table}%
\letteredcaption{#1}{#2}}%
\fi\fi}

\long\def\pcatchletteredcaption#1#2{%
\ifcaptypefig%
\expandafter\gdef\csname pletteredcaption\the\pagefloatnumber\endcsname{%
\def\@captype{figure}%
\letteredcaption{#1}{#2}}%
\else%
\ifcaptypeplate%
\expandafter\gdef\csname pletteredcaption\the\pagefloatnumber\endcsname{%
\def\@captype{plate}%
\letteredcaption{#1}{#2}}%
\else
\expandafter\gdef\csname pletteredcaption\the\pagefloatnumber\endcsname{%
\def\@captype{table}%
\letteredcaption{#1}{#2}}%
\fi\fi}

%%%
\long\def\catchcontinuedcaption{%
\ifcaptypefig%
\expandafter\gdef\csname continuedcaption\the\figandtabnumber\endcsname{%
\def\@captype{figure}\continuedcaption}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname continuedcaption\the\figandtabnumber\endcsname{%
\def\@captype{plate}\continuedcaption}%
\else
\expandafter\gdef\csname continuedcaption\the\figandtabnumber\endcsname{%
\def\@captype{table}\continuedcaption}%
\fi\fi}

\long\def\dblcatchcontinuedcaption{%
\ifcaptypefig%
\expandafter\gdef\csname dblcontinuedcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{figure}\continuedcaption}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname dblcontinuedcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{plate}\continuedcaption}%
\else
\expandafter\gdef\csname dblcontinuedcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{table}\continuedcaption}%
\fi\fi}

\long\def\pcatchcontinuedcaption{%
\ifcaptypefig%
\expandafter\gdef\csname pcontinuedcaption\the\pagefloatnumber\endcsname{%
\def\@captype{figure}\continuedcaption}%
\else%
\ifcaptypeplate
\expandafter\gdef\csname pcontinuedcaption\the\pagefloatnumber\endcsname{%
\def\@captype{plate}\continuedcaption}%
\else
\expandafter\gdef\csname pcontinuedcaption\the\pagefloatnumber\endcsname{%
\def\@captype{table}\continuedcaption}%
\fi\fi}

%%%
\long\def\catchletteredcontinuedcaption#1{%
\ifcaptypefig%
\expandafter\gdef\csname letteredcontcaption\the\figandtabnumber\endcsname{%
\def\@captype{figure}\letteredcontinuedcaption{#1}}%
\else%
\ifcaptypeplate%
\expandafter\gdef\csname letteredcontcaption\the\figandtabnumber\endcsname{%
\def\@captype{plate}\letteredcontinuedcaption{#1}}%
\else
\expandafter\gdef\csname letteredcontcaption\the\figandtabnumber\endcsname{%
\def\@captype{table}\letteredcontinuedcaption{#1}}%
\fi\fi}


\long\def\dblcatchletteredcontinuedcaption#1{%
\ifcaptypefig%
\expandafter%
\gdef\csname dblletteredcontcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{figure}\letteredcontinuedcaption{#1}}%
\else%
\ifcaptypeplate
\expandafter%
\gdef\csname dblletteredcontcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{plate}\letteredcontinuedcaption{#1}}%
\else
\expandafter%
\gdef\csname dblletteredcontcaption\the\dblfigandtabnumber\endcsname{%
\def\@captype{table}\letteredcontinuedcaption{#1}}%
\fi\fi}

\long\def\pcatchletteredcontinuedcaption#1{%
\ifcaptypefig%
\expandafter%
\gdef\csname pletteredcontcaption\the\pagefloatnumber\endcsname{%
\def\@captype{figure}\letteredcontinuedcaption{#1}}%
\else%
\ifcaptypeplate%
\expandafter%
\gdef\csname pletteredcontcaption\the\pagefloatnumber\endcsname{%
\def\@captype{plate}\letteredcontinuedcaption{#1}}%
\else
\expandafter%
\gdef\csname pletteredcontcaption\the\pagefloatnumber\endcsname{%
\def\@captype{table}\letteredcontinuedcaption{#1}}%
\fi\fi}

%%%


\newcount\pagefloatnumber

\let\savelabel\label
\def\catchlabel#1{%
\expandafter\gdef\csname label\the\figandtabnumber\endcsname{\savelabel{#1}}}

\def\pcatchlabel#1{%
\expandafter\gdef\csname plabel\the\pagefloatnumber\endcsname{\savelabel{#1}}}

\def\dblcatchlabel#1{\expandafter%
\gdef\csname dbllabel\the\dblfigandtabnumber\endcsname{\savelabel{#1}}}

%%  

\def\startonecolfloat{%
\expandafter\newbox\csname figandtabbox\the\figandtabnumber\endcsname%
\global\setbox\csname figandtabbox\the\figandtabnumber\endcsname=
\vbox\bgroup%  
\ifcaptypefig\else
\ifcaptypeplate\def\@captype{plate}
\else
\def\@captype{table}\centering\tabletextsize\fi\fi%
\let\continuedcaption\catchcontinuedcaption
\let\letteredcaption\catchletteredcaption
\let\letteredcontinuedcaption\catchletteredcontinuedcaption
\let\caption\catchcaption
\let\label\catchlabel}

\def\xtopfloat{topfloat}
\def\xbotfloat{botfloat}

\newif\ifredefining

                  
\newbox\sizeoffloat

\def\endonecolfloat{%
%\ifcaptypefig\else%
%\ifnobottomtabline\global\nobottomtablinefalse\vskip-6.5pt\else
%\vskip2pt
%\thetablelines\fi\fi%
%
\egroup%
\DonormalEndcol%
%% make room in column for this insert:
\setbox\sizeoffloat=\vbox{\let\unvbox\copy
\let\c@table\bogus
\let\c@figure\bogus
\redefiningfalse \loopnum=\figandtabnumber
\expandafter\csname \toporbotfloat\the\figandtabnumber\endcsname}%
%%
\expandafter\xdef\csname totalht\the\figandtabnumber\endcsname{%
\the\ht\sizeoffloat}% <=== use before \sizeoffloat is unboxed
\global\advance\figandtabnumber by1\relax}

\newcount\bogus
\def\DonormalEndcol{%
%% top float ==>
\ifx\toporbotfloat\xtopfloat%
%% figure ==>
  \ifcaptypefig%
  \expandafter\gdef\csname topfloat\the\figandtabnumber\endcsname{%
  \vbox{\vskip\PushOneColTopFig%
  \unvbox\csname figandtabbox\the\loopnum\endcsname%
  \vskip\abovefigcaptionskip%
  \csname caption\the\loopnum\endcsname%
  \csname letteredcaption\the\loopnum\endcsname%
  \csname continuedcaption\the\loopnum\endcsname%
  \csname letteredcontcaption\the\loopnum\endcsname}%
  \vskip\intextfloatskip%% 
  \vskip-4pt %% probably an artifact of topskip??
  \ifredefining%
  \csname label\the\loopnum\endcsname%
  \expandafter\gdef\csname topfloat\the\loopnum\endcsname{}\fi}%
\else%
%% plate ==>
  \ifcaptypeplate%
  \expandafter\gdef\csname topfloat\the\figandtabnumber\endcsname{%
  \vbox{\vskip\PushOneColTopFig%
  \unvbox\csname figandtabbox\the\loopnum\endcsname
  \vskip\abovefigcaptionskip
  \csname caption\the\loopnum\endcsname
  \csname letteredcaption\the\loopnum\endcsname
  \csname continuedcaption\the\loopnum\endcsname
  \csname letteredcontcaption\the\loopnum\endcsname}
  \vskip\intextfloatskip %% 
  \vskip-4pt %% probably an artifact of topskip??
  \ifredefining
  \csname label\the\loopnum\endcsname
  \expandafter\gdef\csname topfloat\the\loopnum\endcsname{}\fi}%
%
\else% table ==>
 \expandafter\gdef\csname topfloat\the\figandtabnumber\endcsname{%
 \vbox{\vskip\PushOneColTopTab %%
 \csname caption\the\loopnum\endcsname
  \csname letteredcaption\the\loopnum\endcsname
  \csname continuedcaption\the\loopnum\endcsname
  \csname letteredcontcaption\the\loopnum\endcsname
  \vskip\captionskip
  \unvbox\csname figandtabbox\the\loopnum\endcsname
}\vskip\intextfloatskip %% why don't we need this?
\vskip-10pt
\ifredefining
\csname label\the\loopnum\endcsname
\expandafter\gdef\csname topfloat\the\loopnum\endcsname{}\fi}
\fi\fi%
%
\else% bottom float
%
\ifcaptypefig
\expandafter\gdef\csname botfloat\the\figandtabnumber\endcsname{%
\vskip\intextfloatskip
\vbox{\unvbox\csname figandtabbox\the\loopnum\endcsname
\vskip\abovefigcaptionskip
  \csname caption\the\loopnum\endcsname
  \csname letteredcaption\the\loopnum\endcsname%
  \csname continuedcaption\the\loopnum\endcsname%
  \csname letteredcontcaption\the\loopnum\endcsname%
\vskip\PushOneColBotFig%%
}%
\ifredefining%
%\xdef\@currentlabel{\thefigure}%
\csname label\the\loopnum\endcsname
\expandafter\gdef\csname botfloat\the\loopnum\endcsname{}\fi}%
\else
\ifcaptypeplate
\expandafter\gdef\csname botfloat\the\figandtabnumber\endcsname{%
\vskip\intextfloatskip
\vbox{\unvbox\csname figandtabbox\the\loopnum\endcsname
\vskip\abovefigcaptionskip
  \csname caption\the\loopnum\endcsname
  \csname letteredcaption\the\loopnum\endcsname%
  \csname continuedcaption\the\loopnum\endcsname%
  \csname letteredcontcaption\the\loopnum\endcsname%
\vskip\PushOneColBotFig%%
}%
\ifredefining%
%\xdef\@currentlabel{\thefigure}%
\csname label\the\loopnum\endcsname
\expandafter\gdef\csname botfloat\the\loopnum\endcsname{}\fi}%
  \else% TABLE
\expandafter\gdef\csname botfloat\the\figandtabnumber\endcsname{%
  \vskip\intextfloatskip
\vbox{\csname caption\the\loopnum\endcsname
  \csname letteredcaption\the\loopnum\endcsname
  \csname continuedcaption\the\loopnum\endcsname
  \csname letteredcontcaption\the\loopnum\endcsname%
  \vskip.5\intextfloatskip
  \unvbox\csname figandtabbox\the\loopnum\endcsname%
\vskip\PushOneColBotTab
}% 
\ifredefining%
\csname label\the\loopnum\endcsname
\expandafter\gdef\csname botfloat\the\loopnum\endcsname{}\fi}%
\fi\fi\fi}

%
\def\startpagefloat{%
\expandafter\newbox\csname pagebox\the\pagefloatnumber\endcsname%
\global\setbox\csname pagebox\the\pagefloatnumber\endcsname=\vbox\bgroup%
\hsize=\textwidth%
\linewidth=\textwidth%
\captionwidth=\widecaptionwidth
\let\label\pcatchlabel\ifcaptypefig\else\centering\fi%
\let\caption\pcatchcaption \let\letteredcaption\pcatchletteredcaption
\let\continuedcaption\pcatchcontinuedcaption
\let\letteredcontinuedcaption\pcatchletteredcontinuedcaption
}

\def\endpagefloat{\egroup
\DoNormalPage
\global\advance\pagefloatnumber by1
}

\def\DoNormalPage{\ifcaptypefig
%
\expandafter\gdef\csname pagefloat\the\pagefloatnumber\endcsname{%
\vbox{\hsize=\textwidth
\linewidth=\textwidth
\twocolfigortabtrue
\captionwidth=\widecaptionwidth
\unvbox\csname pagebox\the\pageloopnum\endcsname
  \vskip\captionskip
  \csname pcaption\the\pageloopnum\endcsname
  \csname pletteredcaption\the\pageloopnum\endcsname
  \csname pcontinuedcaption\the\pageloopnum\endcsname
  \csname pletteredcontcaption\the\pageloopnum\endcsname
}  \vskip\intextfloatskip %% 
\xdef\@currentlabel{\thefigure}%
  \csname plabel\the\pageloopnum\endcsname
\expandafter\gdef\csname pagefloat\the\pageloopnum\endcsname{}}%
\else
\ifcaptypeplate
\expandafter\gdef\csname pagefloat\the\pagefloatnumber\endcsname{%
\vbox{\hsize=\textwidth
\linewidth=\textwidth
\twocolfigortabtrue
\captionwidth=\widecaptionwidth
\unvbox\csname pagebox\the\pageloopnum\endcsname
  \vskip\captionskip
  \csname pcaption\the\pageloopnum\endcsname
  \csname pletteredcaption\the\pageloopnum\endcsname
  \csname pcontinuedcaption\the\pageloopnum\endcsname
  \csname pletteredcontcaption\the\pageloopnum\endcsname
}  \vskip\intextfloatskip %% 
\xdef\@currentlabel{\thefigure}%
  \csname plabel\the\pageloopnum\endcsname
\expandafter\gdef\csname pagefloat\the\pageloopnum\endcsname{}}%
\else
\expandafter\gdef\csname pagefloat\the\pagefloatnumber\endcsname{%
\vbox{%%
\hsize=\textwidth
\linewidth=\textwidth
\iflandscapetable
\dimen0=\textheight
\advance\dimen0 by-\textwidth 
\hsize=\textheight
\linewidth=\textheight\fi%
\csname pcaption\the\pageloopnum\endcsname
\csname pletteredcaption\the\pageloopnum\endcsname
\csname pcontinuedcaption\the\pageloopnum\endcsname
\csname pletteredcontcaption\the\pageloopnum\endcsname
  \vskip\intextfloatskip
  \unvbox\csname pagebox\the\pageloopnum\endcsname}
  \vskip\intextfloatskip %% 
\csname plabel\the\pageloopnum\endcsname
\expandafter\gdef\csname pagefloat\the\pageloopnum\endcsname{}}\fi\fi}

\newif\iffirstfighere
\global\firstfigheretrue

\newif\iffirsttabhere
\global\firsttabheretrue

\def\dofigmessage{\iffirstfighere\global\firstfigherefalse
\typeout{^^J
========================================================================
^^J
C A R E F U L !!!!!^^J
^^J
You have used \string\begin{figure}[h]\space !^^J
If there are any figures that appear earlier on the page^^J
they may be numbered incorrectly.^^J
^^J
Please check this and every other page on which you have used ^^J
\string\begin{figure}[h]\space !^^J
^^J
========================================================================
^^J}
\else
\typeout{^^J^^J
C A R E F U L !! \string\begin{figure}[h] used on this page !^^J^^J}
\fi}

\def\dotabmessage{\iffirsttabhere\global\firsttabherefalse
\typeout{^^J
========================================================================
^^J
C A R E F U L !!!!!^^J
^^J
You have used \string\begin{table}[h]\space !^^J
If there are any tables that appear earlier on the page^^J
they may be numbered incorrectly.^^J
^^J
Please check this and every other page on which you have used ^^J
\string\begin{table}[h]\space !^^J
^^J
========================================================================
^^J}
\else
\typeout{^^J^^J
C A R E F U L !! \string\begin{table}[h] used on this page !^^J^^J}
\fi}

\def\lookforposition[#1]{\defone#1*%
\let\go\startonecolfloat
\let\endtable\endonecolfloat
\let\endfigure\endonecolfloat
\let\endplate\endonecolfloat
\ifgalley
\if\one p \def\one{s}
\else
\def\one{i}\fi
%\else\ifappendon\def\one{h}\fi
\fi%
\ifjdraft
\expandafter\ifx\csname setkeys\endcsname\relax\else
\setkeys{Gin}{draft=false}\fi
\if\one p \def\one{s}
\else
\def\one{i}\fi
\else%\ifappendon\def\one{h}\fi
\fi%
\if\one h 
\ifcaptypeplate\else
\ifcaptypefig
\dofigmessage
\else
\dotabmessage
\fi\fi%
\let\go\doonecolfighere
\let\endtable\endonecolfighere
\let\endfigure\endonecolfighere
\let\endplate\endonecolfighere
\else%
\if\one t%
    \gdef\toporbotfloat{topfloat}%
\else%
\if\one b%
    \gdef\toporbotfloat{botfloat}%
\else%
\if\one p%
\let\go\startpagefloat%
\let\endtable\endpagefloat%
\let\endfigure\endpagefloat%
\let\endplate\endpagefloat%
\else%
\if\one e% for either
   \ifdim\pagetotal>.6\pagegoal%
    \gdef\toporbotfloat{botfloat}%
    \else%
    \gdef\toporbotfloat{topfloat}%
    \fi%
\else%
\if\one i% for galley mode
\let\go\dofiginsert%
\let\endtable\endfiginsert%
\let\endfigure\endfiginsert%
\let\endplate\endfiginsert%
\else%
\if\one s% for special galley mode, for [p]
\let\go\dodblfiginsert%
\let\endtable\endspfiginsert%
\let\endfigure\endspfiginsert%
\let\endplate\endspfiginsert%
\else%
    \doerr%
    \ifdim\pagetotal>.5\pagegoal%
    \gdef\toporbotfloat{botfloat}%
    \else%
    \gdef\toporbotfloat{topfloat}%
    \fi%
\fi\fi\fi\fi\fi\fi\fi\go}

\newinsert\figinsert
\skip\figinsert=0pt % space added when figinsert is used
\count\figinsert=0 % insert magnification factor (1 to 1)
\dimen\figinsert=\maxdimen % maximum space for figures

\def\dofiginsert{\setbox0=\vbox\bgroup
\ifcaptypefig\def\@captype{figure}\else
\ifcaptypeplate\def\@captype{plate}\else
\def\@captype{table}\centering\tabletextsize\fi\fi}
\def\endfiginsert{\egroup\insert\figinsert{\vskip24pt\vbox{\unvbox0}\vskip24pt}%
\ignorespaces}

\def\endspfiginsert{\egroup\insert\figinsert{\newpage\vbox to\textheight{\vss
\unvbox0}\newpage}%
\ignorespaces}

\def\dodblfiginsert{\setbox0=\vbox\bgroup
\captionwidth=\widecaptionwidth
\hsize=\textwidth
\linewidth=\textwidth
\ifcaptypefig\def\@captype{figure}\else
\ifcaptypeplate\def\@captype{plate}\else
\def\@captype{table}\centering\fi\fi
}

\def\enddblfiginsert{\egroup\insert\figinsert{\vskip24pt\vbox{\unvbox0}\vskip24pt}}

\long\def\saveherecaption#1{\gdef\thesavedcaption{\savecaption{#1}}}

\long\def\saveherecontinuedcaption{\gdef\thesavedcaption{\continuedcaption}}

\long\def\savehereletteredcaption#1#2{\gdef\thesavedcaption{%
\gdef\theletter{#1}\savecaption{#2}}}

\long\def\savehereletteredcontinuedcaption#1{\gdef\thesavedcaption{%
\letteredcontinuedcaption{#1}}}

\long\def\saveherelabel#1{\gdef\thesavedlabel{#1}}
\saveherelabel{\relax}

\def\thesavedcaption{\relax}

\newbox\herebox
%% either figure [h] or table [h] 
\newif\ifhere
\def\doonecolfighere{\vskip1sp\bgroup%
\heretrue%
\ifcaptypefig\def\@captype{figure}\else%
\ifcaptypeplate\def\@captype{plate}\else%
\def\@captype{table}\centering\fi\fi%
\setbox\herebox\vbox\bgroup%
\let\label\saveherelabel%
\let\caption\saveherecaption%
\let\letteredcaption\savehereletteredcaption%
\let\continuedcaption\saveherecontinuedcaption%
\let\letteredcontinuedcaption\savehereletteredcontinuedcaption%
}

\def\xrelax{\relax}

\def\endonecolfighere{%
\egroup%
\vskip\intextfloatskip%
\vtop{\vskip-5.5pt
%\ifappendon
%\let\thefigure\appthefigure
%\let\thetable\appthetable
%\let\theplate\apptheplate
%\let\savecaption\appcaption
%\fi
%
\ifx\thesavedcaption\xrelax
  \unvbox\herebox
\else
  \ifcaptypefig
  \unvbox\herebox
  \thesavedcaption
\else
  \ifcaptypeplate
  \unvbox\herebox
  \thesavedcaption
%
  \else
%
  \thesavedcaption
  \unvbox\herebox
  \fi
\fi\fi
%
\gdef\thesavedcaption{\relax}
\ifx\thesavedlabel\xrelax\else%
   \ifcaptypefig\else\edef\@currentlabel{\thetable}\fi
  \savelabel{\thesavedlabel}
  \gdef\thesavedlabel{\relax}
\fi
\gdef\theletter{\relax}
}\vskip1sp
\egroup
\vskip\intextfloatskip
}

\newbox\endfigbox

\def\doerr{%
\typeout{\space\space\space\space\space\space\space\space\space}
\typeout{Sorry! 
Your choices following \string\figure\space or \string\table\space^^J%
are only [h] for `here', [t] for `top', [b] for `bottom', or [p] 
for `page'.^^J%
I have ignored the [\one] and inserted the figure or table at this
point^^J%
on the page. See documentation if you need more help.}
\typeout{\space\space\space\space\space\space\space\space\space}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Inserts spanning both columns:

\newbox\spanbox

\def\centertabular{\bgroup\centering\savetabular}
\def\endcentertabular{\saveendtabular\vskip1pt\egroup}

%%% 

\newbox\dbltopins
\newbox\dblbotins

\newskip\dblbotskip
\dblbotskip=12pt plus 3pt

\def\twocolfig{\global\captypefigtrue
\global\captypeplatefalse
\def\@captype{figure}
\@ifnextchar[\twolookforposition{\twolookforposition[t]}}%

\def\twocolplate{\global\captypeplatetrue
\global\captypefigfalse
\def\@captype{plate}
\@ifnextchar[\twolookforposition{\twolookforposition[t]}}%
                                                        
\def\twocoltable{\vskip1pt\tabletextsize
\global\captypefigfalse
\global\captypeplatefalse
\def\@captype{table}
\@ifnextchar[\twolookforposition{\twolookforposition[t]}}% 

\newcount\dblfigandtabnumber
\dblfigandtabnumber=1
\newbox\dblfigandtabbox

\def\starttwocolfloat{\ifvmode\else\unskip\fi\expandafter%
  \ifx\csname dblfigandtabbox\the\dblfigandtabnumber\endcsname\relax%
  \expandafter%
  \newbox\csname dblfigandtabbox\the\dblfigandtabnumber\endcsname%
  \fi%
\global\setbox\csname dblfigandtabbox\the\dblfigandtabnumber\endcsname=
\vbox\bgroup\let\label\dblcatchlabel%
%
  \ifcaptypefig\def\@captype{figure}\else%
    \ifcaptypeplate\def\@captype{plate}\else%
    \def\@captype{table}\centering\tabletextsize%
    \fi%
  \fi%
\captionwidth=\widecaptionwidth
\hsize=\textwidth
\linewidth=\textwidth\relax
%
\let\caption\dblcatchcaption
\let\letteredcaption\dblcatchletteredcaption
\let\continuedcaption\dblcatchcontinuedcaption
\let\letteredcontinuedcaption\dblcatchletteredcontinuedcaption
\let\label\dblcatchlabel
}

\newcount\dblloopnum
\newcount\savedblfigandtabnumber
%\newcount\savefigandtabnumber

\def\xdbltopfloat{dbltopfloat}
\def\xdblbotfloat{dblbotfloat}

\def\endtwocolfloat{%
%\ifcaptypefig\else%
%\ifcaptypeplate\else%
%\ifnobottomtabline\global\nobottomtablinefalse\vskip-6.5pt\else%
%\vskip2pt
%\thetablelines\fi\fi\fi%
%
\egroup%
\ifx\dbltoporbotfloat\xdbltopfloat%
%%++
\ifcaptypefig%
\expandafter\gdef\csname dbltopfloat\the\dblfigandtabnumber\endcsname{%
\vbox{\vskip\PushTwoColTopFig%
\copy\csname dblfigandtabbox\the\dblloopnum\endcsname%
  \vskip\captionskip%
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
\ifredefining%
\xdef\@currentlabel{\thefigure}%
\csname dbllabel\the\dblloopnum\endcsname\fi}%
  \vskip\intextfloatskip %% 
  \vskip-5pt% because there is a space above the top of text, from topskip?
\ifredefining%
\expandafter\gdef\csname dbltopfloat\the\dblloopnum\endcsname{}\fi}%
\else\ifcaptypeplate%
\expandafter\gdef\csname dbltopfloat\the\dblfigandtabnumber\endcsname{%
\vbox{\vskip\PushTwoColTopFig%
\copy\csname dblfigandtabbox\the\dblloopnum\endcsname%
  \vskip\captionskip%
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
\ifredefining%
\xdef\@currentlabel{\theplate}%
\csname dbllabel\the\dblloopnum\endcsname\fi}%
  \vskip\intextfloatskip %% 
  \vskip-5pt% because there is a space above the top of text, from topskip?
\ifredefining%
\expandafter\gdef\csname dbltopfloat\the\dblloopnum\endcsname{}\fi}%
\else% table
\expandafter\gdef\csname dbltopfloat\the\dblfigandtabnumber\endcsname{%
\vbox{\vskip\PushTwoColTopTab%
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
  \vskip\captionskip%
  \copy\csname dblfigandtabbox\the\dblloopnum\endcsname}%
  \vskip\intextfloatskip %% 
  \vskip-5pt% because there is a space above the top of text, from topskip?
\ifredefining%
\csname dbllabel\the\dblloopnum\endcsname%
\expandafter\gdef\csname dbltopfloat\the\dblloopnum\endcsname{}\fi}%
%
\fi\fi%
%
\else% bottom float
%
\ifcaptypefig%
\expandafter\gdef\csname dblbotfloat\the\dblfigandtabnumber\endcsname{%
  \vskip\intextfloatskip%
\vbox{\copy\csname dblfigandtabbox\the\dblloopnum\endcsname%
  \vskip\captionskip%
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
\ifredefining%
\csname dbllabel\the\dblloopnum\endcsname\fi%
\vskip\PushTwoColBotFig}%???
 \ifredefining%
\expandafter\gdef\csname dblbotfloat\the\dblloopnum\endcsname{}\fi}%
\else%
%%
\ifcaptypeplate%
\expandafter\gdef\csname dblbotfloat\the\dblfigandtabnumber\endcsname{%
  \vskip\intextfloatskip%
\vbox{\copy\csname dblfigandtabbox\the\dblloopnum\endcsname%
  \vskip\captionskip%
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
\ifredefining%
\csname dbllabel\the\dblloopnum\endcsname\fi%
\vskip\PushTwoColBotFig}%
 \ifredefining%
\expandafter\gdef\csname dblbotfloat\the\dblloopnum\endcsname{}\fi
}%
\else% table
\expandafter\gdef\csname dblbotfloat\the\dblfigandtabnumber\endcsname{%
  \vskip\intextfloatskip
\vbox{%  
  \csname dblcaption\the\dblloopnum\endcsname%
  \csname dblletteredcaption\the\dblloopnum\endcsname%
  \csname dblcontinuedcaption\the\dblloopnum\endcsname%
  \csname dblletteredcontcaption\the\dblloopnum\endcsname%
  \vskip\captionskip
\ifredefining%
\csname dbllabel\the\dblloopnum\endcsname\fi%
  \copy\csname dblfigandtabbox\the\dblloopnum\endcsname%
\vskip\PushTwoColBotTab}%
\ifredefining%
\expandafter\gdef\csname dblbotfloat\the\dblloopnum\endcsname{}\fi}%
%
\fi\fi\fi%
%%
\global\advance\dblfigandtabnumber by1 \relax}

\newbox\dblspanherebox

\def\dodblfigurehere{\global\setbox\dblspanherebox=\vbox\bgroup
\let\label\saveherelabel
\ifcaptypefig\def\@captype{figure}\else
\ifcaptypeplate\def\@captype{plate}\else
\def\@captype{table}\centering\fi\fi
\vskip\intextfloatskip
\captionwidth=\widecaptionwidth
\hsize=\textwidth
\linewidth=\textwidth
\let\label\saveherelabel
\let\caption\saveherecaption
\let\letteredcaption\savehereletteredcaption
\let\continuedcaption\saveherecontinuedcaption
\let\letteredcontinuedcaption\savehereletteredcontinuedcaption}

\def\enddodblfigurehere{\vskip\intextfloatskip\egroup%
\aftergroup\endcolsneatly}


%%
\def\endcolsneatly{\ifdim\lastskip=2sp
\vskip-9.5pt\null\fi
\endtwocolumns
\vbox{\vskip\intextfloatskip
\captionwidth=\widecaptionwidth
\ifcaptypefig\def\@captype{figure}\else
\ifcaptypeplate\def\@captype{plate}\else
\def\@captype{table}\centering\fi\fi
%\ifappendon
%\let\thefigure\appthefigure
%\let\thetable\appthetable
%\let\theplate\apptheplate
%\let\savecaption\appcaption
%\fi
%
\ifx\thesavedcaption\xrelax
\unvbox\dblspanherebox
\vskip\intextfloatskip
\else
  \ifcaptypefig
\unvbox\dblspanherebox
  \thesavedcaption
\vskip\intextfloatskip
%
  \else
\ifcaptypeplate
\unvbox\dblspanherebox
  \thesavedcaption
\vskip\intextfloatskip
%
\else
\vskip\intextfloatskip
  \thesavedcaption
\unvbox\dblspanherebox
\vskip\intextfloatskip
  \fi
\fi\fi
%
\gdef\thesavedcaption{\relax}
\ifx\thesavedlabel\xrelax\else\savelabel{\thesavedlabel}
\gdef\thesavedlabel{\relax}\fi
\gdef\theletter{\relax}
\vskip\intextfloatskip}
\twocolumns\null
\vskip2sp}

\def\twolookforposition[#1]{\defone#1*%
\let\go\starttwocolfloat%
\ifgalley%
  \if\one p \def\one{s}%
  \else%
  \def\one{i}%
  \fi%
\fi%
\ifjdraft%
\expandafter\ifx\csname setkeys\endcsname\relax\else
\setkeys{Gin}{draft=false}\fi
  \if\one p \def\one{s}%
  \else%
  \def\one{i}%
  \fi%
\fi%
%\ifappendon\def\one{h}\fi%
%%
\if\one h% 
  \ifcaptypeplate%
  \else%
    \ifcaptypefig%
    \dofigmessage%
    \else%
    \dotabmessage%
    \fi%
  \fi%
    \ifgalley%
     \gdef\dbltoporbotfloat{dbltopfloat}%
     \else% not galley ==> 
     \let\go\dodblfigurehere%
    \expandafter\gdef\csname endfigure*\endcsname{\enddodblfigurehere}%
    \expandafter\gdef\csname endtable*\endcsname{\enddodblfigurehere}%
    \expandafter\gdef\csname endplate*\endcsname{\enddodblfigurehere}%
    \fi% end ifgalley
\else%
   \if\one t%
   \gdef\dbltoporbotfloat{dbltopfloat}%
   \else%
      \if\one b%
      \gdef\dbltoporbotfloat{dblbotfloat}%
      \else%
         \if\one p%
         \let\go\startpagefloat%
    \expandafter\gdef\csname endfigure*\endcsname{\endpagefloat}
    \expandafter\gdef\csname endtable*\endcsname{\endpagefloat}
    \expandafter\gdef\csname endplate*\endcsname{\endpagefloat}
         \else%
            \if\one i% for galley mode
            \let\go\dodblfiginsert%
    \expandafter\gdef\csname endfigure*\endcsname{\enddblfiginsert}
    \expandafter\gdef\csname endtable*\endcsname{\enddblfiginsert}
    \expandafter\gdef\csname endplate*\endcsname{\enddblfiginsert}
            \else%
               \if\one s% for special galley mode, for [p]
               \let\go\dodblfiginsert%
    \expandafter\gdef\csname endfigure*\endcsname{\endspfiginsert}%
    \expandafter\gdef\csname endtable*\endcsname{\endspfiginsert}
    \expandafter\gdef\csname endplate*\endcsname{\endspfiginsert}
               \else%
\doerr%
              \fi%
           \fi%
        \fi%
     \fi%
   \fi%
\fi\go}%

\let\saveenddocument\enddocument

\def\enddocument{%
\ifdim\ht\dbltopins>0pt\vbox{\unvbox\dbltopins}\fi
\ifdim\ht\dblbotins>0pt\vbox{\unvbox\dblbotins}\fi
\ifnum\pagefloatnumber>\pageloopnum
\newpage
\insertpage{\hsize=\textwidth
\linewidth=\textwidth
\csname pagefloat\the\pageloopnum \endcsname}\fi%
\saveenddocument}

\splittopskip=\topskip

\def~{\penalty\@M{ }} 

\def\mathleftline{\vskip-\parskip
\hbox to\textwidth{\hrulefill\hskip.5\textwidth}\vskip-\abovedisplayskip}

\def\mathrightline{\hbox to\textwidth{\hskip.5\textwidth\hrulefill}\vskip18pt}

\let\topline\mathleftline
\let\botline\mathrightline

%% End Two Column Macros
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\let\dofigmessage\relax
\let\dotabmessage\relax

%% Options:
%% To bring in options: 
%% \documentclass[draft]{agu2001}
%% \documentclass[galley]{agu2001}

\newif\ifcallouts
\DeclareOption{galley}{\global\galleytrue\global\calloutstrue}

\newif\ifdraft
\DeclareOption{draft}{\global\jdrafttrue \global\draftfalse
\oddsidemargin=-1in
\evensidemargin=-1in
\textwidth=5in
\hsize=\textwidth
\draft\global\calloutstrue}

%%%% Journal Styles
% jgrga JOURNAL OF GEOPHYSICAL RESEARCH
% gbc   GLOBAL BIOCHEMICAL CYCLES
% grl   GEOPHYSICAL RESEARCH LETTERS
% pal   PALEOCEANOGRAPHY
% ras   RADIO SCIENCE
% rog   REVIEWS OF GEOPHYSICS
% tec   TECTONICS
% sw    SPACE WEATHER
%% default style
% jgrga JOURNAL OF GEOPHYSICAL RESEARCH
\newif\ifjgrga
\DeclareOption{jgrga}{\global\jgrgatrue}
\DeclareOption{jgr}{\global\jgrgatrue}

% SW SPACE WEATHER
\newif\ifsw
\DeclareOption{sw}{\global\swtrue}

% gbc   GLOBAL BIOCHEMICAL CYCLES
\newif\ifgbc
\DeclareOption{gbc}{\global\gbctrue}

% tec   TECTONICS
\newif\iftec
\DeclareOption{tec}{\global\tectrue}

% wrr   WATER RESOURCE RESEARCH
\newif\ifwrr
\DeclareOption{wrr}{\global\wrrtrue}

% grl   GEOPHYSICAL RESEARCH LETTERS
\newif\ifgrl
\DeclareOption{grl}{\global\grltrue}

% pal   PALEOCEANOGRAPHY
\newif\ifpal
\DeclareOption{pal}{\global\paltrue}

% ras   RADIO SCIENCE
\newif\ifras
\DeclareOption{ras}{\global\rastrue}

% rog   REVIEWS OF GEOPHYSICS
\newif\ifrog
\DeclareOption{rog}{\global\rogtrue}


\ifll \let\dooptions\ProcessOptions
\else
\let\dooptions\@options
\fi
\dooptions




%%% <== end options

% prevent error messages for embedded lists:
\let\@noitemerr\relax



%%% Commands to accomodate older AGU syntax
\let\lefthead\authorrunninghead
\let\righthead\titlerunninghead

\def\paperid#1{\def\thepaperidnumber{#1}}

\paperid{}

\def\journalid#1{\def\jourdate{\ifras\else\uppercase{\fi#1\ifras\else}\fi}}
\def\articleid#1#2{\def\thevolume{#1}\def\thenumber{#2}}


\def\specialccc#1{\thecccline{#1}}

\def\altaffilmark#1{\unskip\setbox1=\hbox{X}%
\vbox to1.4\ht1{\hbox{\footnotesize #1}\vfill}}

%% default
\journalid{}{}
\articleid{}{}

\@mparswitchfalse
%C&G For draft Option, moved callouts back onto page 
\def\callout#1{#1\ifcallouts\marginpar{\ifgalley\hskip-\mycolumnwidth\fi%
\ifjdraft\hskip-12pt\fi%
\fbox{\savenormalsize\bf #1}}\fi}

\def\tableline{\noalign{\vskip2pt
\hrule \@height \arrayrulewidth 
\vskip2pt}}

%% Get commas into page number over 1000:
\newcount\bigpagenum
\newcount\littlepagenum
\newcount\wholepagenum

\def\PutCommaIntoNumber#1{%
\bigpagenum=#1
\ifnum\bigpagenum>9999
\wholepagenum=\bigpagenum
\divide\bigpagenum by 1000
\littlepagenum=\bigpagenum
\multiply \littlepagenum by 1000
\advance\wholepagenum by -\littlepagenum
\littlepagenum=\wholepagenum
\number\bigpagenum,\ifnum\littlepagenum<10 00\else
\ifnum\littlepagenum <100 0\fi\fi\number\littlepagenum\relax\else \the\bigpagenum\fi}

\def\received#1{\gdef\@recvdate{#1}} \received{}
\def\revised#1{\gdef\@revisedate{#1}} \revised{}
\def\accepted#1{\gdef\@accptdate{#1}} \accepted{}
%C&G 8/1/2001 newcommand \published
\def\published#1{\gdef\@pubdate{#1}} \published{}

\def\cpright#1#2{\@nameuse{cpr@#1} \gdef\cpr@year{#2}
\typeout{`#1' copyright \cpr@year.}}

\newcount\@cprtype \@cprtype=\@ne  
\def\cpr@AGU{\@cprtype=1}
\def\cpr@PD{\@cprtype=2}
\def\cpr@Crown{\@cprtype=3}
\def\cpr@none{\@cprtype=4}
\def\cpr@year{\number\year}

\def\cpr@holder{American Geophysical Union}

\def\@rcvaccrule{\vrule\@width1.75in\@height0.5pt\@depth\z@}

\def\slugcomment#1{\gdef\slug@comment{#1}} \slugcomment{}
\newdimen\@slugcmmntwidth \@slugcmmntwidth \textwidth

\long\def\@makeslugcmmnt{\ifx\slug@comment\@empty\relax\else
\vskip3pt
\noindent
\slug@comment
\vskip3pt\fi}

%% for now:
\let\@makeslugcmmnt\relax

\def\@slug{\ifgalley\hsize=\mycolumnwidth\fi
\@makeslugcmmnt
\vskip11pt
\noindent
\ifcase\@cprtype
   \relax
\or
   Copyright \cpr@year\space by the \cpr@holder.
\or
   This paper is not subject to U.S. copyright.
   Published in \cpr@year\space by the \cpr@holder.
\or
   Published in \cpr@year\space by the \cpr@holder.
\or
   No copyright is claimed for this article.
\fi
%\vskip 11\p@\noindent Paper number \thepaperidnumber.
\par\noindent
\thecccline\vrule depth2pt width0pt\relax}

\def\title#1{\gdef\theprinttitle{#1}\printtitle}

% Alternate affiliations appearing 
% at the end of the article:

\def\altaffiltext#1#2{%
\global\advance\totalaffils by 1
\expandafter\xdef\csname altaffil#1\endcsname{\noindent%
\hskip\saveparindent$^{#1}${#2}}}

\def\doaltaffils{{\parindent=0pt
\hsize=\mycolumnwidth
\loop\ifnum\affilnum<\totalaffils
\csname altaffil\the\affilnum\endcsname
\vskip1pt
\expandafter\ifx\csname altaffil\the\affilnum\endcsname\relax
\global\advance\totalaffils by 1 \fi % in case author doesn't start
                                     %  with \altaffiltext{1}{}
\global\advance\affilnum by 1
\repeat
\expandafter\ifx\csname altaffil\the\affilnum\endcsname\relax
\else
\csname altaffil\the\affilnum\endcsname\fi
\global\affilnum=0
\global\totalaffils=0
\vskip1sp
}}
\let\doaffils\doaltaffils

\newcount\affilnum
\affilnum=0
\newcount\totalaffils 

%%% to keep too big of a skip after endbibliogrphy

\def\spendlist{\global\advance\@listdepth\m@ne}

%%% Possibly useful abbreviations
\let\jnl@style=\it
\def\ref@jnl#1{{\jnl@style#1}}
\def\aj{\ref@jnl{Astron.\ J., }}  
\def\apj{\ref@jnl{Astrophys.\ J., }} 
\def\apjl{\ref@jnl{Astrophys.\ J., }}
\def\apjs{\ref@jnl{Astrophys.\ J.\ (Supp.), }}
\def\aap{\ref@jnl{Astron.\ Astrophys., }}  
\def\bams{\ref@jnl{Bull.\ Am.\ Meteorol.\ Soc., }}
\def\bssa{\ref@jnl{Bull.\ Seismol.\ Soc.\ Am., }}
\def\eos{\ref@jnl{Eos Trans.\ AGU, }}
\def\epsl{\ref@jnl{Earth Planet.\ Sci.\ Lett., }}  
\def\gca{\ref@jnl{Geochim.\ Cosmochim.\ Acta, }}
\def\gjras{\ref@jnl{Geophys.\ J.\ R.\ Astron.\ Soc., }}
\def\grl{\ref@jnl{Geophys.\ Res.\ Lett., }}  
\def\gsab{\ref@jnl{Geol.\ Soc.\ Am.\ Bull., }}  
\def\jatp{\ref@jnl{J.\ Atmos.\ Terr.\ Phys., }} 
\def\jgr{\ref@jnl{J.\ Geophys.\ Res., }}
\def\jpo{\ref@jnl{J.\ Phys.\ Oceanogr., }} 
\def\mnras{\ref@jnl{Mon.\ Not.\ R.\ Astron.\ Soc., }}
\def\mwr{\ref@jnl{Mon.\ Weather Rev., }}
\def\pepi{\ref@jnl{Phys.\ Earth Planet.\ Inter., }}  
\def\pra{\ref@jnl{Phys.\ Rev.\ A, }}
\def\prl{\ref@jnl{Phys.\ Rev.\ Lett., }}
\def\pasp{\ref@jnl{Publ.\ A.\ S.\ P., }}
\def\qjrms{\ref@jnl{Q.\ J.\ R.\ Meteorol.\ Soc., }}  
\def\rg{\ref@jnl{Rev.\ Geophys., }}  
\def\rs{\ref@jnl{Radio Sci., }}
\def\usgsof{\ref@jnl{U.S.\ Geol.\ Surv.\ Open File Rep., }}
\def\usgspp{\ref@jnl{U.S.\ Geol.\ Surv.\ Prof.\ Pap., }}
\let\astap=\aap
\let\apjlett=\apjl
\let\apjsupp=\apjs

%%%%%%%%%%%%%%%

\let\savedeg\deg
\def\savecirc{$^\circ$}
\def\deg{\ifmmode\savedeg\else\hbox{\unboldmath\savecirc}\fi}

%%%
\def\@citex[#1]#2{%
  \let\@citea\@empty
  \@cite{\@for\@citeb:=#2\do
    {\@citea\def\@citea{,\penalty\@m\ }%
     \edef\@citeb{\expandafter\@firstofone\@citeb}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb}{\mbox{\reset@font\bfseries ?}%
       \G@refundefinedtrue
       \@latex@warning
         {Citation `\@citeb' on page \thepage \space undefined}}%
       {%\hbox
{\csname b@\@citeb\endcsname}}}}{#1}}

%% to make things work in old files:???
\newcount\figcount
\def\figurenum#1{\figcount=#1 \global\advance\figcount by -1
\setcounter{figure}{\figcount}}

%%% planotable
%%  Declare Obsolete:
\long\def\planotable#1\end{\message{^^J^^J
Sorry!^^J
\string\begin{planotable}...\string\end{planotable} are obsolete commands.^^J
^^J
Please make this table with \string\begin{tabular}...\string\end{tabular}
^^J
Information on making this change is found in the AGU2001 documentation
^^J^^J^^J
}
\vskip24pt
\hrule
\vskip12pt
\noindent
!! Planotable is an obsolete command. Please replace with\newline
{\tt\string\begin\string{table\string}\newline
\string\caption\string{\string}\newline
\string\begin\string{tabular\string}...\newline
\string\end\string{tabular\string}\newline
\string\end\string{table\string}}\newline
Information on how to do this is found in the AGU2001 documentation.
\vskip12pt
\hrule
\end}

\def\endplanotable{}

\newcount\saveequation
\newcounter{currlett}
\newenvironment{mathletters}{\refstepcounter{equation}%
\mathletter{x}
\c@currlett=0
\global\saveequation=\c@equation
\def\theequation{\global\advance\c@currlett by1
\the\saveequation\alph{currlett}}%
\let\savetheequation\theequation}%
{\global\c@equation\saveequation\relax}

%% invented june 00
\newdimen\notationwidth
\def\setnotationwidth#1{\setbox0=\hbox{#1\ \ }
\global\notationwidth=\wd0\relax}
\newskip\betweennotationskip
\betweennotationskip=1sp plus 1pt


\newdimen\WidestEntry

\long\def\notation#1\end{
\def\begin{\typeout{^^J^^J!!!^^J^^J Notation:^^J
Please do not put any
\string\begin\space or \string\end\space commands within
the notation environment^^J^^J!!!^^J^^J}}
\section*{Notation}
\setbox0=\vbox{\let\\ \cr
\halign{\setbox0=\hbox{##\ \ }%
\ifdim\wd0>\WidestEntry \global\WidestEntry=\wd0\fi&##\cr
#1\crcr}}
%%
\everycr={\noalign{\vskip1sp}}
\dimen0=\mycolumnwidth
\advance\dimen0 by-\WidestEntry
\let\\ \cr
\vskip1sp\halign{\hbox to\ifdim\notationwidth>0pt \notationwidth\else
\WidestEntry\fi{\hfill##\ \ }&\vtop{\hsize=\dimen0
\parindent=0pt##\vrule width0pt depth 5pt}
\cr#1\crcr}\end}

\def\endnotation{\global\WidestEntry=0pt
\vskip6pt\@ignoretrue}

%% Table Footnotes

\def\tablenotemark#1{\rlap{$^{\rm #1}$}}

\long\def\tablenotetext#1#2{\vtop{\vskip2pt
\uncentering\noindent\setbox0=\hbox{#1}%
\hskip\saveparindent\ifdim\wd0>1pt
$^{\rm #1}$ \fi{\tablenotefont\ignorespaces #2}\vskip1sp}}

\long\def\tablecomments#1{\vbox{\uncentering
\vskip2pt{\parindent\saveparindent\def\\ {\vskip1sp}\tablenotefont #1}
\vskip 1sp}}

\let\tablecomment\tablecomments
\def\tablenotes{\uncentering\vskip4pt
\tablenotefont\noindent\hskip\saveparindent\ignorespaces}
\def\endtablenotes{\vskip1sp}

\def\uncentering{%
  \let\\\@normalcr
  \rightskip0pt \leftskip0pt
  \parindent\saveparskip \parfillskip0pt plus 1fil\relax}


\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}

\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}

\newenvironment{plate*}
               {\@dblfloat{plate}}
               {\end@dblfloat}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newdimen\premulticols  
\newdimen\page@free
\newbox\partial@page
\newcount\multicoltolerance
\newcount\doublecol@number
\newskip\multicolbaselineskip 
\newcount\c@collectmore   
\newcount\loopcount
\newdimen\fixdimen
\newcount\c@unbalance     
\newdimen\savedimen
\newif\ifshr@nking

\def\threecolumns[#1]{
\begingroup
%%%%%
%% Frank Mittlebach's multicol macros, minus comments and
%% irrelevancies.
\c@unbalance   = 0
\multicolbaselineskip=0pt
\multicoltolerance = 9999
\premulticols = 50pt
\c@collectmore = 0
\def\multicols##1{\col@number##1\relax
  \@ifnextchar[\mult@cols{\mult@cols[]}}
%
\def\mult@cols[##1]{\@ifnextchar[%
  {\mult@@cols{##1}}%
  {\mult@@cols{##1}[\premulticols]}}
%
\def\mult@@cols##1[##2]{%
   \enough@room##2%
   ##1\nobreak\par%\addvspace\multicolsep 
   \begingroup
   \prepare@multicols\ignorespaces}
%
\def\enough@room##1{\par \penalty\z@
   \page@free \pagegoal
   \advance \page@free -\pagetotal
   \ifdim \page@free <##1  \newpage \fi}
%
\def\prepare@multicols{%
  \output{\global\setbox\partial@page
                 \vbox{\unvbox\@cclv}}\eject
  \vbadness9999 \hbadness5000
  \tolerance\multicoltolerance 
  \doublecol@number\col@number
  \multiply\doublecol@number\tw@
  \advance\baselineskip\multicolbaselineskip
  \advance\@colroom-\ht\partial@page
\ifdim\ht\dbltopins>1pt 
  \advance\@colroom-\ht\dbltopins
  \advance\@colroom-\dp\dbltopins
\advance\@colroom-\baselineskip
\fi
\ifdim\ht\dblbotins>1pt 
 \advance\@colroom-\ht\dblbotins
  \advance\@colroom-\dp\dblbotins
\fi
  \vsize\col@number\@colroom
  \advance\vsize\c@collectmore\baselineskip
  \hsize\columnwidth \advance\hsize\columnsep
  \advance\hsize-\col@number\columnsep
  \divide\hsize\col@number 
  \linewidth\hsize 
  \output{\multi@columnout}%
%  \multiply\count\footins\col@number
%  \multiply\skip \footins\col@number
  \reinsert@footnotes}
%
\def\endmulticols{\parskip=0pt
\par\penalty\z@
  \output{\xbalance@columns}\eject\nobreak%
\endgroup
}
\def\process@cols##1##2{\count@##1\relax
     \loop ##2%
     \advance\count@\tw@
     \ifnum\count@<\doublecol@number 
   \repeat}
\def\page@sofar{\unvbox\partial@page 
   \process@cols\z@{\wd\count@\hsize}%
\hbox to\textwidth{%
     \process@cols\tw@{\box\count@\hss}%
\box\z@}}
\def\reinsert@footnotes{\ifvoid\footins\else
         \insert\footins{\unvbox\footins}\fi}
\def\multi@columnout{%
   \ifnum\outputpenalty <-\@Mi
   \speci@ls \else
   \splittopskip\topskip 
   \splitmaxdepth\maxdepth
   \dimen@\@colroom
\advance\dimen@-12pt %===
 %  \divide\skip\footins\col@number
  % \ifvoid\footins \else
%      \advance\dimen@-\skip\footins 
%      \advance\dimen@-\ht\footins   \fi
   \process@cols\tw@{\setbox\count@
            \vsplit\@cclv to\dimen@}%
   \setbox\z@\vsplit\@cclv to\dimen@
   \ifvoid\@cclv \else 
       \unvbox\@cclv
       \penalty\outputpenalty\fi     
   \setbox\@cclv\vbox{\page@sofar}%
   \@makecol\@outputpage
   \global\@colroom\@colht
   \process@deferreds
   \global\vsize\col@number\@colroom 
   \global\advance\vsize
      \c@collectmore\baselineskip
   \multiply\skip\footins\col@number\fi}

\def\speci@ls{%
   \unvbox\@cclv\reinsert@footnotes
   \gdef\@currlist{}}

\def\process@deferreds{%
   \@floatplacement 
   \begingroup
    \let\@tempb\@deferlist
    \gdef\@deferlist{}%
    \let\@elt\@scolelt
      \@tempb \endgroup}

\def\raggedcolumns{%
   \@bsphack\shr@nkingtrue\@esphack}

\def\flushcolumns{%
   \@bsphack\shr@nkingfalse\@esphack}

\def\escapeloop{\gdef\iterate{}}

\def\xbalance@columns{%
\loopcount=0
\fixdimen=0pt
   \splittopskip\topskip
   \splitmaxdepth\maxdepth
   \setbox\z@\vbox{\unvbox\@cclv}\dimen@\ht\z@
   \advance\dimen@\col@number\topskip
   \advance\dimen@-\col@number\baselineskip
   \divide\dimen@\col@number
   \advance\dimen@\c@unbalance\baselineskip
   {\vbadness\@M \loop
   {\process@cols\@ne{\global\setbox\count@
                              \box\voidb@x}}%
     \global\setbox\@ne\copy\z@
     {\process@cols\thr@@{\savedimen\ht\@ne \advance\savedimen by-\dimen@
\global\setbox\count@ \vsplit\@ne to\dimen@ 
\ifdim\savedimen>\ht\@ne % AH: TeX was forced to make box bigger than \dimen@.
\advance\savedimen by-\ht\@ne \advance\savedimen by -7.1pt 
\ifdim\savedimen>\fixdimen \global\fixdimen\savedimen\fi\fi}}%
    \ifdim\ht\@ne >\ht\thr@@
    \global\advance\dimen@\p@%.5\baselineskip
\global\advance\loopcount by1
\ifnum\loopcount=90 \escapeloop\fi
   \repeat}%
\let\iterate\saveiterate
\dimen@\ht\thr@@  
\ifdim\fixdimen>0pt \advance\dimen@ by \fixdimen\fi
   \process@cols\z@{\@tempcnta\count@ 
        \advance\@tempcnta\@ne
        \setbox\count@\vtop to\dimen@
           {\unvbox\@tempcnta
           \ifshr@nking\vfill\fi}
}%
   \global\vsize\@colroom 
   \global\advance\vsize\ht\partial@page
   \page@sofar
}
%
\multicols3[{{#1}}]}

\def\endthreecolumns{\endmulticols\endgroup}

\def\saveincludegraphics{%
  \@ifstar
    {\Gin@cliptrue\Gin@i}%
    {\Gin@clipfalse\Gin@i}}

\def\includegraphics{\expandafter\ifx\csname rotatebox\endcsname\relax
\show\graphicserror\let\go\relax\else\let\go\saveincludegraphics\fi}

\def\graphicserror{
^^J^^J
--------------------------------------------------------^^J
!! \includegraphics is not defined!^^J
Please use \usepackage[<your driver program>]{graphicx}^^J
(i.e., \usepackage[dvips]{graphicx})^^J^^J
If you don't have graphicx.sty available, you can download^^J 
graphics.zip from the AGU website. When you run pkunzip on it^^J 
you will have graphicx.sty, as well as the documentation, grfguide.tex,^^J
which also shows options you can use when using \includegraphics^^J
^^J
The graphicx package has these options to tune the package for a ^^J
particular driver program. Please choose the name that matches your ^^J
program. If you don't see the name listed here, try dvips.^^J
[dvips], [xdvi], [dvipdf], [dvipsone], [dviwindo], [emtex], ^^J
[dviwin], [pctexps],  [pctexwin],  [pctexhp],  [pctex32], ^^J
[truetex], [tcidvi], [oztex], [textures]^^J
--------------------------------------------------------^^J
}

\def\landscapeerror{
^^J^^J
--------------------------------------------------------^^J
!! landscapetable and landscapefigure need^^J
\usepackage[<your driver program>]{graphicx}^^J
(i.e., \usepackage[dvips]{graphicx})^^J^^J
If you don't have graphicx.sty available, you can download^^J 
graphics.zip from the AGU website. When you run pkunzip on it^^J 
you will have graphicx.sty, as well as the documentation, grfguide.tex,^^J
which also shows options you can use when using \includegraphics^^J
^^J
The graphicx package has these options to tune the package for a ^^J
particular driver program. Please choose the name that matches your ^^J
program. If you don't see the name listed here, try dvips.^^J
[dvips], [xdvi], [dvipdf], [dvipsone], [dviwindo], [emtex], ^^J
[dviwin], [pctexps],  [pctexwin],  [pctexhp],  [pctex32], ^^J
[truetex], [tcidvi], [oztex], [textures]^^J
--------------------------------------------------------^^J
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Specific Style Changes for Particular Journal



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%% Specific Style Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% Contents:
%%  1) Set Dimensions and parameters
%%  2) Fonts
%%  3) Names for particular environments
%%  4) Running Head and Folio
%%  5) Article title page dimensions and parameters
%%  6) Abstract
%%  7) Begin article, endarticle
%%  8) Section heads
%%  9) Captions
%% 10) Table settings
%% 11) Footnotes
%% 12) References

%%%%%%%%%%
%% 1) Set dimensions and parameters

%  PAGE LAYOUT PARAMETERS
%
%   \topmargin      : Extra space added to top of page.
%   @twoside        : boolean.  T if two-sided printing
%   \oddsidemargin  : IF @twoside = T
%                         THEN extra space added to left of odd-numbered
%                              pages.
%                         ELSE extra space added to left of all pages.
%   \evensidemargin : IF @twoside = T
%                         THEN extra space added to left of even-numbered
%                              pages.
%   \headheight     : height of head
%   \headsep        : separation between head and text
%   \footskip       : distance separation between baseline of last
%                     line of text and baseline of foot.
%                     Note difference between \footSKIP and \headSEP.
%   \textheight     : height of text on page, excluding head and foot
%   \textwidth      : width of printing on page

%   \@textbottom    : Command executed at bottom of vbox holding text of page
%                     (including figures).  The \raggedbottom command
%                     almost \let's this to \vfil (actually sets it to
%                     \vskip \z@ plus.0001fil). %expanded 18 Jun 86
%

\topmargin 0pt

\@twosidetrue
\oddsidemargin=-4pt
\evensidemargin=-16pt

\headheight 9pt
\headsep   14pt
\topskip = 11pt

\footnotesep4pt
\skip\footins  18pt  
\footskip 0pt

\textheight=698pt
\textwidth = 41pc
\hsize=41pc

\newdimen\savehsize
\savehsize\hsize

\newdimen\mycolumnwidth
\mycolumnwidth=19pc

\parskip 0pt % plus .001pt
\parindent .15in

\newdimen\saveparindent
\saveparindent=\parindent

\newdimen\saveparskip
\saveparskip=\parskip

%%%%


\widowpenalty=10000
\clubpenalty=10000


\predisplaypenalty=10000

\lineskip0pt
\normallineskip 1pt
\def\baselinestretch{1}

\marginparwidth .9in
\marginparsep 7pt

\columnsep 1pc
\columnseprule 0pt

%  PAGE STYLE PARAMETERS:
%
%   \floatsep       : Space left between floats.
%   \textfloatsep   : Space between last top float or first bottom float
%                     and the text.
%   \topfigrule     : Command to place rule (or whatever) between floats
%                     at top of page and text.  Executed in inner vertical
%                     mode right before the \textfloatsep skip separating
%                     the floats from the text.  Must occupy zero vertical
%                     space.  (See \footnoterule.)
%   \botfigrule     : Same as \topfigrule, but put after the \textfloatsep
%                     skip separating text from the floats at bottom of page.
%   \intextsep      : Space left on top and bottom of an in-text float.
%   \@maxsep        : The maximum of \floatsep, \textfloatsep and \intextsep
%   \@fptop         : Glue to go at top of float column -- must be 0pt +
%                     stretch
%   \@fpsep         : Glue to go between floats in a float column.
%   \@fpbot         : Glue to go at bottom of float column -- must be 0pt +
%                     stretch

\floatsep 12pt plus 2pt minus 2pt
\textfloatsep 20pt plus 2pt minus 4pt
\intextsep 12pt plus 2pt minus 2pt

\ifll\else
\@maxsep 20pt
\@dblmaxsep 20pt
\fi

\dblfloatsep 12pt plus 2pt minus 2pt
\dbltextfloatsep 20pt plus 2pt minus 4pt

\@fptop 0pt plus 1fil
\@fpsep 8pt plus 2fil
\@fpbot 0pt plus 1fil
\@dblfptop 0pt plus 1fil
\@dblfpsep 8pt plus 2fil
\@dblfpbot 0pt plus 1fil
\marginparpush 5pt

\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301

\@beginparpenalty -\@lowpenalty

\@endparpenalty   -\@lowpenalty

\@itempenalty     -\@lowpenalty


%%%%%%%%
%% 3) Names for particular environments

\newcommand\bibname{Bibliography}
\newcommand\figurename{Figure}
\newcommand\tablename{Table}
\newcommand\appendixname{Appendix}

%%%%%%%%
%% 4) Running Head and Folio

\authorwidth=33pc % where should multiple authors wrap?
\authorbaselineskip=14pt % baseline if multiple author lines

%% Uppercase on author and title line in running head.

\authorUCtrue
\titleUCtrue

\def\jheadline{\hbox to\textwidth{\iftitle%
\hfill\titlepageheadlinefont
\uppercase{\journalname, Vol.~\thevolume, XXXX,
doi:10.1029/\thepaperidnumber, \jourdate}\hfill%
\else\ifodd\c@page
{\hfill\headlinesize\headtextfont\theauthors:\ \ \thetitle}%
\hfill\llap{\foliofont X~-~\PutCommaIntoNumber{\the\c@page}}%
\else\rlap{\foliofont X~-~\PutCommaIntoNumber{\the\c@page}}\hfill%
{\headlinesize\headtextfont\theauthors:\ \ \thetitle}%
\hfill\fi\fi}}

\def\jfootline{\hbox to\textwidth{%
\iftitle\global\titlefalse%
\vtop to0pt{\vskip8pt
\hbox to\textwidth{\hfill
\foliofootfont\PutCommaIntoNumber{\c@page}\hfill}
\vss}%
\else\hfill\fi% end iftitle
}% end hbox to textwidth
}


%%%%%%
%% 5) Article title page dimensions and parameters

\CenterArticleHeadfalse

\def\specialtitleins{\raggedright}

\abovereceivedskip=4pt

\belowtitleskip=1sp
\aboveauthorskip=6pt
\belowauthorskip=0pt

\affilwidth=33pc
\aboveaffilskip=4.5pt
\belowaffilskip=0pt

\newif\iffirstsection

\def\editor#1{%
\def\theeditor{\vskip\aboveacceptedskip\noindent Recommending editor: #1}} 
\def\editors#1{%
\def\theeditor{\vskip\aboveacceptedskip\noindent Recommending editors: #1}} 


\let\StartOnNewPage\relax %% can start on even or odd pages

%%%%%%%%%%%%
%% 6) Abstract

\newdimen\abstractwidth
\abstractwidth=33pc
\abstractmargin=0pt
\aboveabstractskip=0pt
\belowabstractskip=19pt
\belowabstractnameskip=0pt

%%%%%%%%%%%%%%%%%%%%%%%%
%% 7) Beginning and end of article

\long\def\printtitle{\global\titletrue
\vspace*{5pt}
{\hsize=38pc %in specs
\raggedright \hyphenpenalty=10000
\parindent=0pt
\let\thanks\titlethanks
\def\\ {\vskip1sp}%
\Large\baselineskip=\titlebaseline\ifjdraft\LARGE\bf\else\titlefont \fi
\theprinttitle\vrule depth\belowtitleskip
width0pt height 0pt
\vskip1sp}%
\setbox1=\hbox{\let\\ \relax\let\thanks\titlemaketemp \theprinttitle}
\ifjdraft\large\else\normalsize\fi}

%% Need PutCommaIntoNumber because page numbers are greater
%% than 1000
\newif\ifspecifiedlastpage
\newcount\currlastnumber
\def\articlelastpagenum#1{\global\specifiedlastpagetrue
\global\currlastnumber=#1\relax}

\def\lastpage{%
\expandafter\ifx\csname endpage\the\c@chapter\endcsname\relax%
 ?? \else--%
\ifspecifiedlastpage \PutCommaIntoNumber{\the\currlastnumber}\else
\PutCommaIntoNumber{\csname endpage\the\c@chapter\endcsname}\fi\fi%
\global\specifiedlastpagefalse\relax}

%% \refstepcounter{chapter} 
%% will reset footnote num, section, theorem, table and figure
\newbox\altaffilbox

%% default article
\def\article{%
%\def\thesubsection{\thesection.\@arabic{\c@subsection}}
\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\footnotesize\fi
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\footnotesize\fi
\hyphenpenalty=10000
\raggedright
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{\ifjdraft\large\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox\vskip8pt\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\vskip3pt\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\vskip3pt\fi
%
\vskip1sp
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\vbox to6pt{\vfill}
%%
%%
\ifjdraft\draftcolumns
\else
%% normal abstract
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
{\abstractnamefont 
\noindent
Abstract.}\hskip1em \relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\theabstract%
\vskip\belowabstractskip
}
\fi
%% end normal abstract
\ifgalley
\vspace*{1pc}
\galleycolumns\else
\twocolumns\fi\fi
\global\firstsectiontrue 
\ifgalley
\ifdim\ht\barticle< 2pt
\ifjgrga
\skip\footins=18pt
\fi
  \let\footnoterule\relax
  \savefootnotetext{%
  \vskip-6pt
  \footnotesize
  \@slug %%
  }
\else
  \savefootnotetext{%
  \vskip-4pt
  \unvbox\barticle
\vskip-6pt
  \footnotesize
\@slug%%
 }
\fi
\else
%% not galley
\ifjdraft
\savefootnotetext{\large\slug@comment
\@sluginfo}
\ifdim\ht\barticle< 2pt\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
%% also not draft
\begin{figure}[b]
\ifdim\ht\barticle>2pt
\hrule width 48pt height .5pt
\vskip1pt
\unvbox\barticle\fi
\footnotesize
\@slug 
\end{figure}
\fi% end normal
\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large
\else
\global\let\normalsize\small \small%
\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
{\abstractnamefont
\noindent
Abstract.}\hskip1em \relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi}

\def\endarticle{\notes
\ifgalley\endgalley\else
\ifjdraft\enddraft\else
\iftriplecol\global\triplecolfalse
\else
\endtwocolumns\fi\fi\fi
\savenormalsize
\ifnum\pagefloatnumber>\pageloopnum
\newpage
\insertpage{\hsize=\textwidth
\linewidth=\textwidth
\csname pagefloat\the\pageloopnum \endcsname}\fi%
\xdef\doitnow{\write\@auxout{\string\expandafter%
\string\gdef\string\csname\space 
endpage\the\c@chapter\endcsname{\the\c@page}}}
\doitnow
\global\parskip=\saveparskip
%% just in case...
\ifdim\ht\dbltopins>2pt \unvbox\dbltopins\fi
\ifdim\ht\dblbotins>2pt\unvbox\dblbotins\fi
\resetdefaults
\global\let\figure\savefigure
\global\let\endfigure\saveendfigure
\global\let\table\savetable
\global\let\endtable\saveendtable
\global\let\caption\savecaption
\global\let\tabular\savetabular
\global\let\endtabular\saveendtabular
\global\let\plate\saveplate
\global\let\endplate\saveendplate
}



%%%%%%
%% 8) Section Heads

\def\thesection{\@arabic{\c@section}}
\def\thesubsection{\thesection.\@arabic{\c@subsection}}
\def\thesubsubsection{\thesubsection.\@arabic{\c@subsubsection}}
\def\theparagraph{\thesubsubsection.\@arabic{\c@paragraph}}

\def\xmakecenterlines#1{\vtop{%
\parindent=0pt
\parskip=0pt
\hyphenpenalty=10000
\centering
#1}}



\newskip\sectskip
\sectskip=17pt %plus .001pt 
minus4pt

\newskip\belowsectionskip
\belowsectionskip=11pt 

\newskip\subsectskip
\newskip\belowsubsectskip
\subsectskip=10pt %plus.001pt 
minus 1pt
\belowsubsectskip=8pt

\newskip\subsubsectskip
\subsubsectskip=1pt %plus .001pt
\newskip\belowsubsubsectskip
\belowsubsubsectskip=1pt

\def\ast{*}
\newif\ifsectionon
\def\section#1{\ifappendon\resetappcounters\fi%
\def\yone{#1}\ifx\yone\ast\let\go\ssection\else%
\let\go\xxsection\fi\go{#1}}

\let\savesection\section
\newif\ifsendcontents

\def\xxsection#1{%
\global\sectionontrue%
\refstepcounter{section}%
\def\@currentlabel{\ifappendon\Alph{section}\else\the\c@section\fi}%
\ifsendcontents\else%
        % hack so contents will only be sent for article with \contents
{\let\\ \ %
\addcontentsline{toc}{section}{\string\vskip-1pt%
\ifappendon\applett.\fi\the\c@section.\string\ \string\ {%
\string\affilfont\space #1.}}}\fi%
\iffirstsection\vspace*{-6pt}\global\firstsectionfalse%
\else\goodbreak\vskip\sectskip\fi%
\vtop{\hyphenpenalty=10000
\savenormalsize\baselineskip=12pt
\boldmath %% makes 10pt bold math
\noindent
\sectionfont\ifappendon Appendix \Alph{section}%
\def\xone{#1}%
\ifx\xone\empty\else:\fi\else\thesection.\fi\nobreak\hskip8pt\relax%
{#1}\vskip\belowsectionskip}%
\nobreak\parskip=0pt \global\everymath={}%
\everypar={\global\sectiononfalse\everypar={}\ignorespaces}
}

\def\ssection#1#2{\vskip\sectskip\global\sectionontrue%
\ifappendon\refstepcounter{section}\fi 
        %% above, so that \appendix \section*{Appendix} sets equation and
        %% figure number to A
\vtop{\hyphenpenalty=10000 
\savenormalsize
\ifjdraft\baselineskip=28pt\else\baselineskip=12pt\fi
\boldmath %% makes 10pt bold math
\noindent\sectionfont{#2}\vskip\belowsectionskip}%
\nobreak\everypar={\global\sectiononfalse\everypar={}}}

%%%%

\def\subsection#1{\def\one{#1}\ifx\one\ast\let\go\ssubsection\else%
\let\go\xxsubsection\fi\go{#1}}

\let\savesubsection\subsection

\newif\ifsubsectionon
\def\xxsubsection#1{\ifsectionon\global\sectiononfalse\ifvmode\vskip-3pt
\else\vskip\subsectskip\fi%
\else\vskip\subsectskip\fi\global\subsectionontrue
\refstepcounter{subsection}%
%\def\@currentlabel{\ifappendon\applett.\fi\the\c@section.\the\c@subsection}
\def\@currentlabel{\thesubsection}
\vtop{\hyphenpenalty=10000 
\savenormalsize\baselineskip=11pt\boldmath %% 10pt boldmath
\noindent
%\subsectionfont\ifappendon\applett.\fi\thesubsection.\hskip8pt\relax#1
\subsectionfont\thesubsection.\hskip8pt\relax#1
\vskip\belowsubsectskip}%
\global\everymath={}%
\everypar={\global\subsectiononfalse\everypar={}}
\nobreak}

\def\ssubsection#1#2{\ifsectionon\global\sectiononfalse
\ifvmode\vskip-\lastskip\fi\vskip\subsectskip\else
\vskip\subsectskip\fi\global\subsectionontrue
\vtop{\hyphenpenalty=10000 
\savenormalsize\boldmath\baselineskip=11pt% boldmath at 10pt
\noindent\subsectionfont#2
\vskip\belowsubsectskip}%
\everypar={\global\subsectiononfalse\everypar={}}
\nobreak}

\def\subsubsection#1{\def\one{#1}\ifx\one\ast\let\go\ssubsubsection\else%
\let\go\xxsubsubsection\fi\go{#1}
}

\def\xxsubsubsection#1{%
\refstepcounter{subsubsection}%
\def\@currentlabel{\the\c@section.\the\c@subsection.\the\c@subsubsection}
\ifsectionon \global\sectiononfalse\ifvmode \vskip-3pt\else%
\vskip\subsubsectskip\fi\else%
\ifsubsectionon\global\subsectiononfalse 
\ifvmode\vskip-3pt\else%
\vskip\subsubsectskip\fi\else\vskip\subsubsectskip
\fi\fi%
{\def\\ {\vskip1sp}%\indent
\noindent{\savenormalsize\boldmath\subsubsectionfont\thesubsubsection.\hskip8pt%
#1}\vskip\belowsubsubsectskip}\global\everymath={}%
\ignorespaces}


\def\ssubsubsection#1#2{%
\ifsectionon\global\sectiononfalse\ifvmode\vskip-3pt\else
\vskip\subsubsectskip\fi\else%
\ifsubsectionon\global\subsectiononfalse\ifvmode\vskip-3pt 
\else\vskip\subsubsectskip\fi\else\vskip\subsubsectskip\fi\fi%
\noindent{\savenormalsize\boldmath\subsubsectionfont#2}\vskip\belowsubsubsectskip}

\newcount\c@subsubsubsection
\def\thesubsubsubsection{\arabic{section}.\arabic{subsection}.%
\arabic{subsubsection}.\arabic{subsubsubsection}.}

\def\subsubsubsection#1{\def\one{#1}\ifx\one\ast\let\go\ssubsubsubsection\else%
\let\go\xxsubsubsubsection\fi\go{#1}
}

\def\xxsubsubsubsection#1{%
\refstepcounter{subsubsubsection}%
\def\@currentlabel{\the\c@section.\the\c@subsection.%
\the\c@subsubsection.\the\c@subsubsubsection}
\ifsectionon\global\sectiononfalse\ifvmode\vskip-3pt\else%
\vskip\subsubsectskip\fi\else%
\ifsubsectionon\global\subsectiononfalse
\ifvmode\vskip-3pt\else%
\vskip\subsubsectskip\fi\else\vskip\subsubsectskip\fi\fi%
{\def\\ {\vskip1sp}
\noindent{\savenormalsize\boldmath\subsubsectionfont\thesubsubsubsection\hskip8pt%
#1}\vskip\belowsubsubsectskip}\global\everymath={}%
\ignorespaces}

\def\ssubsubsubsection#1#2{%
\ifsectionon\global\sectiononfalse\ifvmode\vskip-3pt\else
\vskip\subsubsectskip\fi\else%
\ifsubsectionon\global\subsectiononfalse\ifvmode\vskip-3pt 
\else\vskip\subsubsectskip\fi\else\vskip\subsubsectskip\fi\fi%
\noindent{\savenormalsize\boldmath\subsubsectionfont#2}\vskip\belowsubsubsectskip}

\def\paragraph#1{\vskip1sp
\indent{\savenormalsize\boldmath\paragraphfont #1:\hskip8pt\relax}\ignorespaces}



%%%%%%
%% 9) Captions

\centermultiplelinestrue
\centersinglelinefalse
\centersingletablinefalse

\let\captionsize\small
\abovefigcaptionskip=6pt %

\abovetabcaptionskip=1pt
\abovetableskip=-9pt

\newdimen\captionwidth
\newdimen\widecaptionwidth
\newdimen\landscapecaptionwidth

\captionwidth=\mycolumnwidth
\widecaptionwidth=35pc
\landscapecaptionwidth=57pc

%%%%%%
%% 10) Table settings

%% (make no op because they are not applied consistently)
\def\thetablelines{}%\hrule width \hsize\vskip1sp}%
                  
\belowtabcaptionskip=6pt
\fullwidthtablefalse
\lineabovetabcaptionfalse
\linebelowtabcaptiontrue

\abovetabularskip=0pt
\belowtabularskip=0pt

%%%%%%%%%
%% 11) Footnotes

\def\footnoterule{\kern -3\p@ \hrule 
width 4pc %%<=== change this dimen to change width of footnote rule line
\kern 2.6\p@}

\let\footnote\endnotes

\newtoks\@temptokenb
\def\authaddr@list{}
\def\authoraddress#1{\par
\@temptokena={\ifjdraft\large\else\footnotesize\fi\par\noindent\vrule height 8.5pt width0pt
\hskip.15in\relax#1\vskip1sp}
\@temptokenb=\expandafter{\authaddr@list}
\xdef\authaddr@list{\the\@temptokenb\the\@temptokena}}
\let\authoraddr=\authoraddress

%%%%%%%%
%% 12) References

%% this def not used
\def\references{\notes
\vskip12pt
\goodbreak
\noindent{\sectionfont References}
\vskip6pt
\bgroup
\referencesize\itemsep=1pt
\list{\@biblabel{\arabic{enumiv}}}
{\settowidth\labelwidth{\@biblabel{10.}}%
    \leftmargin\labelwidth
%    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000 \frenchspacing
    \sfcode`\.=\@m}

% same as \references, except for #1 which doesn't get used, in
% case author supplies \thebibliography{10}, which now will not be used.
\def\bibreferences#1{\notes
%\goodbreak
%\vskip12pt
\section*{References}
\bgroup
\referencesize\itemsep=1pt
\list{\@biblabel{\arabic{enumiv}}}
{\settowidth\labelwidth{\@biblabel{10.}}%
    \leftmargin\labelwidth
%    \advance\leftmargin\labelsep
    \usecounter{enumiv}%
    \let\p@enumiv\@empty
    \def\theenumiv{\arabic{enumiv}}}%
    \def\newblock{\hskip .11em plus.33em minus.07em}%
    \sloppy\clubpenalty4000\widowpenalty4000 \frenchspacing
    \sfcode`\.=\@m}

\def\references{\thebibliography{}}
\def\endreferences{\endthebibliography}
\let\endbibreferences\endreferences

%% default def:
\def\bibitem{\@ifnextchar[\@lbibitem\@bibitem}
\def\@lbibitem[#1]#2{\item[\@biblabel{#1}\hfill]\if@filesw
      {\let\protect\noexpand\immediate
       \write\@auxout{\string\bibcite{#2}{#1}}}\fi\ignorespaces}
\def\@bibitem#1{\item\if@filesw \immediate\write\@auxout
       {\string\bibcite{#1}{\the\value{\@listctr}}}\fi\ignorespaces}

%% default def, except conditional to avoid vskips for first bibitem
%% relevant?
\def\@donoparitem{\@noparitemfalse
   \global\setbox\@labels\hbox{\hskip -\leftmargin
                               \unhbox\@labels
                                \hskip \leftmargin}\if@minipage\else
\ifstartofbib\else
  \@tempskipa\lastskip
  \vskip -\lastskip \advance\@tempskipa\@outerparskip
  \advance\@tempskipa -\parskip \vskip\@tempskipa
\fi\fi}
%%
\def\@item[#1]{\if@noparitem \@donoparitem
  \else  \if@inlabel \indent \par \fi
         \ifhmode \unskip\unskip \par \fi
         \if@newlist \if@nobreak \@nbitem \else
  \ifstartofbib\else
                      \addpenalty\@beginparpenalty
                   \addvspace\@topsep \addvspace{-\parskip}
\fi
\fi
           \else 
\ifstartofbib\else
\addpenalty\@itempenalty 
\addvspace\itemsep 
\fi
          \fi
    \global\@inlabeltrue
\fi
\everypar{\@minipagefalse
          \global\@newlistfalse
          \if@inlabel
            \global\@inlabelfalse
           {\setbox\z@\lastbox}%
            \box\@labels
            \penalty\z@
          \fi
          \if@nobreak
            \@nobreakfalse
            \clubpenalty \@M
          \else
            \clubpenalty \@clubpenalty
            \everypar{}%
          \fi}%
\if@noitemarg \@noitemargfalse \if@nmbrlist
      \refstepcounter\@listctr\fi \fi
\sbox\@tempboxa{\makelabel{#1}}%
\global\setbox\@labels
 \hbox{\unhbox\@labels \hskip \itemindent
       \hskip -\labelwidth \hskip -\labelsep
       \ifdim \wd\@tempboxa >\labelwidth
                \box\@tempboxa
          \else \hbox to\labelwidth {\unhbox\@tempboxa}\fi
       \hskip \labelsep}\global\startofbibfalse
\ignorespaces}

\newif\ifbibtonextpage
\def\bibtonextpage{\global\bibtonextpagetrue}
\newif\ifstartofbib

\def\thebibliography#1{\vskip1sp
\global\startofbibtrue
\notes
\ifgalley
\ifjdraft
\else
\setonecolboxesandredefine
\ifdim\ht\endcolsavetopinsert>1pt
\unvbox\endcolsavetopinsert\fi
\ifdim\ht\endcolsavebotinsert>1pt
\unvbox\endcolsavebotinsert
\fi\fi\fi
%%
\ifbibtonextpage\global\bibtonextpagefalse\eject\fi
\vskip12pt
\section*{References}
\nobreak\bgroup
\ifjdraft\large\else\footnotesize\fi%
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt
}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthebibliography{
\vskip1sp\spendlist\egroup%
\ifjdraft\else\@sluginfo\fi}
\def\@biblabel#1{\relax}

\newif\iftriplecol
\def\threecolthebibliography#1{\global\triplecoltrue
\global\startofbibtrue
\notes
\ifgalley
\section*{References}
  \hsize\columnwidth \advance\hsize\columnsep
  \advance\hsize-3\columnsep
  \divide\hsize3
  \linewidth\hsize 
\else
\ifjdraft
\section*{References}
\else
\endtwocolumns
\vskip12pt
\columnwidth=\textwidth
\threecolumns[\section*{References}]
\fi\fi%% end ifgalley, end ifjdraft
\bgroup\ifjdraft\large\else\footnotesize\fi%
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthreecolthebibliography{\vskip1sp\spendlist\egroup%
\ifjdraft\else\@sluginfo\fi
\ifgalley\else
\ifjdraft\else
\endthreecolumns\fi\fi
\xdef\doitnow{\write\@auxout{\string\expandafter%
\string\gdef\string\csname\space 
endpage\the\c@chapter\endcsname{\the\c@page}}}
\doitnow
\newpage
}

\def\reference{\relax\refpar}
\def\markcite#1{#1\relax}

%%%%%% Article Bibliography Using BibTeX

\def\bblname#1{\def\currentfilename{#1}}

\def\include#1{\relax\ifnum\@auxout=\@partaux 
\@latex@error {\string \include \space cannot be nested}\@eha 
\else\gdef\currfile{#1} \@include #1 \fi } 

\def\articlebibliography#1{%
{\let\thebibliography\references
\let\endthebibliography\endreferences
\@input {\currfile.bbl}}
}

%% 14) Acknowledgements

\ackskip=6pt

\def\acknowledgments{\goodbreak\vskip\ackskip
\ifjdraft\large\else\footnotesize\fi{\bf Acknowledgments.}%
\hskip6pt\relax\ignorespaces}%

\let\acknowledgements\acknowledgments
\let\acknowledgement\acknowledgments
\let\acknowledgment\acknowledgments

\def\endacknowledgment{\vskip1sp}
\let\endacknowledgments\endacknowledgment
\let\endacknowledgement\endacknowledgment
\let\endacknowledgements\endacknowledgment

%C&G 8/1/2001 addition to process @pubdate & place \published after the rec, rev, acc dates
%
\def\@dates{{\footnotesize
{\rm Received}\space%
\ifx\@recvdate\@empty\@rcvaccrule\else\@recvdate\fi%
\ifx\@revisedate\@empty\relax\else%
; \space{\rm revised}\space\@revisedate; \fi%
\ifx\@accptdate\@empty\else
\ifx\@revisedate\@empty;\fi\space{\rm accepted}\space\@accptdate\fi%
\ifx\@pubdate\@empty.\else%
; \space{\rm published}\space\@pubdate.\fi%
\vskip-2pt}}


\def\@authaddrs{\ifx\authaddr@list\@empty\relax
\else
{\noindent\parindent=.15in 
\ifjdraft\large\else\small\fi\authaddr@list\vskip1sp}
\gdef\authaddr@list{}
\fi}

\newskip\beforeendskip
\beforeendskip=9pt plus 2pt minus 6pt
\def\@sluginfo{\ifjdraft\else\vskip\beforeendskip
\hrule width 4pc\fi
\nobreak%
{\ifjdraft\large\else\footnotesize\fi
\clubpenalty=3000 \widowpenalty=3000
\parskip=0pt % plus 1pt %% amyh
\@authaddrs\par
\ifjdraft\else
\ifrog\else
%\vskip\beforeendskip
%\noindent\@dates
\fi\fi}}

\let\makecenterlines\noindent
\let\onecolumn\newpage

%%%%%%%%%%%%%%%%%%%%%%%

% jgrga JOURNAL OF GEOPHYSICAL RESEARCH
% gbc   GLOBAL BIOCHEMICAL CYCLES
% tec   TECTONICS
% grl   GEOPHYSICAL RESEARCH LETTERS
% pal   PALEOCEANOGRAPHY
% ras   RADIO SCIENCE
% rog   REVIEWS OF GEOPHYSICS
% wrr   Water Resources Research
% sw    SPACE WEATHER - no cccline

\def\shortyear#1#2#3#4{#3#4}
\def\thecccline{%
\ifjgrga 0148-0227\else%
\ifgbc 0886-6236\else
\iftec 0278-7407\else%
\ifgrl 0094-8276\else
\ifpal 0883-8305\else
\ifras 0048-6604\else
\ifrog 8755-1209\else
\ifwrr 0043-1397
\fi\fi\fi\fi\fi\fi\fi\fi/\expandafter\shortyear\the\year/%
\thepaperidnumber\ifrog\else\string$\fi
\ifjgrga9.00\else%
\ifgbc12.00\else
\iftec12.00\else%
\ifgrl5.00\else
\ifpal 12.00\else
\ifras 11.00\else
\ifrog\footlineitalic
\string$15.00\else
\ifwrr 9.00\fi\fi\fi\fi\fi\fi\fi\fi}

\def\ccc#1{\xdef\thiscccline{\thecccline}
\typeout{
^^J^^J
===========================================================
^^J^^J
 It is no longer necessary
to type the command \string\ccc\space since ^^J
the ccc line is automatically set for each journal.^^J^^J
Use \string\specialccc{<new CCC line>}\space only 
if you need to overwrite^^J
the default CCC line
which you can see below:^^J
}
\show\thiscccline
\typeout{^^J^^J
===========================================================
^^J^^J}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Using AGU2001 class options:
%% Settings for particular journals
%%
%% Journals:
%
% jgrga JOURNAL OF GEOPHYSICAL RESEARCH
% gbc   GLOBAL BIOCHEMICAL CYCLES
% tec   TECTONICS
% grl   GEOPHYSICAL RESEARCH LETTERS
% pal   PALEOCEANOGRAPHY
% ras   RADIO SCIENCE
% rog   REVIEWS OF GEOPHYSICS
% wrr   Water Resources Research
% sw    Space Weather

\def\NoJournalError{^^J^^J
Please supply a journal style option:^^J
\documentclass[<journal>]{agu2001}^^J
^^J
Your choices are^^J
jgrga for  JOURNAL OF GEOPHYSICAL RESEARCH^^J
gbc  for  GLOBAL BIOCHEMICAL CYCLES^^J
grl  for  GEOPHYSICAL RESEARCH LETTERS^^J
pal  for  PALEOCEANOGRAPHY^^J
ras  for  RADIO SCIENCE^^J
rog  for  REVIEWS OF GEOPHYSICS^^J
tec  for  TECTONICS^^J
wrr  for WATER RESOURCES RESEARCH^^J^^J
sw   for SPACE WEATHER^^J^^J}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\ifjgrga %%%%%%%% Journal of Geophysical Research
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\stylecurrversion{October 1, 2001}
\def\journalname{\uppercase{Journal of Geophysical Research}}

\landscapecaptionwidth=35pc
\skip\footins=30pt

\typeout{^^J^^J
JGRGA style option,
\stylecurrversion,^^J
\string\documentclass[jgrga]{AGU2001}^^J
``Journal of Geophysical Research'', ^^J
Published by American Geophysical Union^^J^^J}

\topmargin=-32pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\ifsw %%%%%%%% Space Weather
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\stylecurrversion{September 11, 2003}
\def\journalname{\uppercase{Space Weather}}

\landscapecaptionwidth=35pc
\skip\footins=30pt

\typeout{^^J^^J
SW style option,
\stylecurrversion,^^J
\string\documentclass[sw]{AGU2001}^^J
``Space Weather'', ^^J
Published by American Geophysical Union^^J^^J}

\topmargin=-32pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\def\@slug{\ifgalley\hsize=\mycolumnwidth\fi
\@makeslugcmmnt
\vskip11pt
\noindent
\ifcase\@cprtype
   \relax
\or
   Copyright \cpr@year\space by the \cpr@holder.
\or
   This paper is not subject to U.S. copyright.
   Published in \cpr@year\space by the \cpr@holder.
\or
   Published in \cpr@year\space by the \cpr@holder.
\or
   No copyright is claimed for this article.
\fi
%\vskip 11\p@\noindent
%Paper number \thepaperidnumber.
\relax}

\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifgbc %%%%%%%% Global Biogochemical Cycles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{October 1, 2001}

\skip\footins  26pt % 
\landscapecaptionwidth=35pc % ??

\centersinglelinetrue
\centersingletablinetrue

\textheight=692pt
\def\journalname{\uppercase{Global Biogeochemical Cycles}}

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\headsep   20pt
\columnsep=1.25pc %% other styles are 1pc, this may be mistaken
\topmargin=-32pt

\typeout{^^J^^J
GBC style option,
\stylecurrversion,^^J
\string\documentclass[gbc]{AGU2001}^^J
``Global Biogeochemical Cycles'', ^^J
Published by American Geophysical Union^^J^^J}

\long\def\xprinttitle{\global\titletrue
\vspace*{9pt}
{\hsize=33pc %in specs
\raggedright \hyphenpenalty=10000
\parindent=0pt
\let\thanks\titlethanks
\def\\ {\vskip1sp}%
\Large\baselineskip=\titlebaseline\ifjdraft\LARGE\bf\else\titlefont \fi
\theprinttitle\vrule depth\belowtitleskip
width0pt height 0pt
\vskip1sp}%
\setbox1=\hbox{\let\\ \relax\let\thanks\titlemaketemp \theprinttitle}
\ifjdraft\large\else\normalsize\fi}

\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\iftec %%%%%%%% Tectonics
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{October 1, 2001}

\oddsidemargin=-10pt
\evensidemargin=-12pt

\textheight=672pt 
\topmargin=-26pt
\centersinglelinetrue
\centersingletablinetrue

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\landscapecaptionwidth=\textheight
\advance\landscapecaptionwidth by-\topskip


\newskip\nostretchskip
\nostretchskip=1sp
\def\@dates{{\footnotesize\parskip=0pt
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
({\rm Received}\space%
\ifx\@recvdate\@empty\@rcvaccrule\else\@recvdate;%
\vskip\nostretchskip\noindent\fi%
\ifx\@revisedate\@empty\relax\else%
{\rm revised}\space\@revisedate;\vskip\nostretchskip\noindent\fi%
\ifx\@accptdate\@empty\else
\ifx\@revisedate\@empty\fi{\rm accepted}\space%
\@accptdate\fi%% below added oct 2, 2001
\ifx\@pubdate\@empty.\else%
;\vskip\nostretchskip\noindent{\rm published}\space\@pubdate.\fi)%
}}

\def\journalname{\uppercase{TECTONICS}}

\typeout{^^J^^J
TEC class option,
\stylecurrversion,^^J
\string\documentclass[tec]{AGU2001}^^J
``TECTONICS'', ^^J
Published by American Geophysical Union^^J^^J}

\belowabstractskip=6pt

%% tectonics version!!!
\def\article{\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\footnotesize\fi
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\footnotesize\fi
\raggedright
\hyphenpenalty=10000
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{
\ifjdraft\large\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox\vskip8pt\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\vskip3pt\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\vskip3pt\fi
%
\vskip1sp
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\ifdocumentationextraspace
\vskip12pt\fi
\vbox to6pt{\vfill}
\vskip24pt
\ifjdraft\draftcolumns\else
\ifgalley\galleycolumns
\vglue-8pt
\else
\global\firstsectiontrue\everypar={\global\firstsectionfalse\everypar={}}
\twocolumns\fi\fi
%% normal abstract
\ifjdraft\else
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\abstractsize
{\abstractnamefont 
\noindent
Abstract.}\hskip1em \relax\ifdim\belowabstractnameskip>0pt
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\theabstract%
\vskip\belowabstractskip
}
\fi
%% end normal abstract
\fi %% end ifjdraft
%%
\ifgalley
\ifdim\ht\barticle<2pt
\let\footnoterule\relax
\skip\footins=16pt
\savefootnotetext{
\footnotesize
\@slug
}
\else
\skip\footins=24pt
\savefootnotetext{\vskip-4pt
\unvbox\barticle
\vskip-6pt
\footnotesize
\@slug
}
\fi
\else
\ifjdraft
\savefootnotetext{\large\slug@comment
\@sluginfo}
\ifvoid\barticle\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
\begin{figure}[b]
\ifvoid\barticle
\else
\ifdim\ht\barticle>1pt
\hrule width 48pt height .5pt
\vskip1pt
\unvbox\barticle\fi\fi
\footnotesize
\@slug 
\end{figure}
\fi% end normal
\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
{\abstractnamefont 
\noindent
Abstract.}\hskip1em \relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi
}

\def\threecolthebibliography#1{%amyh feb 2002
\global\triplecoltrue
\global\startofbibtrue
\notes
\ifgalley
\section*{References}
  \hsize\columnwidth \advance\hsize\columnsep
  \advance\hsize-3\columnsep
  \divide\hsize3
  \linewidth\hsize 
\else
\ifjdraft
\section*{References}
\else
\endtwocolumns
\vskip1sp
\columnwidth=\textwidth
\threecolumns[\section*{References}]
\fi\fi%% end ifgalley, end ifjdraft
\bgroup
\ifjdraft\large\else\footnotesize\fi%
\baselineskip=9.5pt plus .01pt minus .5pt
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthreecolthebibliography{\vskip1sp\spendlist\egroup%
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
\ifjdraft\else\@sluginfo\fi
\ifgalley\else
\ifjdraft\else
\endthreecolumns\fi\fi
\xdef\doitnow{\write\@auxout{\string\expandafter%
\string\gdef\string\csname\space 
endpage\the\c@chapter\endcsname{\the\c@page}}}
\doitnow
\newpage
}

\def\authoraddress#1{\par
\@temptokena={\ifjdraft\large\else\footnotesize
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont\fi
\par\noindent\vrule height 8.5pt width0pt
\hskip.15in\relax#1\vskip1sp}
\@temptokenb=\expandafter{\authaddr@list}
\xdef\authaddr@list{\the\@temptokenb\the\@temptokena}}
\let\authoraddr=\authoraddress

\let\thebibliography\threecolthebibliography
\let\endthebibliography\endthreecolthebibliography

\def\jfootline{\hbox to\textwidth{%
\iftitle\global\titlefalse%
\vtop to0pt{\vskip10pt
\hbox to\textwidth{\hfill
\foliofootfont\PutCommaIntoNumber{\c@page}\hfill}
\vss}%
\else\hfill\fi% end iftitle
}% end hbox to textwidth
}

\def\endacknowledgment{\vskip-2pt}

\let\endacknowledgments\endacknowledgment
\let\endacknowledgement\endacknowledgment
\let\endacknowledgements\endacknowledgment

\else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifwrr %%%%%%%% Water Resources Research
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
\def\stylecurrversion{October 1, 2001}

\def\journalname{\uppercase{Water Resources Research}}

\topmargin=-38pt
\oddsidemargin-6pt
\evensidemargin=-18pt

\aboveabstractskip=4pt
\belowabstractskip=19pt

\aboveauthorskip=10pt 

\ackskip=18pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\typeout{^^J^^J
WRR class option,
\stylecurrversion,^^J
\string\documentclass[wrr]{AGU2001}^^J
``Water Resources Research'', ^^J
Published by American Geophysical Union^^J^^J}

\def\thebibliography#1{\vskip1sp
\global\startofbibtrue
\notes
\ifgalley
\ifjdraft
\else
\setonecolboxesandredefine
\ifdim\ht\endcolsavetopinsert>1pt
\unvbox\endcolsavetopinsert\fi
\ifdim\ht\endcolsavebotinsert>1pt
\unvbox\endcolsavebotinsert
\fi\fi\fi
%%
\ifbibtonextpage\global\bibtonextpagefalse\eject\fi
\vskip1sp
\section*{References}
\nobreak\bgroup
\ifjdraft\large\else\footnotesize\fi%
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt
}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifgrl %%  GEOPHYSICAL RESEARCH LETTERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{October 1, 2001}

\def\journalname{\uppercase{GEOPHYSICAL RESEARCH LETTERS}}

% 11/2/01 C&G reinstate top margin 
% Reset topmargin in-house when necessary
\topmargin=-32pt

% C&G OK!
% amyh: Moved the change below to GRL section, since I didn't
% know if 41pc was the width for all styles
% C&G 7/12/01 \widecaptionwidth=35pc should be 41pc
\widecaptionwidth=41pc


\oddsidemargin-6pt
\evensidemargin=-18pt

% MLK - change GRL pagestats
\textheight=681pt
\textwidth=41pc


\skip\footins=30pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\typeout{^^J^^J
GRL class option,
\stylecurrversion,^^J
\string\documentclass[grl]{AGU2001}^^J
``Geophysical Research Letters'', ^^J
Published by American Geophysical Union^^J^^J}

\def\article{\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\footnotesize\fi
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\footnotesize\fi
\raggedright
\hyphenpenalty=10000
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{
\ifjdraft\large\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox\vskip8pt\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\vskip3pt\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\vskip3pt\fi
%
\vskip1sp
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\ifdocumentationextraspace
\vskip12pt\fi
\vbox to6pt{\vfill}
%%
%%
\vskip12pt
\ifjdraft\draftcolumns\else
\ifgalley\galleycolumns
\vglue-6pt\else
\twocolumns\fi\fi
%% normal abstract
\ifjdraft\else
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hbadness5000
\tolerance5000
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\theabstract%
\vskip\belowabstractskip
}
\fi
%% end normal abstract
\fi %% end ifjdraft
%
\global\firstsectiontrue\everypar={\global\firstsectionfalse\everypar={}}
\ifgalley
\skip\footins=26pt
\global\firstsectionfalse
\ifdim\ht\barticle<2pt
\let\footnoterule\relax
\savefootnotetext{\vskip-4pt
\footnotesize 
\@slug
}
\else
\savefootnotetext{\vskip-4pt
\unvbox\barticle
\vskip-6pt
\footnotesize
\@slug
}
\fi
\else
\ifjdraft
\savefootnotetext{\large\slug@comment
\@sluginfo}
\ifvoid\barticle\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
\begin{figure}[b]
\ifvoid\barticle
\else
\ifdim\ht\barticle>1pt
\hrule width 48pt height .5pt
\vskip1pt
\unvbox\barticle\fi\fi
\footnotesize
\@slug 
\end{figure}
\fi\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large\else
\global\let\normalsize\small \small\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi
}

\belowabstractskip=12pt
\else

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifpal %%  PALEOCEANOGRAPHY
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{October 1, 2001}

\def\journalname{\uppercase{PALEOCEANOGRAPHY}}

\topmargin=-3pc
\textheight=679pt
\skip\footins=30pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\landscapecaptionwidth=\textheight
\advance\landscapecaptionwidth by-\topskip
\typeout{^^J^^J
PAL class option,
\stylecurrversion,^^J
\string\documentclass[pal]{AGU2001}^^J
``PALEOCEANOGRAPHY'', ^^J
Published by American Geophysical Union^^J^^J}


\def\article{\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\footnotesize\fi
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\footnotesize\fi
\raggedright
\hyphenpenalty=10000
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{
\ifjdraft\large\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox\vskip8pt\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\vskip3pt\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\vskip3pt\fi
%
\vskip1sp
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\ifdocumentationextraspace
\vskip12pt\fi
\vbox to6pt{\vfill}
%%
%%
\ifjdraft\draftcolumns\else
%% normal abstract
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hbadness5000
\tolerance5000
\hsize=\textwidth
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\theabstract%
\vskip\belowabstractskip
}
\fi
%% end normal abstract
\ifgalley\galleycolumns
\vglue-14pt
\else
\global\firstsectiontrue\everypar={\global\firstsectionfalse\everypar={}}
\twocolumns\fi\fi
\ifgalley
\ifdim\ht\barticle<2pt
\skip\footins=18pt
\let\footnoterule\relax
\savefootnotetext{\vskip-4pt
\footnotesize
\@slug
}
\else
\skip\footins=30pt
\def\footnoterule{\kern -3\p@ \hrule 
width 4pc %%<=== change this dimen to change width of footnote rule line
\kern -2.6\p@}
\savefootnotetext{\unvbox\barticle
\vskip-6pt
\footnotesize
\@slug
\vspace*{-3pt}
}
\fi
\else
\ifjdraft
\savefootnotetext{\large\slug@comment
%\vskip-24pt
\@sluginfo}
\ifvoid\barticle\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
\begin{figure}[b]
\ifvoid\barticle
\else
\ifdim\ht\barticle>1pt
\hrule width 48pt height .5pt
\vskip1pt
\unvbox\barticle\fi\fi
\footnotesize
\@slug 
\end{figure}
\fi\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large\else
\global\let\normalsize\small \small\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi
}

\newskip\nostretchskip
\nostretchskip=1sp
\def\@dates{{\footnotesize\parskip=0pt
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
({\rm Received}\space%
\ifx\@recvdate\@empty\@rcvaccrule\else\@recvdate;%
\vskip\nostretchskip\noindent\fi%
\ifx\@revisedate\@empty\relax\else%
{\rm revised}\space\@revisedate;\vskip\nostretchskip\noindent\fi%
\ifx\@accptdate\@empty\else
\ifx\@revisedate\@empty\fi{\rm accepted}\space%
\@accptdate\fi% added below oct 2, 2001
\ifx\@pubdate\@empty.\else%
;\vskip\nostretchskip\noindent{\rm published}\space\@pubdate.\fi)%

}}

\long\def\printtitle{\global\titletrue
\vspace*{22pt}
{\hsize=33pc %in specs
\raggedright \hyphenpenalty=10000
\parindent=0pt
\let\thanks\titlethanks
\def\\ {\vskip1sp}%
\Large\baselineskip=\titlebaseline\ifjdraft\LARGE\bf\else\titlefont \fi
\theprinttitle\vrule depth\belowtitleskip
width0pt height 0pt
\vskip1sp}%
\setbox1=\hbox{\let\\ \relax\let\thanks\titlemaketemp \theprinttitle}
\ifjdraft\large\else\normalsize\fi}

\def\authoraddress#1{\par
\@temptokena={\ifjdraft\large\else\footnotesize
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont\fi
\par\noindent\vrule height 8.5pt width0pt
\hskip.15in\relax#1\vskip1sp}
\@temptokenb=\expandafter{\authaddr@list}
\xdef\authaddr@list{\the\@temptokenb\the\@temptokena}}
\let\authoraddr=\authoraddress

\def\threecolthebibliography#1{% amyh feb 2002
\global\triplecoltrue
\global\startofbibtrue
\notes
\ifgalley
\section*{References}
  \hsize\columnwidth \advance\hsize\columnsep
  \advance\hsize-3\columnsep
  \divide\hsize3
  \linewidth\hsize 
\else
\ifjdraft
\section*{References}
\else
\endtwocolumns
\vskip1sp
\columnwidth=\textwidth
\threecolumns[\section*{References}]%
\fi\fi%% end ifgalley, end ifjdraft
\bgroup
\ifjdraft\large\else\footnotesize\fi%
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthreecolthebibliography{\vskip1sp\spendlist
\egroup%
\let\rm\rmreferencefont\rm
\let\it\itreferencefont \let\bf\bfreferencefont
\ifjdraft\else\@sluginfo\fi
\ifgalley\else
\ifjdraft\else
\endthreecolumns\fi\fi
\xdef\doitnow{\write\@auxout{\string\expandafter%
\string\gdef\string\csname\space 
endpage\the\c@chapter\endcsname{\the\c@page}}}
\doitnow
\newpage
}

\let\thebibliography\threecolthebibliography
\let\endthebibliography\endthreecolthebibliography


\def\endacknowledgment{\vskip-2pt}

\let\endacknowledgments\endacknowledgment
\let\endacknowledgement\endacknowledgment
\let\endacknowledgements\endacknowledgment

\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifras %%  RADIO SCIENCE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{October 1, 2001}

\def\journalname{Radio Science}

\topmargin=-13pt
\textheight=614pt

\landscapecaptionwidth=\textheight
\advance\landscapecaptionwidth by-\topskip

\oddsidemargin=2pc
\evensidemargin=-27pt

\sectskip=17pt %plus .001pt minus2pt

\typeout{^^J^^J
RAS class option,
\stylecurrversion,^^J
\string\documentclass[ras]{AGU2001}^^J
``RADIO SCIENCE'', ^^J
Published by American Geophysical Union^^J^^J}

\textwidth=39pc
\mycolumnwidth=19pc
\linewidth=\mycolumnwidth
\captionwidth=\mycolumnwidth
\widecaptionwidth=33pc

\def\acknowledgments{\goodbreak\vskip\ackskip
\ifjdraft\large\else\small\fi{\bf Acknowledgments.}%
\hskip6pt\relax\ignorespaces}%

\def\article{\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\small\fi
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\else\small\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\small\fi
\raggedright
\hyphenpenalty=10000
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{
\ifjdraft\large\else\small\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox\vskip8pt\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\vskip3pt\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\vskip3pt\fi
%
\vskip1sp
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\ifdocumentationextraspace
\vskip12pt\fi
\vbox to6pt{\vfill}
%%
%%
\ifjdraft\draftcolumns\else
%% normal abstract
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hbadness5000
\tolerance5000
\hsize=\abstractwidth \raggedright
\abstractsize
%{\abstractnamefont \noindent
%Abstract.}\hskip1em 
\relax %
\abstractfont%
\theabstract%
\vskip\belowabstractskip
}
\begin{figure*}[b]
\vskip-16pt
\end{figure*}
\fi
%% end normal abstract
\ifgalley\galleycolumns
\vglue-14pt
\else
\twocolumns
\global\firstsectiontrue\everypar={\global\firstsectionfalse\everypar={}}
\fi\fi
\ifgalley%% RAS
\skip\footins=18pt
\ifdim\ht\barticle < 2pt
\let\footnoterule\relax
\savefootnotetext{
\footnotesize
\@slug
}
\else
\skip\footins=24pt
\def\footnoterule{\kern -3\p@ \hrule 
width 4pc %%<=== change this dimen to change width of footnote rule line
\kern -2.6\p@}
\savefootnotetext{
\unvbox\barticle
\footnotesize
\@slug
\vspace*{-12pt}
}
\fi
\else
\ifjdraft
\savefootnotetext{\large\slug@comment
%\vskip-24pt
\@sluginfo}
\ifvoid\barticle\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
\begin{figure}[b]
\ifvoid\barticle
\else
\ifdim\ht\barticle>1pt
\vbox{\vskip-6pt}
\hrule width 48pt height .5pt
\vskip1pt
\unvbox\barticle\fi\fi
\small
\@slug 
\end{figure}
%
\fi% end if normal
\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi
\ifdraft\else
\abovedisplayskip 6\p@ \@plus.005\p@ \@minus1\p@
\belowdisplayskip=\abovedisplayskip
\fi
}

\def\jheadline{\hbox to\textwidth{\iftitle%
\hfill\titlepageheadlinefont
{\small\it\journalname}, Volume~\thevolume, Number~\thenumber,
Pages \PutCommaIntoNumber{\the\c@page}\lastpage, \jourdate\hfill%
\else\ifodd\c@page
{\hfill\headlinesize\headtextfont\theauthors:\ \ \thetitle}%
\hfill\llap{\foliofont\PutCommaIntoNumber{\the\c@page}}%
\else\rlap{\foliofont\PutCommaIntoNumber{\the\c@page}}\hfill%
{\headlinesize\headtextfont\theauthors:\ \ \thetitle}%
\hfill\fi\fi}}

\long\def\printtitle{\global\titletrue
%
\vspace*{7pt}
{\hsize=33pc %in specs
\raggedright \hyphenpenalty=10000
\parindent=0pt
\let\thanks\titlethanks
\def\\ {\vskip1sp}%
\Large\baselineskip=\titlebaseline\ifjdraft\LARGE\bf\else\titlefont \fi
\theprinttitle\vrule depth\belowtitleskip
width0pt height 0pt
\vskip1sp}%
\setbox1=\hbox{\let\\ \relax\let\thanks\titlemaketemp \theprinttitle}
\ifjdraft\large\else\normalsize\fi}

\def\thebibliography#1{\vskip1sp
\global\startofbibtrue
\notes
\ifgalley
\ifjdraft
\else
\setonecolboxesandredefine
\ifdim\ht\endcolsavetopinsert>1pt
\unvbox\endcolsavetopinsert\fi
\ifdim\ht\endcolsavebotinsert>1pt
\unvbox\endcolsavebotinsert
\fi\fi\fi
%%
\ifbibtonextpage\global\bibtonextpagefalse\eject\fi
\vskip3pt
\vskip1sp
\section*{References\relax}
\nobreak\bgroup
\ifjdraft\large\else\small\fi%
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt
}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthebibliography{\small
\vskip1sp\spendlist\egroup%
\ifjdraft\else\small\@sluginfo\fi}
\def\@biblabel#1{\relax}

\def\@sluginfo{\ifjdraft\else\vskip\beforeendskip
\hrule width 4pc\fi
\nobreak%
{\ifjdraft\large\else\small\fi
\clubpenalty=3000 \widowpenalty=3000
\parskip=0pt %plus 1pt %% amyh
\@authaddrs\par
\ifjdraft\else
\vskip\beforeendskip
\noindent\@dates\fi}}

\def\@dates{{\small
({\rm Received}\space%
\ifx\@recvdate\@empty\@rcvaccrule\else\@recvdate\fi%
\ifx\@revisedate\@empty\relax\else%
; \space{\rm revised}\space\@revisedate;\\ \fi%
\ifx\@accptdate\@empty\else
\ifx\@revisedate\@empty;\fi\space{\rm accepted}\space%
\@accptdate\fi
\ifx\@pubdate\@empty.\else%
; \space{\rm published}\space\@pubdate.\fi)%
\vskip-2pt}}

\def\@authaddrs{\ifx\authaddr@list\@empty\relax
\else
{\noindent\parindent=.15in 
\ifjdraft\large\else\small\fi\authaddr@list\vskip1sp}
\gdef\authaddr@list{}
\fi}

\def\authoraddress#1{\par
\@temptokena={\ifjdraft\large\else\small\fi\par
\noindent\vrule height 8.5pt width0pt
\hskip.15in\relax#1\vskip1sp}
\@temptokenb=\expandafter{\authaddr@list}
\xdef\authaddr@list{\the\@temptokenb\the\@temptokena}}
\let\authoraddr=\authoraddress

%%%% end RAS

\else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifrog %%  REVIEWS OF GEOPHYSICS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
\def\stylecurrversion{November 3, 2003}
\renewcommand\tablename{TABLE}
\topmargin=-3pc
\textheight=701pt
\aboveabstractskip=27pt
\belowabstractskip=25pt
\belowsectionskip17pt 
\belowsubsectskip=1pt

\ifjdraft
\advance\textheight-.75in 
\footskip=.25in
\fi

\belowtabcaptionskip=9pt

\clubpenalty=10000
\widowpenalty=10000

\def\journalname{\uppercase{REVIEWS OF GEOPHYSICS}}

\def\acknowledgments{\goodbreak\vskip\ackskip
\ifjdraft\large\else\small\baselineskip=11pt\fi%
{\acknowledgfont ACKNOWLEDGMENTS.}%
\acknowledgtextfont\hskip6pt\relax\ignorespaces}%

\def\authorrunninghead#1{\def\theauthors{#1}}
\let\lefthead\authorrunninghead

\typeout{^^J^^J
ROG class option,
\stylecurrversion,^^J
\string\documentclass[rog]{AGU2001}^^J
``REVIEWS OF GEOPHYSICS'', ^^J
Published by American Geophysical Union^^J^^J}

\def\jheadline{\hbox to\textwidth{\iftitle%
\else\ifodd\c@page
{\headlinesize\headtextfont
\thevolume, \thenumber\ / REVIEWS OF GEOPHYSICS
\hfill 
\theauthors:\ \ \thetitle}%
\ \ {\small$\bullet$}\rlap{\ \ \foliofont\PutCommaIntoNumber{\the\c@page}}%
\else% even numbered page
\llap{\foliofont\PutCommaIntoNumber{\the\c@page}\ \ }{\small$\bullet$}\ \ %
{\headlinesize\headtextfont
\theauthors:\ \ \thetitle\hfill\thevolume, 
\thenumber\ / REVIEWS OF GEOPHYSICS}%
\fi\fi}}

\headsep   16pt

\def\jfootline{\hbox to\textwidth{%
\iftitle\global\titlefalse%
\vtop to 12pt{\vss
\hrule height 1pt
\baselineskip=12pt
\vskip5pt
\hbox to\textwidth{\foliofootfont Copyright \cpr@year\ by the American
Geophysical Union.\hfill Reviews of Geophysics, 
\thevolume, \thenumber\ / \footlineitalic \jourdate}
\vskip1sp
\hbox to\textwidth{\hfill\foliofootfont
pages \PutCommaIntoNumber{\the\c@page}\lastpage}
\vskip1sp
\hbox to\textwidth{\foliofootfont
\ifx\thecccline\empty\else
\thecccline\fi
\hfill Paper number \thepaperidnumber
}
\vskip1pt
\hbox to\textwidth{\hfill{$\bullet$}\ %
\foliofootfont\PutCommaIntoNumber{\c@page}\ {$\bullet$}\hfill}
}%
\else\hfill\fi% end iftitle
}% end hbox to textwidth
}

\def\paragraph#1{\vskip1sp
\indent{\savenormalsize\boldmath\paragraphfont #1:\hskip12pt\relax}
\ignorespaces}

\aboveaffilskip=1pt
\long\def\affil#1{%
\vskip\aboveaffilskip
\noindent\hskip\parindent\vtop{\parindent=0pt
\hyphenpenalty=10000
\raggedright
\hsize=.28\textwidth
{\let\thanks\smalltitlethanks\frenchspacing
\ifjdraft\large\else\affilsize\affilfont\fi#1
\vskip1sp}}
\setbox1=\hbox{\let\thanks\titlemaketemp#1}\vskip1sp}

\def\reviewauthors{\vskip\aboveauthorskip\vskip-6pt\bgroup\parindent=0pt
\baselineskip=12pt
\def\\ {\egroup\hbox\bgroup\affilfont\relax}
\everycr={\noalign{\vskip12pt}}
\halign to\hsize\bgroup
\vtop{\ifjdraft\large\bf\else\authorfont\fi
\hbox\bgroup##\egroup}
\tabskip=0pt plus 1fil
&
\vtop{\ifjdraft\large\bf\else\authorfont\fi
\hbox\bgroup##\egroup}
&
\tabskip=0pt plus 1fil
\vtop{\ifjdraft\large\bf\else\authorfont\fi
\hbox\bgroup##\egroup}
\tabskip=0pt
\cr
}


\def\endreviewauthors{\crcr\egroup\egroup}

\long\def\author#1{%
\vskip\aboveauthorskip{
\vskip6pt
\noindent\hskip\parindent\vtop{\hsize=.3\textwidth
\baselineskip=11pt
\raggedright
\hyphenpenalty=10000
\let\thanks\smalltitlethanks
\frenchspacing\ifjdraft\large\bf\else\authorfont\fi\noindent 
#1\vrule width0pt depth\belowauthorskip\hss}
\setbox1=\hbox{\let\\ \relax \let\thanks\titlemaketemp #1}}\vskip-2pt}

\let\authors\author
%% ROG
\def\article{\global\firstpagetrue
\refstepcounter{chapter} % resets fig. etc. counters with
                                      % each article. We never actually
                                      % use the chapter counter.
%%
\global\saveparskip=\parskip 
\gdef\applett{}
\global\c@appendnum=0 \global\appendonfalse
\vskip1sp
%%%%%%
\ifnum\totalaffils>0
\global\setbox\altaffilbox=\vbox{
\ifjdraft\large\else
\savenormalsize\fi
\baselineskip=11pt 
\hyphenpenalty=10000
\raggedright
\doaltaffils}
\fi
%%%%%%
\ifnum\dothanks>0
\dothanks=0
\ifnum\thanksnum>0 \global\thanksnum=0
\global\setbox\thanksbox=\vbox{%
\ifjdraft\large\fi
\parindent=6pt
\hsize=21pc
\loop
\vskip1pt
\ifnum\thanksnum<\thankscounter
\global\advance\thanksnum by1\relax
\vskip1sp
\noindent\vrule height 8.5pt width0pt%
\hskip\parindent
\csname tempthanks\the\thanksnum\endcsname
\vskip1sp
\repeat
}% end \thanksbox
\fi\fi%
 \ifnum\titlethanksnum>0 \global\titlethanksnum=0 
\global\setbox\titlethanksbox=\vbox{%
\ifjdraft\large\else\savenormalsize\fi
\raggedright
\hyphenpenalty=10000
\hsize=\mycolumnwidth
\loop\ifnum\titlethanksnum<\titlethankscounter
 \global\advance\titlethanksnum by1\relax
\vskip1pt
\noindent\hskip\saveparindent$^{\hbox{\footnotesize\dotitlethankssymbol}}$% 
\csname temptitlethanks\the\titlethanksnum\endcsname
 \repeat
 \global\titlethanksnum=0 \global\titlethankscounter=0
\vskip1sp 
}
\fi %% end titlethanksnum
\global\thanksnum=0 \global\thankscounter=0
\global\setbox\barticle=\vbox{
\ifjdraft\large\fi
\hsize=\mycolumnwidth
%
\ifvoid\altaffilbox\else
\unvbox\altaffilbox
\fi
%
\ifvoid\thanksbox\else
\unvbox\thanksbox\fi
%
\ifvoid\titlethanksbox
\else
\unvbox\titlethanksbox\fi
%
\vskip1sp %<===
}
\global\dothanks=0 \global\thanksnum=0
\normalsize
\ifdocumentationextraspace
\vskip12pt\fi
\vbox to6pt{\vfill}
%%
%%
\ifjdraft\draftcolumns\else
%% normal abstract
\ifx\theabstract\empty
\else
\vskip\aboveabstractskip
\twocolumns
{\parindent=\saveparindent
\hbadness5000
\tolerance5000
\abstractsize
%{\normalsize
%\abstractnamefont 
%\noindent
%Abstract.}\hskip1em%
\baselineskip=11pt  plus .01pt %minus 1pt
\abstractfont
\ignorespaces\theabstract

}
\endtwocolumns
\vskip8pt
\hbox to\textwidth{\hfill\vrule width 3.5in height 1pt\hfill}
\vskip\belowabstractskip
\fi
%% end normal abstract
\ifgalley\galleycolumns %%ROG
\vspace*{-17pt}
\advance\@colroom by -48pt %% 
\else
\twocolumns
\advance\@colroom by -60pt %% 
\global\firstsectiontrue\everypar={\global\firstsectionfalse\everypar={}}
\fi\fi
\ifgalley%%ROG
\ifdim\ht\barticle < 2pt
\let\footnoterule\relax
\else
\skip\footins=42pt
\savefootnotetext{\vskip-4pt
\unvbox\barticle}%
\fi
\else
\ifjdraft
\savefootnotetext{\large\slug@comment
\@sluginfo}
\ifvoid\barticle\else
\savefootnotetext{%\vbox
{\vskip-6pt
\unvbox\barticle}}
\fi
\else
\ifdim\ht\barticle>2pt
\begin{figure}[b]
\vskip8pt
\hrule width 48pt height .5pt
\vskip2pt 
\unvbox\barticle\vskip-1pt
\end{figure}
\fi% barticle has some contents
\fi% end if normal
\fi% end ifgalley
\ifjdraft
\global\let\normalsize\large
\global\let\savenormalsize\large \large
\else
\global\let\normalsize\bignormalsize
\bignormalsize
\parskip=0pt %plus .001pt
\fi
%% draft abstract
\ifjdraft
\ifx\theabstract\empty
\else
\newpage
\vskip\aboveabstractskip%\vtop
{\parindent=\saveparindent
\hfuzz=12pt
\spaceskip=4pt
\xspaceskip\spaceskip
\hsize=\abstractwidth 
\advance\hsize by-14pt % to compensate for hfuzz being 12pt, and a bit more
\abstractsize
%{\abstractnamefont 
%\noindent
%Abstract.}\hskip1em 
\relax\ifdim\belowabstractnameskip>0pt %
\vskip\belowabstractnameskip\noindent\fi
\abstractfont
\baselineskip=28pt
\theabstract%
\vskip\belowabstractskip
}
\newpage
\fi\fi
\ifjdraft\else
\baselineskip=12pt plus .01 pt
\fi
}

\def\title#1{\gdef\theprinttitle{\uppercase{#1}}%
\setbox1=\hbox{\let\\ \relax\let\thanks\titlemaketemp #1}%
\printtitle}

%\def\title#1{\gdef\theprinttitle{#1}\printtitle}

\long\def\printtitle{\global\titletrue
\vglue-47pt
{\ifjdraft\hsize=37pc\else \hsize=35pc\fi %in specs 33pc
\raggedright \hyphenpenalty=10000
\parindent=0pt
\let\thanks\titlethanks
\def\\ {\vskip1sp}%
\LARGE
\baselineskip=24pt\ifjdraft\LARGE\bf\else\titlefont \let\it\titleitalicfont\fi
\theprinttitle\vrule depth\belowtitleskip
width0pt height 0pt
\vskip1sp}%
\ifjdraft\large\else\normalsize\fi}

\def\xxsection#1{\vskip\sectskip
\global\sectionontrue
\refstepcounter{section}
\def\@currentlabel{\ifappendon\Alph{section}\else\the\c@section\fi}
\ifsendcontents\else%
        % hack so contents will only be sent for article with \contents
{\let\\ \ 
\addcontentsline{toc}{section}{\string\vskip-1pt
\ifappendon\applett.\fi\the\c@section.\string\ \string\ {%
\string\affilfont\space #1.}}}\fi
% is this intentional?
%\iffirstsection \vspace*{-6pt}\global\firstsectionfalse%
%\else\goodbreak\vskip\sectskip\fi%
\vtop{\hyphenpenalty=10000 
\savenormalsize\baselineskip=12pt
\boldmath %% makes 10pt bold math
\noindent
\sectionfont\ifappendon APPENDIX \Alph{section}\def\xone{#1}\ifx\xone\empty
\else:\fi\else\thesection.\fi\nobreak\hskip8pt\relax%
\uppercase{#1}\vskip\belowsectionskip}%
\nobreak\global\everymath={}%
\everypar={\global\sectiononfalse\everypar={}}\ignorespaces}

\def\ssection#1#2{\vskip\sectskip\global\sectionontrue%
\ifappendon\refstepcounter{section}\fi 
        %% above, so that \appendix \section*{Appendix} sets equation and
        %% figure number to A
\vtop{\hyphenpenalty=10000 
\savenormalsize
\ifjdraft\baselineskip=22pt\else\baselineskip=12pt\fi
\boldmath %% makes 10pt bold math
\noindent\sectionfont\uppercase{#2}\vskip\belowsectionskip}%
\nobreak\everypar={\global\sectiononfalse\everypar={}}}

\def\thebibliography#1{\vskip1sp
\global\startofbibtrue
\notes
\ifgalley
\ifjdraft
\else
\setonecolboxesandredefine
\ifdim\ht\endcolsavetopinsert>1pt
\unvbox\endcolsavetopinsert\fi
\ifdim\ht\endcolsavebotinsert>1pt
\unvbox\endcolsavebotinsert
\fi\fi\fi
%%
\ifbibtonextpage\global\bibtonextpagefalse\eject\fi
\vskip12pt
\section*{References}
\nobreak\bgroup
\ifjdraft\large\else\small\fi%
\list{\null}{\leftmargin .15in\labelwidth\z@\itemsep\z@\parsep\z@
\labelsep\z@\itemindent -.15in\usecounter{enumi}
\itemsep=0pt plus 1pt
}
\def\refpar{\relax}
\def\newblock{\hskip .11em plus .33em minus .07em}
\sloppy\clubpenalty4000\widowpenalty4000
\sfcode`\.=1000\relax}

\def\endthebibliography{
\vskip1sp\spendlist\egroup%
\ifjdraft\else\acknowledgtextfont\baselineskip11pt plus .01pt\@sluginfo\fi}
\def\@biblabel#1{\relax}

\def\authoraddress#1{\par
\@temptokena={\ifjdraft\large\else\small\acknowledgtextfont\fi\par\noindent\vrule height 8.5pt width0pt depth2.5pt
\hskip.15in\relax#1\vskip1sp}
\@temptokenb=\expandafter{\authaddr@list}
\xdef\authaddr@list{\acknowledgtextfont\the\@temptokenb\the\@temptokena}}
\let\authoraddr=\authoraddress

\def\@sluginfo{\ifjdraft\else\vskip\beforeendskip
\hrule width 4pc\fi
\nobreak%
\ifjdraft\large\else\baselineskip=11pt\acknowledgfont\fi
\clubpenalty=3000 \widowpenalty=3000
\parskip=0pt 
\@authaddrs\vskip-.7pt
}

\else%% No journal style has been specified:
\show\NoJournalError
\fi\fi\fi\fi\fi\fi\fi\fi\fi


%%%%%%%%%%%% 
%% 2) Fonts
%%    Computer Modern font information
%%    (PostScript Font information is found in agups.sty)


%%% Font Changes, also made in AGU-PS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%

%%%%%
\def\cmtimes{cmr10 }%% used to test to see if PS fonts are
%% being used. For sample pages and documentation.

%% Computer Modern Default Fonts:
%%
\def\timesroman{cmr10 }
\def\timesitalic{cmti10 }
\def\timesbold{cmbx10 }
\def\timesbolditalic{cmbx10 }
\def\helvetica{cmss10 } 
\def\helveticabold{cmssbx10 } 
\def\helveticaboldoblique{cmssbx10 } 
\def\optima{cmr10 }
\def\optimaoblique{cmti10 }
\def\optimabold{cmbx10 }
\def\optimaboldoblique{cmbx10 } 
\def\smallcaps{cmcsc10 }
\def\courier{cmtt10 }

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%

%%  Fonts For Particular Use:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%

\font\tenbit= \timesbolditalic at 10pt
\font\ninebit=\timesbolditalic at 9pt
\font\eightbit=\timesbolditalic at 8pt

%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
\ifrog %% Reviews of Geophysics
%% headline
\def\headlinesize{\small}
\font\foliofont= \optima at 9pt
\font\headtextfont= \optima at 9pt %running head text
\font\titlepageheadlinefont=\optima at 9pt
\font\cccfont=\optima at 10pt

%% footline
\font\footlinefont=\optima at 9pt
\font\footlineitalic=\optimaoblique at 9pt
\font\foliofootfont= \optima at 9pt

\let\footnotefont\rm 

%% titlepage
\def\titlebaseline{21pt}
\newdimen\titlesize
\titlesize=20pt %% for boldmath in title
\font\titlefont=\optima at 18pt
\font\titleitalicfont=\optimaoblique at 18pt
\font\subtitlefont=\optima at 14pt
\font\specialsectionfont=\optimabold at 16pt
\font\authorfont=\optima at 10pt

\def\affilsize{\footnotesize}
\font\affilfont=\optimaoblique at 10pt
\font\communicatedfont=\optimaoblique at 8pt
\font\receivedfont=\timesroman at 8pt
\font\dedicationfont=cmcsc10 at 8pt
\font\titlethanksfont=\helvetica at 10pt
\font\subtitlethanksfont=\helvetica at 8pt

\def\abstractsize{\bignormalsize}
\font\abstractfont=tir at 10.5pt
\font\xabstractnamefont=\optimabold at 10pt
\def\abstractnamefont{\ifjdraft\large\bf\else\xabstractnamefont\fi}

\font\keywordnamefont=\timesbolditalic at 9pt
\font\keywordfont=\timesbold at 9pt

%% section heads
\font\xsectionfont=\optimabold at 10pt % 
\font\xsubsectionfont=\optimabold at 11pt
\font\xsubsubsectionfont=\optimabold at 11pt %
\font\xparagraphfont=\optimabold at 11pt

\def\sectionfont{\ifjdraft\large\unskip\bf\else\xsectionfont\fi}
\def\subsectionfont{\ifjdraft\large\unskip\bf\else\xsubsectionfont\fi}
\def\subsubsectionfont{\ifjdraft\large\unskip\bf\else\xsubsubsectionfont\fi}
\def\paragraphfont{\ifjdraft\large\unskip\bf\else\xparagraphfont\fi}

%% caption fonts
\gdef\captionnamefont{\ifjdraft\large\bf\else\small\bf\fi}
\gdef\captiontextfont{\ifjdraft\large\else\small\baselineskip=10pt\fi\rm}
\gdef\tablenamefont{\ifjdraft\large\bf\else\small\bf\fi}
\gdef\tabletextfont{\ifjdraft\large\baselineskip=28pt\else%
\small\baselineskip=10pt\fi\bf}
\gdef\tabletextsize{\ifjdraft\large\baselineskip=28pt
\def\arraystretch{2}
\else\footnotesize\fi\rm}
\gdef\tablenotefont{\ifjdraft\large\else\footnotesize\fi\rm}

%%
\font\acknowledgfont=\optimabold at 9pt
\font\acknowledgtextfont=\optima at 9pt
%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%
\else %% Not Reviews of Geophysics, all other styles

%% headline
\def\headlinesize{\small}
\font\foliofont= \timesroman at 10pt
\ifwrr
\font\headtextfont=\timesroman at 8pt
\else
\font\headtextfont= \timesroman at 9pt %running head text
\fi
\font\titlepageheadlinefont=\timesroman at 9pt
\font\cccfont=\timesroman at 7pt

%% footline
\font\footlinefont=\helvetica at 8pt
\font\foliofootfont= \timesroman at 10pt

\let\footnotefont\rm 

%% titlepage
\def\titlebaseline{18pt}
\newdimen\titlesize
\titlesize=18pt %% for boldmath in title
\font\titlefont=\timesbold at 14pt
\font\subtitlefont=\helvetica at 12pt
\font\specialsectionfont=\helvetica at 16pt
\font\authorfont=\timesroman at 11pt

\def\affilsize{\footnotesize}
\font\affilfont=\timesroman at 8pt
\font\communicatedfont=\timesitalic at 8pt
\font\receivedfont=\timesroman at 8pt
\font\dedicationfont=cmcsc10 at 8pt
\font\titlethanksfont=\helvetica at 10pt
\font\subtitlethanksfont=\helvetica at 8pt

\iftec
\font\rmreferencefont=\timesroman at 7.5pt
\font\itreferencefont=\timesitalic at 7.5pt
\font\bfreferencefont=\timesbold at 7.5pt
\font\titlepageheadlinefont= \timesroman at 9pt %running head text
\def\headlinesize{\small}
\font\headtextfont= \timesroman at 9pt %running head text
\def\abstractsize{\normalsize\ifjdraft\large\baselineskip=22pt\fi\relax}
\def\abstractfont{\normalsize\ifjdraft\large\baselineskip=22pt\fi\relax}
\def\abstractnamefont{\ifjdraft\large\bf\else\normalsize\bf\fi}

\else
\ifgrl

%C&G 6/26/01 Note that abstractsize For GRL is small i.e. 9 over 11
%NB not the Case For any other journals as remaining cases set abstractsize=normalsize 
%(i.e. 10/12 unless defined again in code)
\def\abstractsize{\small\ifjdraft\large\baselineskip=22pt
\else\baselineskip=11pt\fi\relax}
\def\abstractfont{\small\ifjdraft\large\baselineskip=22pt
\else\baselineskip=11pt\fi\relax}
\font\xabstractnamefont=\timesbold at 9.5pt
\def\abstractnamefont{\ifjdraft\large\bf\else\xabstractnamefont\fi}

\else
\def\abstractsize{\normalsize\ifjdraft\large\baselineskip=22pt
\else\baselineskip=11pt\fi\relax}
\def\abstractfont{\normalsize\ifjdraft\large\baselineskip=22pt
\else\baselineskip=11pt\fi\relax}
\font\xabstractnamefont=\timesbold at 9.5pt
\def\abstractnamefont{\ifjdraft\large\bf\else\xabstractnamefont\fi}

\fi

\fi%end iftec

\ifpal
\font\rmreferencefont=\timesroman at 7.5pt
\font\itreferencefont=\timesitalic at 7.5pt
\font\bfreferencefont=\timesbold at 7.5pt
\fi

\font\keywordnamefont=\timesbolditalic at 9pt
\font\keywordfont=\timesbold at 9pt

%% section heads
\ifras %% 
\font\xsectionfont=\timesbold at 12pt % 
\else
\font\xsectionfont=\timesbold at 11pt % 
\fi
\font\xsubsectionfont=\timesbold at 9pt
\font\xsubsubsectionfont=\timesbold at 9pt %
\font\xparagraphfont=\timesbold at 9pt

\def\sectionfont{\ifjdraft\large\unskip\bf\else\xsectionfont\fi}
\def\subsectionfont{\ifjdraft\large\unskip\bf\else\xsubsectionfont\fi}
\def\subsubsectionfont{\ifjdraft\large\unskip\bf\else\xsubsubsectionfont\fi}
\def\paragraphfont{\ifjdraft\large\unskip\bf\else\xparagraphfont\fi}

%% caption fonts
\gdef\captionnamefont{\ifjdraft\large\bf\else\small\bf\fi}
\gdef\captiontextfont{\ifjdraft\large\else\small\baselineskip=10pt\fi\rm}
\gdef\tablenamefont{\ifjdraft\large\bf\else\small\bf\fi}
% C&G 6/26/01 changes font Size from small to footnotesize (8/9) For table text
%\gdef\tabletextfont{\ifjdraft\large\baselineskip=24pt\else\small\fi\rm}
\gdef\tabletextfont{\ifjdraft\large\baselineskip=28pt\else\footnotesize\fi\rm}
\gdef\tabletextsize{\ifjdraft\large\baselineskip=28pt
\def\arraystretch{2}
\else\footnotesize\fi\rm}
\gdef\tablenotefont{\ifjdraft\large\else\footnotesize\fi\rm}

\fi %% end test, is Reviews of Geophysics, or All other styles

%% appendix
\let\appendixfont\sectionfont

%% Uppercase appendix caption?
\global\upperappendfalse

%% documentation
\font\elevenbit=\timesbolditalic at 11pt
%%% end of special use fonts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%% Below:
%% Copyright 1993-1999 Patrick W Daly
%% Max-Planck-Institut f\"ur Aeronomie
%% Max-Planck-Str. 2
%% D-37191 Katlenburg-Lindau
%% Germany
%% E-mail: daly@linmpi.mpg.de
\def\ModuleVersion#1[#2]{}
    \ModuleVersion{natbib}
        [1999/05/28 7.0 (PWD)]
\newcommand\NAT@open{[} \newcommand\NAT@close{]}
\newcommand\NAT@sep{;} \newcommand\NAT@cmt{, }
\newcommand\NAT@aysep{,} \newcommand\NAT@yrsep{,~}
\def\NAT@sort{0}
\def\NAT@nmfmt#1{{\NAT@up#1}}
\renewcommand\@cite%
    [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\ \fi
        #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
\providecommand\@firstofone[1]{#1}
\let\citenumfont=\relax
\def\@citex%
  [#1][#2]#3{%
  \NAT@sort@cites{#3}%
  \let\@citea\@empty
  \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
    \@for\@citeb:=\NAT@cite@list\do
    {\edef\@citeb{\expandafter\@firstofone\@citeb}%
     \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
     \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
       {\reset@font\bfseries ?}\NAT@citeundefined
                 \PackageWarning{natbib}%
       {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
     {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
     \NAT@parse{\@citeb}%
     \ifNAT@full\let\NAT@nm\NAT@all@names\else
       \let\NAT@nm\NAT@name\fi
     \ifNAT@swa\ifcase\NAT@ctype
       \if\relax\NAT@date\relax
         \@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\NAT@date\hyper@natlinkend
       \else
         \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
            \ifx\NAT@last@yr\NAT@year
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@exlab
              \hyper@natlinkend
            \else\unskip\
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@date
              \hyper@natlinkend
            \fi
         \else\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
           \NAT@nmfmt{\NAT@nm}%
           \hyper@natlinkbreak{\NAT@aysep\ }{\@citeb\@extra@b@citeb}%
           \NAT@date\hyper@natlinkend
         \fi
       \fi
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@date\hyper@natlinkend
     \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@alias\hyper@natlinkend
     \fi \def\@citea{\NAT@sep\ }%
     \else\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
          \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
        \else
         \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
            \ifx\NAT@last@yr\NAT@year
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@exlab
              \hyper@natlinkend
            \else\unskip\
              \hyper@natlinkstart{\@citeb\@extra@b@citeb}\NAT@date
              \hyper@natlinkend
            \fi
         \else\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
           \NAT@nmfmt{\NAT@nm}%
           \hyper@natlinkbreak{\ \NAT@@open\if*#1*\else#1\ \fi}%
              {\@citeb\@extra@b@citeb}%
           \NAT@date\hyper@natlinkend\fi
        \fi
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@nmfmt{\NAT@nm}\hyper@natlinkend
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@date\hyper@natlinkend
       \or\@citea\hyper@natlinkstart{\@citeb\@extra@b@citeb}%
         \NAT@alias\hyper@natlinkend
       \fi \if\relax\NAT@date\relax\def\@citea{\NAT@sep\ }%
           \else\def\@citea{\NAT@@close\NAT@sep\ }\fi
     \fi
     }}\ifNAT@swa\else\if*#2*\else\NAT@cmt#2\fi
     \if\relax\NAT@date\relax\else\NAT@@close\fi\fi}{#1}{#2}}
\newif\ifNAT@par \NAT@partrue
\newcommand\NAT@@open{\ifNAT@par\NAT@open\fi}
\newcommand\NAT@@close{\ifNAT@par\NAT@close\fi}
\newcommand\NAT@alias{\@ifundefined{al@\@citeb\@extra@b@citeb}{%
  {\reset@font\bfseries(alias?)}\PackageWarning{natbib}
  {Alias undefined for citation `\@citeb'
  \MessageBreak on page \thepage}}{\@nameuse{al@\@citeb\@extra@b@citeb}}}
\let\NAT@up\relax
\newcommand\NAT@Up[1]{{\let\protect\@unexpandable@protect\let~\relax
  \expandafter\NAT@deftemp#1}\expandafter\NAT@UP\NAT@temp}
\newcommand\NAT@deftemp[1]{\xdef\NAT@temp{#1}}
\newcommand\NAT@UP[1]{\let\@tempa\NAT@UP\ifcat a#1\MakeUppercase{#1}%
  \let\@tempa\relax\else#1\fi\@tempa}
\renewcommand\@biblabel[1]{\hfill}
\AtBeginDocument{\ifx\SK@def\@undefined\else
\ifx\SK@cite\@empty\else
  \SK@def\@citex[#1][#2]#3{\SK@\SK@@ref{#3}\SK@@citex[#1][#2]{#3}}\fi
\ifx\SK@citeauthor\@undefined\def\HAR@checkdef{}\else
  \let\citeauthor\SK@citeauthor
  \let\citefullauthor\SK@citefullauthor
  \let\citeyear\SK@citeyear\fi
\fi}
\newif\ifNAT@full\NAT@fullfalse
\newif\ifNAT@swa
\DeclareRobustCommand\citet
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@partrue
     \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\newcommand\NAT@citetp{\@ifnextchar[{\NAT@@citetp}{\NAT@@citetp[]}}
\newcommand\NAT@@citetp{}
\def\NAT@@citetp[#1]{\@ifnextchar[{\@citex[#1]}{\@citex[][#1]}}
\DeclareRobustCommand\citep
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@partrue
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\cite
    {\begingroup\def\NAT@ctype{0}\NAT@partrue\NAT@swatrue
      \@ifstar{\NAT@fulltrue\NAT@cites}{\NAT@fullfalse\NAT@cites}}
\newcommand\NAT@cites{\@ifnextchar [{\NAT@@citetp}{%
     \NAT@swafalse
    \NAT@@citetp[]}}
\DeclareRobustCommand\citealt
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@parfalse
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citealp
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@parfalse
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citeauthor
   {\begingroup\NAT@swafalse\def\NAT@ctype{1}\NAT@parfalse
    \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citet
   {\begingroup\NAT@swafalse\def\NAT@ctype{0}\NAT@partrue
     \let\NAT@up\NAT@Up
     \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citep
   {\begingroup\NAT@swatrue\def\NAT@ctype{0}\NAT@partrue
     \let\NAT@up\NAT@Up
         \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\Citeauthor
   {\begingroup\NAT@swafalse\def\NAT@ctype{1}\NAT@parfalse
     \let\NAT@up\NAT@Up
    \@ifstar{\NAT@fulltrue\NAT@citetp}{\NAT@fullfalse\NAT@citetp}}
\DeclareRobustCommand\citeyear
   {\begingroup\NAT@swafalse\def\NAT@ctype{2}\NAT@parfalse\NAT@citetp}
\DeclareRobustCommand\citeyearpar
   {\begingroup\NAT@swatrue\def\NAT@ctype{2}\NAT@partrue\NAT@citetp}
\newcommand\citetext[1]{\NAT@open#1\NAT@close}
\DeclareRobustCommand\citefullauthor
   {\citeauthor*}
\newcommand\defcitealias[2]{%
   \@ifundefined{al@#1\@extra@b@citeb}{}
   {\PackageWarning{natbib}{Overwriting existing alias for citation #1}}
   \@namedef{al@#1\@extra@b@citeb}{#2}}
\DeclareRobustCommand\citetalias{\begingroup
   \NAT@swafalse\def\NAT@ctype{3}\NAT@parfalse\NAT@citetp}
\DeclareRobustCommand\citepalias{\begingroup
   \NAT@swatrue\def\NAT@ctype{3}\NAT@partrue\NAT@citetp}
\renewcommand\nocite[1]{\@bsphack
  \@for\@citeb:=#1\do{%
    \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \if@filesw\immediate\write\@auxout{\string\citation{\@citeb}}\fi
    \if*\@citeb\else
    \@ifundefined{b@\@citeb\@extra@b@citeb}{%
       \NAT@citeundefined \PackageWarning{natbib}%
       {Citation `\@citeb' undefined}}{}\fi}%
  \@esphack}
\newcommand\NAT@parse[1]{{%
     \let\protect=\@unexpandable@protect\let~\relax
     \let\active@prefix=\@gobble
     \xdef\NAT@temp{\csname b@#1\@extra@b@citeb\endcsname}}%
     \expandafter\NAT@split\NAT@temp
     \expandafter\NAT@parse@date\NAT@date??????@@%
}
\newcommand\NAT@split[4]{%
  \gdef\NAT@num{#1}\gdef\NAT@name{#3}\gdef\NAT@date{#2}%
  \gdef\NAT@all@names{#4}%
  \ifx\NAT@noname\NAT@all@names \gdef\NAT@all@names{#3}\fi}
\newcommand\NAT@parse@date{}
\def\NAT@parse@date#1#2#3#4#5#6@@{%
  \ifnum\the\catcode`#1=11\def\NAT@year{}\def\NAT@exlab{#1}\else
  \ifnum\the\catcode`#2=11\def\NAT@year{#1}\def\NAT@exlab{#2}\else
  \ifnum\the\catcode`#3=11\def\NAT@year{#1#2}\def\NAT@exlab{#3}\else
  \ifnum\the\catcode`#4=11\def\NAT@year{#1#2#3}\def\NAT@exlab{#4}\else
    \def\NAT@year{#1#2#3#4}\def\NAT@exlab{{#5}}\fi\fi\fi\fi}
\newcommand\NAT@ifcmd{\futurelet\NAT@temp\NAT@ifxcmd}
\newcommand\NAT@ifxcmd{\ifx\NAT@temp\relax\else\expandafter\NAT@bare\fi}
\def\NAT@bare#1(#2)#3(@)#4\@nil#5{%
  \stepcounter{NAT@ctr}%
  \NAT@wrout{\arabic {NAT@ctr}}{#2}{#1}{#3}{#5}
}
\newcommand\NAT@wrout[5]{%
\if@filesw
      {\let\protect\noexpand\let~\relax
       \immediate
       \write\@auxout{\string\bibcite{#5}{{#1}{#2}{{#3}}{{#4}}}}}\fi
\ignorespaces}
\def\NAT@noname{{}}
\renewcommand\bibitem{%
  \@ifnextchar[{\@lbibitem}{%
    \stepcounter{NAT@ctr}\@lbibitem[\arabic{NAT@ctr}]}}
\def\@lbibitem[#1]#2{%
  \if\relax\@extra@b@citeb\relax\else
    \@ifundefined{br@#2\@extra@b@citeb}{}{%
     \@namedef{br@#2}{\@nameuse{br@#2\@extra@b@citeb}}}\fi
   \@ifundefined{b@#2\@extra@b@citeb}{\def\NAT@num{}}{\NAT@parse{#2}}%
   \item[\hfil\hyper@natanchorstart{#2\@extra@b@citeb}\@biblabel{\NAT@num}%
    \hyper@natanchorend]%
    \NAT@ifcmd#1(@)(@)\@nil{#2}}
\ifx\SK@lbibitem\@undefined\else
   \let\SK@lbibitem\@lbibitem
   \def\@lbibitem[#1]#2{%
     \SK@lbibitem[#1]{#2}\SK@\SK@@label{#2}\ignorespaces}\fi
\providecommand\bibcite{}
\renewcommand\bibcite[2]{\@ifundefined{b@#1\@extra@binfo}\relax
     {\NAT@citemultiple
      \PackageWarningNoLine{natbib}{Citation `#1' multiply defined}}%
  \global\@namedef{b@#1\@extra@binfo}{#2}}
\AtEndDocument{\NAT@swatrue\let\bibcite\NAT@testdef}
\newcommand\NAT@testdef[2]{%
  \def\NAT@temp{#2}\expandafter \ifx \csname b@#1\@extra@binfo\endcsname
    \NAT@temp \else \ifNAT@swa \NAT@swafalse
       \PackageWarningNoLine{natbib}{Citation(s) may have
          changed.\MessageBreak
          Rerun to get citations correct}\fi\fi}
\newcounter{NAT@ctr}
\let\aguthebib=\thebibliography
\def\thebibliography#1{\aguthebib{#1}}
\providecommand\reset@font{\relax}
\providecommand\bibname{Bibliography}
\providecommand\refname{References}
\newcommand\NAT@citeundefined{\gdef \NAT@undefined {%
    \PackageWarningNoLine{natbib}{There were undefined citations}}}
\let \NAT@undefined \relax
\newcommand\NAT@citemultiple{\gdef \NAT@multiple {%
    \PackageWarningNoLine{natbib}{There were multiply defined citations}}}
\let \NAT@multiple \relax
\AtEndDocument{\NAT@undefined\NAT@multiple}
\providecommand\@mkboth[2]{}
\providecommand\MakeUppercase{\uppercase}
\providecommand{\@extra@b@citeb}{}
\gdef\@extra@binfo{}
\providecommand\hyper@natanchorstart[1]{}
\providecommand\hyper@natanchorend{}
\providecommand\hyper@natlinkstart[1]{}
\providecommand\hyper@natlinkend{}
\providecommand\hyper@natlinkbreak[2]{#1}
\AtBeginDocument{\@ifundefined{bbl@redefine}{}{%
\let\@citex\org@@citex
\bbl@redefine\@citex[#1][#2]#3{%
  \@safe@activestrue\org@@citex[#1][#2]{#3}\@safe@activesfalse}%
\bbl@redefine\NAT@testdef#1#2{%
  \@safe@activestrue\org@NAT@testdef{#1}{#2}\@safe@activesfalse}%
\@ifundefined{org@@lbibitem}{%
\bbl@redefine\@lbibitem[#1]#2{%
  \@safe@activestrue\org@@lbibitem[#1]{#2}\@safe@activesfalse}}{}%
}}
\ifnum\NAT@sort>0
\newcommand\NAT@sort@cites[1]{%
\@tempcntb\m@ne
\let\@celt\delimiter
\def\NAT@num@list{}%
\def\NAT@cite@list{}%
\def\NAT@nonsort@list{}%
\@for \@citeb:=#1\do{\NAT@make@cite@list}%
\edef\NAT@cite@list{\NAT@cite@list\NAT@nonsort@list}%
\edef\NAT@cite@list{\expandafter\NAT@xcom\NAT@cite@list @@}}
\begingroup \catcode`\_=8
\gdef\NAT@make@cite@list{%
     \edef\@citeb{\expandafter\@firstofone\@citeb}%
    \@ifundefined{b@\@citeb\@extra@b@citeb}{\def\NAT@num{A}}%
    {\NAT@parse{\@citeb}}%
      \ifcat _\ifnum\z@<0\NAT@num _\else A\fi
       \@tempcnta\NAT@num \relax
       \ifnum \@tempcnta>\@tempcntb
          \edef\NAT@num@list{\NAT@num@list \@celt{\NAT@num}}%
          \edef\NAT@cite@list{\NAT@cite@list\@citeb,}%
          \@tempcntb\@tempcnta
       \else
          \let\NAT@@cite@list=\NAT@cite@list \def\NAT@cite@list{}%
          \edef\NAT@num@list{\expandafter\NAT@num@celt \NAT@num@list \@gobble @}%
          {\let\@celt=\NAT@celt\NAT@num@list}%
       \fi
    \else
       \edef\NAT@nonsort@list{\NAT@nonsort@list\@citeb,}%
 \fi}
\endgroup
\def\NAT@celt#1{\ifnum #1<\@tempcnta
  \xdef\NAT@cite@list{\NAT@cite@list\expandafter\NAT@nextc\NAT@@cite@list @@}%
  \xdef\NAT@@cite@list{\expandafter\NAT@restc\NAT@@cite@list}%
 \else
  \xdef\NAT@cite@list{\NAT@cite@list\@citeb,\NAT@@cite@list}\let\@celt\@gobble%
 \fi}
\def\NAT@num@celt#1#2{\ifx \@celt #1%
     \ifnum #2<\@tempcnta
        \@celt{#2}%
        \expandafter\expandafter\expandafter\NAT@num@celt
     \else
        \@celt{\number\@tempcnta}\@celt{#2}%
  \fi\fi}
\def\NAT@nextc#1,#2@@{#1,}
\def\NAT@restc#1,#2{#2}
\def\NAT@xcom#1,@@{#1}
\else
 \newcommand\NAT@sort@cites[1]{\edef\NAT@cite@list{#1}}\fi

%% Figbox due to Patrick Daly, orginally in aguplus.cls package

\def\figbox{\@ifstar{\let\agubox\makebox\@figbox}
  {\let\agubox\framebox\@figbox}}
\def\@figbox#1#2#3{\hbox to \hsize{\hfil
  \ifx!#1!\agubox{#3}\else
  \agubox[#1][c]{\ifx!#2!#3\else\@tempdima#2\relax
  \divide\@tempdima by2\relax
  \advance\@tempdima by-\fboxsep \advance\@tempdima by-\fboxrule
  \vrule\@height\@tempdima\@depth\@tempdima\@width\z@
  \vbox to \z@{\vss\hbox{#3}\vss}\fi}\fi\hfil}}

\newcommand{\btx}{\textsc{Bib}\TeX}

%%%%%%%%%%%%%% End Code from Patrick Daly %%%%%%%%%%%%%%

%% Reset default values

\def\resetdefaults{%
\def\theauthors{{\footnotesize !! Please write 
{\tt\string\lefthead\string{\string<AUTHOR NAME(s)\string>\string}}
in file !!}}
\def\thetitle{{\footnotesize!! Please write 
{\tt\string\righthead\string{\string<(Shortened) Article Title\string>%
\string}} in file !!}}
\yearofpublication{???}
\monthofpublication{???}
\volume{???}
\received{}
\revised{}
\accepted{}
\gdef\thededication{}
\gdef\theeditor{}
\global\dothanks=0
\global\thanksnum=0
\global\setbox\barticle=\vbox{}
\gdef\theabstract{}
\gdef\thecommline{}
\global\c@figure=0
\global\c@table=0
\global\appendonfalse\relax
}

\resetdefaults

\def\setlastpagenum#1{\def\lastpage{--#1}}

%% To make tables that continue for several pages
%% take the width of the widest terms in the table.
\def\settabline{\noalign{\ifjdraft\vskip-24pt\else\vskip-2ex\fi}}
\def\settab#1{\setbox0=\hbox{#1}\hbox to\wd0{\hfill}}

\def\indexterms#1{\quad\hbox{\sl {\normalsize I}NDEX 
{\normalsize T}ERMS:}\enskip #1} 

\def\abscitation#1{\hbox{\bf Citation:}{\frenchspacing\enskip #1}}

\endinput
Nov 3, 2003
M Kelly, fixed noindent in subsubsubsection titles and for all sections in rog option

Oct 2, 2003
M Kelly, added "sw" journal option for Space Weather
Disabled cccline for Space Weather. Fonts default (as jgr).

Aug 26, 2003
M Kelly, reinstated \newpage in \endgalley command


May 26, 2003
Added \indexterms and \abscitation

Mar 21, 2003
Changes by M Kelly to make 8 columns galley o/p text equivalent to 4 pages CRC Layout, in length ONLY


July 31, 2002
Made change to @@eqncr so that labelling works right in
eqnarray

July 14, 2002
Made change to eqnarray labelling to prevent it from being
confused with equation labelling.

May 8, 2002
Added \settabline and \settab{} for tables that extend
over more than one page.


March 22, 2002
Built in \setkeys{Gin}{draft=false} to make .eps
print when draft option is chosen.

Feb 19, 2002
Change to \threecolthebibliography (marked `amyh feb 2002')
to make it work right when author uses \bibliography{xxx}

Feb 5, 2002
Made change to captions so that when draft is
used, it is the width of the full text.
Marked: Amy, 2/05/02

November 9, 2001
Maria Kelly 
more changes for draft option
Removed bold style from authornames l-1536
Increased leading for abstract to 28pt also

November 5, 2001
Maria Kelly
Increased baselineskip for draft option to 28pt

October 3, 2001
Improvement in spacing around eqnarray

Sept 27, 2001
New command: aguleftmath, makes first line of math on the
left margin, second line indented by 1 paragraph indent.

Eqnarray aligned on left margin

Mathletters changed so that equation with a,b,c can
follow another equation with a,b,c.

August, 2001
Changes by C&G

%C&G newcommand \published placed below \accepted in the cls file
\def\published#1{\gdef\@pubdate{#1}} \published{}

%C&G - addition For newcommand \published place below the equivalent for accepted
\newskip\abovepublishededskip

%C&G addition to process @pubdate & place \published after the rec, rev, acc dates


August 2, 2001
amyh:

\parskip=0pt will help with page makeup.

August 1, 2001
amyh:

Put change to wide caption width in the GRL conditional area
in case 41pc should not be the default when used in
other journal styles.

-------

6/26/01
CHANGES BY C&G

Reduced the negative elasticity in the \newcommand{\small} font from
 -1pt to -0.25pt to solve leading problems in GRL.
%\baselineskip=11pt plus .001pt minus 0.25pt
But this change now removed to production.sty

Changed \newcommand{\footnotesize} leading from 8/9.5 to 8/9.

Increased width of two-column caption: \widecaptionwidth=35pc to 41pc for GRL

Reduced fontsize from small to footnotesize (8/9) in \tabletextfont
