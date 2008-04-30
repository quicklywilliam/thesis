%
% This file is copyright (C) 2003 Sam Noble. It may be modified so long
% as my name is not removed and the modifier adds his name to the file.
% Redistribution permitted.
%
% 27 Jan 2004	Sam Noble	Removed tocbibind dependency.
% 04 Dec 2001 	Sam Noble	Class file
% 03 Sep 1995	David Perkinson	Title Page
% Acknowledgements Page, David Perkinson & Sam Noble
% May 2005 Patrick Carlisle Table of contents chapter definition
% 2004-2005 Ben Salzberg (BTS) a variety of tweaks here and in the template
%
% Oddities:
%
%   We *ASSUME* that any time \cleardoublepage is called
%  we actually want a blank back side with NO page number/heading
%
%   Minor bug -- seems to be a more general LaTeX thing:
%  If you use \frontmatter \mainmatter without any chapters inbetween
%  be prepared to have the page numbering messed up. Not a big deal,
%  but I'm not sure how to fix it.
%
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{reedthesis}[2004/01/27 The Reed College Thesis Class]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{book}}
\ProcessOptions\relax
\LoadClass{book}
\RequirePackage{fancyhdr}
\RequirePackage{fancybox}
\RequirePackage{ifthen}
\RequirePackage{stmaryrd}
\RequirePackage{xspace}
\RequirePackage{makeidx}
\RequirePackage{exscale}
\RequirePackage{nicefrac} %used to make subsitution operator a diagonal frac
\RequirePackage{hyphenat} %needed in one place to supress hyphenation
\RequirePackage{mparhack} %needed to fix placement of margin pars for defs/refs
\usepackage{setspace}
% This gives us rules below the headers
\AtBeginDocument{%
%WCH Begin doc stuff

	\makeindex
	\definecolor{darkblue}{rgb}{0,0.08,0.45} %link color
	\definecolor{chaptergrey}{rgb}{0,0,0} %chapter number color
	\let\size@chapter\LARGE %sets the chapter title size
	\newtheoremstyle{waystylish}{}{}{}{}{\bfseries}{}{1.0em}{\thmname{#1}\thmnumber{ #2}\thmnote{ #3}} %{space above}{space below}{body font}{Indent amount}{thm head font}{thm head affix}{space after head}{thm head spec}
	\numberwithin{figure}{section}
	\numberwithin{equation}{section}
	\theoremstyle{waystylish}
		\newtheorem{mydef}[equation]{Definition}
		\newtheorem{myexample}[equation]{Example}
	\renewcommand{\c@figure}{\c@equation} %share equation numbering system with figure numbering system
%END WCH stuff
	
  \fancyhf{}
  \fancyhead[LE,RO]{\thepage}
%  \fancyhead[RE]{\slshape \leftmark}
%  \fancyhead[LO]{\slshape \rightmark}
%	The above makes your headers in all caps. If you would like different headers, choose one of the following options (be sure to remove the % symbol from both the right and left headers):
	 \fancyhead[RE]{\slshape \nouppercase \leftmark} % This makes the headers on the RIGHT side pages be italic and use lowercase With Capitals When Specified.
	\fancyhead[LO]{\slshape \nouppercase \rightmark} % This does the same thing to the LEFT side pages
%	or
%	\fancyhead[RE]{\scshape \leftmark} % The RIGHT headers will be in small caps.
%	\fancyhead[LO]{\scshape \rightmark} %  And so will the LEFT headers
  \pagestyle{fancy}

  \let\oldthebibliography=\thebibliography
  \let\endoldthebibliography=\endthebibliography
  \renewenvironment{thebibliography}[1]{
    \oldthebibliography{#1}
    \addcontentsline{toc}{chapter}{\bibname}
  }{\endoldthebibliography}
  
  \let\oldtheindex=\theindex
  \let\endoldtheindex=\endtheindex
  \renewenvironment{theindex}{
    \oldtheindex
    \addcontentsline{toc}{chapter}{\indexname}
  }{\endoldtheindex}
}

% Stolen from book.cls and modified
\let\RToldchapter\chapter
\renewcommand{\chapter}{\if@openright\RTcleardoublepage
		    \else\clearpage\fi
		    \thispagestyle{empty}%
		    \global\@topnum\z@
		    \@afterindentfalse
		    \secdef\@chapter\@schapter}
		    
% Stolen from book.cls PBC 5/12/05
% Using this to actually show "Chapter 1" in TOC instead of "1"
\def\@chapter[#1]#2{\ifnum \c@secnumdepth >\m@ne
                       \if@mainmatter
                         \refstepcounter{chapter}%
                         \typeout{\@chapapp\space\thechapter.}%
                         \addcontentsline{toc}{chapter}%
                         {\@chapapp\space\thechapter:\space#1}%
                       \else
                         \addcontentsline{toc}{chapter}{#1}%
                       \fi
                    \else
                      \addcontentsline{toc}{chapter}{#1}%
                    \fi
                    \chaptermark{#1}%
                    \addtocontents{lof}{\protect\addvspace{10\p@}}%
                    \addtocontents{lot}{\protect\addvspace{10\p@}}%
                    \if@twocolumn
                      \@topnewpage[\@makechapterhead{#2}]%
                    \else
                      \@makechapterhead{#2}%
                      \@afterheading
                    \fi}

\newcommand{\RTcleardoublepage}{
	\clearpage \ifthenelse{\equal{\value{outputmode}}{0}}{}{\if@twoside \ifodd\c@page\else
	\thispagestyle{empty}\hbox{}\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi}}

\let\RToldcleardoublepage\cleardoublepage
\renewcommand{\cleardoublepage}{\RTcleardoublepage}

% adjust margins for binding  (changed 2007-04-24 tgp)
\setlength{\oddsidemargin}{.5in}
\setlength{\evensidemargin}{0in}
\setlength{\textwidth}{6.0in}
\setlength{\textheight}{9.0in}
\setlength\topmargin{0in}
\addtolength\topmargin{-\headheight}
\addtolength\topmargin{-\headsep}

%\setlength{\oddsidemargin}{.6in}
%\setlength{\evensidemargin}{0in}
%\setlength{\textwidth}{5.9in}
%\setlength\topmargin{0in}
%\addtolength\headheight{2.5pt}
%\addtolength\topmargin{-\headheight}
%\addtolength\topmargin{-\headsep}
%\addtolength\textheight{1in}
%\addtolength\textheight{\headheight}
%\addtolength\textheight{\headsep}

\def\division#1{\gdef \@division{#1}}
\def\@division{\@latex@warning@no@line{No \noexpand\division given}}
\def\department#1{\gdef \@department{#1}}
\def\@department{\@latex@warning@no@line{No \noexpand\department given}}
\def\thedivisionof#1{\gdef \@thedivisionof{#1}}
\def\@thedivisionof{The Division of}
\def\approvedforthe#1{\gdef \@approvedforthe{#1}}
\def\@approvedforthe{Division}
\def\advisor#1{\gdef \@advisor{#1}}
\def\@advisor{\@latex@warning@no@line{No \noexpand\advisor given}}
\def\altadvisor#1{\gdef \@altadvisor{#1} \@altadvisortrue}
\global\let\@altadvisor\@empty
\newif\if@altadvisor
\@altadvisorfalse

\renewcommand{\contentsname}{Table of Contents}
\renewcommand{\bibname}{References}

\renewcommand\l@chapter[2]{%
  \ifnum \c@tocdepth >\m@ne
    \addpenalty{-\@highpenalty}%
    \vskip 1.0em \@plus\p@
    \setlength\@tempdima{1.5em}%
    \begingroup
      \parindent \z@ \rightskip \@pnumwidth
      \parfillskip -\@pnumwidth
      \leavevmode \bfseries
      \advance\leftskip\@tempdima
      \hskip -\leftskip
      #1\nobreak\normalfont
      \leaders\hbox{$\m@th \mkern \@dotsep mu\hbox{.}\mkern \@dotsep mu$}\hfill
      \nobreak\hb@xt@\@pnumwidth{\bfseries \hss #2}\par
      \penalty\@highpenalty
    \endgroup
  \fi}

\newenvironment{abstract}{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter[Abstract]{}
  \begin{center}
  {\fontsize{14}{16}\selectfont \bfseries Abstract}
  \end{center}
  \fontsize{12}{14}\selectfont
}{\clearpage \if@restonecol\twocolumn\fi}%

\ifx\pdfoutput\@undefined
  \newcommand{\RTpercent}{\@percentchar\space}
  \AtBeginDvi{\special{!\RTpercent Reed College LaTeX Thesis Class 2001/12/04 SN}} 
  \AtBeginDvi{\special{rawpostscript \RTpercent Reed College LaTeX Thesis Class 2001/12/04 SN}} 
\else
  \AtEndDocument{\pdfinfo{/Creator	(Reed College LaTeX Thesis Class 2001/12/04 SN)}} 
\fi

% I hacked the title page to all be the same font size 
% as requested by the library, BTS 2005

\renewcommand{\maketitle}{%
  {\pagestyle{empty}
  \fontsize{12}{14}\selectfont
  \begin{titlepage}
  \newpage
  \let\footnotesize\small
  \let\footnoterule\relax
  \let \footnote \thanks

  \baselineskip = 1.4\baselineskip
  \setbox0=\hbox{of the Requirements for the Degree}

  \begin{center}
    \setcounter{page}{1}
    \null\vfil
    {\fontsize{12}{14}\selectfont \@title}
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \vfil
    A Thesis \\
    Presented to \\
    \@thedivisionof \ \@division \\
    Reed College
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \vfil
    In Partial Fulfillment \\
    of the Requirements for the Degree \\
    Bachelor of Arts
    \vfil
    \centerline{\hbox to \wd0 {\hbox{}\hrulefill\hbox{}}}
    \bigskip
    \centerline{}
    \bigskip
    {\fontsize{12}{14}\selectfont \lineskip .75em
    \begin{tabular}[t]{c}%
      \@author
    \end{tabular}\par}
    \vskip 1.5em
    {\fontsize{12}{14}\selectfont \@date \par}
  \end{center}\par
  \end{titlepage}

%% Approved for the division page
  \cleardoublepage
  {\fontsize{12}{14}
  \setbox0=\hbox{Approved for the \@approvedforthe}
  \thispagestyle{empty}
  \null\vfil		% just below center of page
  \par\vskip 6cm	% below center, not center
  \centerline{\copy0}	% approved
  \centerline{(\@department)} %major
  \vskip 1cm		%space to sign
  \centerline{\makebox[\wd0][c]{\hrulefill}
	\if@altadvisor \makebox[.5in]{} \makebox[\wd0][c]{\hrulefill} \fi}
  \centerline{\makebox[\wd0][c]{\@advisor}
	\if@altadvisor \makebox[.5in]{} \makebox[\wd0][c]{\@altadvisor} \fi}
  \par\vfil\null}
  \cleardoublepage
  }
}

%%BEGIN WCH ENVIRONMENTS
\newenvironment{example}[1]
{\begin{myexample}\label{#1}}%
{\ $\blacksquare$\end{myexample}}%

\newenvironment{definition}[1]{%
			\cornersize*{8.0pt}\begin{Sbox}%
			\begin{minipage}{.9\textwidth}\begin{mydef}[(#1)]\label{#1}\index{\MakeLowercase{#1}}}%
{\end{mydef}\end{minipage}\end{Sbox}\begin{center}\Ovalbox{\TheSbox}\end{center}}

\newenvironment{insettable_wide}%
	{\begin{figure}[H]
		\begin{center}%
			\cornersize*{8.0pt}\begin{Sbox}%
				\begin{minipage}{.9\textwidth}}%
	{\end{minipage}\end{Sbox}\Ovalbox{\TheSbox}\end{center}\end{figure}}%
	
\newenvironment{insettable}%
	{\begin{figure}[H]
		\begin{center}%
			\cornersize*{8.0pt}\begin{Sbox}%
				\begin{minipage}{.8\textwidth}}%
	{\end{minipage}\end{Sbox}\Ovalbox{\TheSbox}\end{center}\end{figure}}%	
%END WCH ENVIRONMENTS
%%BEGIN WCH COMMANDS
\newcommand{\refex}[1]{\hyperref[#1]{Example \ref{#1}}}
\newcommand{\refsec}[1]{\hyperref[#1]{Section \ref{#1}}}
\newcommand{\reffig}[1]{\hyperref[#1]{Figure \ref{#1}}}
\newcommand{\refdef}[1]{\hyperref[#1]{Definition \ref{#1}}}



\newwrite\@todowrite
\immediate\openout\@todowrite=\jobname.todo

\newcommand{\todo}[1] {%
     \immediate\write\@todowrite{- TOWRITE@P-\thepage L-\the\inputlineno:  \string #1}%
	\marginpar{\tiny{\textbf{TODO:\\ #1}}}%
	}
}
%a note to your reader (the reader's name is the default for the optional argument)
\newcommand{\note}[2][Jim] {%
	\marginpar{\tiny{\textbf{{#1}:\\ #2}}}%
}
\newcommand{\todof}[1] {%
     \immediate\write\@todowrite{- TODO (format):  \string #1}%
} 
\newcommand{\refmargin}[1]{
	\index{#1}\marginpar{\setstretch{.4}\nohyphens{\tiny{{#1}}\\%
	$\hookrightarrow$ \hyperref[#1]{page \pageref{#1}}}}%
}
\newcommand{\refmarginnoindex}[1]{
	\marginpar{\setstretch{.4}\nohyphens{\tiny{{#1}}\\%
	$\hookrightarrow$ \hyperref[#1]{page \pageref{#1}}}}%
}
\newcommand{\inidx}[1]{
	#1\index{#1}%
}


\marginparwidth=4.5em %makes things line up right on even pages

\newcommand{\defmargin}[2][null]{%
	\ifthenelse{\equal{#1}{null}}{\emph{#2}}{\emph{#1}}%
	\label{#2}\index{#2}%
	\marginpar{\cornersize{0.5}\ovalbox{\tiny{\emph{#2}}}}%
}
\newcommand{\defmarginnoindex}[2][null]{%
	\ifthenelse{\equal{#1}{null}}{\emph{#2}}{\emph{#1}}%
	\label{#2}%
	\marginpar{\cornersize{0.5}\ovalbox{\tiny{\emph{#2}}}}%
}
\newcommand{\defmarginwide}[2][null]{%
	\ifthenelse{\equal{#1}{null}}{\emph{#2}}{\emph{#1}}%
	\label{#2}\index{#2}%
	\marginpar{\cornersize*{0.5pt}\begin{Sbox}%
	\begin{minipage}{.8\marginparwidth}\centering\setstretch{.4}\nohyphens{\tiny{\emph{#2}}}\end{minipage}\end{Sbox}\Ovalbox{\TheSbox}}%
}
%%END WCH COMMANDS


