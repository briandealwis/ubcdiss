%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ubcdiss.cls: A LaTeX document class for the revised UBC Thesis Guidelines
%% Originally created by Brian de Alwis.  I developed this separately from
%% Michael McNeil Forbes's ubcthesis.cls/genthesis.class: unlike Forbes' class,
%% this class builds on top of the standard LaTeX book class and should have
%% better compatibility with standard LaTeX packages.
%%
%% FoGS Thesis Specifications and Formatting Requirements
%% <http://www.grad.ubc.ca/students/thesis/index.asp?menu=000,000,000,000>
%% <http://www.grad.ubc.ca/students/thesis/index.asp?menu=005,000,000,000>
%% 
%% Useful documents:
%%  * LaTeX2e for class and package writers
%%    <http://www.latex-project.org/guides/clsguide.pdf>
%%
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.2
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%% This file may only be distributed together with a copy of this
%% program. You may, however, distribute this program without generated
%% files such as this one.
%% 

%% Options that can be specified with the documentclass
%%   balanced         cause text of each page to be centred
%%   fogscopy         special weird formatting as demanded by FoGS
%%   singlespacing    typeset text single spaced
%%   onehalfspacing   typeset text line-and-a-half spacing
%%   doublespacing    typeset text double spaced
%%   draft            draft version only -- doesn't include figures, etc.
%%   10pt             use a 10pt font
%%   11pt             use a 11pt font
%%   12pt             use a 12pt font
%%   oneside          arrange pages for single-sided printing
%%   twoside          insert blank pages as required for double-sided printing

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ubcdiss}[2008/04/06]

% everybody loves calc
\RequirePackage{calc}
\RequirePackage{ifthen}

%% Useful command stolen from Forbes' genthesis.cls
\newcommand{\@addto}[2]{
  \expandafter\let\expandafter\old\csname#1\endcsname
  \toks1=\expandafter{\old}
  \toks2=\expandafter{#2}
  \expandafter\xdef\csname#1\endcsname{\the\toks1 \the\toks2 }
}

% cause the text of each page to be centred; only effective if using twosided
\newif\ifb@l@nced\b@l@ncedfalse
\newif\iffogscopy\fogscopyfalse

\DeclareOption{balanced}{\b@l@ncedtrue}

% fogscopy: default is to use onesided
\DeclareOption{fogscopy}{
    \fogscopytrue%
    \PassOptionsToClass{oneside}{book}}

% Set the body text to the specified spacing.  Users can explictly specify
% \singlespacing, \onehalfspacing, and \doublespacing in their document
% and restore the default with \textspacing.
\newcommand{\textspacing}{\singlespacing}
\DeclareOption{singlespacing}{%
    \typeout{Using single spacing}%
    \renewcommand{\textspacing}{\singlespacing}}
\DeclareOption{onehalfspacing}{%
    \typeout{Using one-and-a-half spacing}%
    \renewcommand{\textspacing}{\onehalfspacing}}
\DeclareOption{doublespacing}{%
    \typeout{Using double spacing}%
    \renewcommand{\textspacing}{\doublespacing}}

\DeclareOption{draft}{\PassOptionsToClass{draft}{book}}
\DeclareOption{10pt}{\PassOptionsToClass{10pt}{book}}
\DeclareOption{11pt}{\PassOptionsToClass{11pt}{book}}
\DeclareOption{12pt}{\PassOptionsToClass{12pt}{book}}
\DeclareOption{oneside}{\PassOptionsToClass{oneside}{book}}
\DeclareOption{twoside}{\PassOptionsToClass{twoside,openright}{book}}

\ExecuteOptions{11pt,oneside}
\InputIfFileExists{ubcdiss.cfg}{}{}
\ProcessOptions\relax

% fix a likely LaTeX bug: seemingly necessary when using book
% comment the following line if it causes errors during build
\newcounter{parentequation}

\LoadClass[letterpaper]{book}
\RequirePackage{setspace}

\ifb@l@nced
    \setlength{\oddsidemargin}{\paperwidth-\textwidth}%
    % TeX's margin parameters are implicitly relative to 1in
    \setlength{\evensidemargin}{0.5\oddsidemargin-1in}%
    \setlength{\oddsidemargin}{\evensidemargin}%
\fi

\RequirePackage{textcase}	% for lower- and upper-casing

% tocbibind: cause list of figures, tables in the toc
% FoGS apparently now require the ToC to be itself listed in the ToC,
% which seems redundant (why would you need to look in the ToC for the ToC?)
\iffogscopy
\RequirePackage{tocbibind}
\else
\RequirePackage[nottoc]{tocbibind}
\fi

% Table of Contents must be labelled "Table of Contents"
\renewcommand{\contentsname}{Table of Contents}

% FoGS wants each line of the ToC/LoT/LoF to have dotted leaders
\RequirePackage{tocloft}        % typesetting of ToC, LoT, & LoF
\renewcommand{\cftchapdotsep}{\cftdotsep}

% From <http://dcwww.camd.dtu.dk/~schiotz/comp/LatexTips/LatexTips.html#figplacement>
% LaTeX per default only allows a part of the top of a text-page
% (70%) to contain figures, and requires at least 20% of a page to
% be text when text and figures share a page. These parameters should
% be set to more reasonable values, for example 85% and 10%.  Be careful
% not to make \floatpagefraction larger than \topfraction, then you
% risk to produce a figure that can neither go on the top of a text
% page, nor on a page by itself.
\renewcommand{\topfraction}{0.85}
\renewcommand{\textfraction}{0.1}
\renewcommand{\floatpagefraction}{0.75}

% Pages should have no running header, and footer should have
% page number at centre
\pagestyle{plain}


%% The title page; we inherit \title and \author, and add many more
\makeatletter

% defaults
\newcommand{\@subtitle}{}
\newcommand{\@previousdegrees}{}
\newcommand{\@degreetitle}{%
    \ClassError{ubcdiss}{Missing degree title}{%
	Specify \protect\degreetitle\space in your dissertation
	metadata section.}
    \emph{missing degree title}}
\newcommand{\@institution}{The University of British Columbia}
\newcommand{\f@culty}{The Faculty of Graduate Studies}
\newcommand{\dep@rtment}{}
\newcommand{\c@mpus}{%
    \ClassError{ubcdiss}{Missing campus name}{%
	Specify \protect\campus\{\}\space in your dissertation
	metadata section.}%
    \emph{missing campus}}
\newcommand{\@subye@r}{
    \ClassError{ubcdiss}{Missing submission year}{%
	Specify \protect\submissionyear\space in your dissertation
	metadata section.}
    \emph{missing submission year}}
\newcommand{\@submonth}{
    \ClassError{ubcdiss}{Missing submission month}{%
	Specify \protect\submissionmonth\space in your dissertation
	metadata section.}
    \emph{missing submission month}}

\newcommand{\subtitle}[1]{\renewcommand{\@subtitle}{#1}}
\newcommand{\previousdegree}[1]{\@addto{@previousdegrees}{#1\par}}
\newcommand{\degreetitle}[1]{\renewcommand{\@degreetitle}{#1}}
\newcommand{\institution}[1]{\renewcommand{\@institution}{#1}}
\newcommand{\faculty}[1]{\renewcommand{\f@culty}{#1}}
\newcommand{\department}[1]{\renewcommand{\dep@rtment}{#1}}
\newcommand{\program}[1]{\department{#1}}
\newcommand{\campus}[1]{\renewcommand{\c@mpus}{#1}}
\newcommand{\submissionyear}[1]{\renewcommand{\@subye@r}{#1}}
\newcommand{\submissionmonth}[1]{\renewcommand{\@submonth}{#1}}

% Try to have some compatibility with Forbes' class
\newcommand{\institutionaddress}[1]{%
    \ClassWarning{ubcdiss}{Ignoring \protect\institutionaddress:
	use \protect\campus\space instead}}
\newcommand{\submitdate}[1]{%
    \ClassWarning{ubcdiss}{Ignoring \protect\submitdate:
	use \protect\submissionyear and \protect\submissionmonth instead}}
\renewcommand{\date}[1]{%
    \ClassWarning{ubcdiss}{Ignoring \protect\date:
	use \protect\submissionyear and \protect\submissionmonth instead}}
\newcommand{\advisor}[1]{%
    \ClassWarning{ubcdiss}{Ignoring \protect\advisor}}
\newcommand{\advisortitle}[1]{%
    \ClassWarning{ubcdiss}{Ignoring \protect\advisortitle}}

\renewcommand{\maketitle}{%
    % For some reason FoGS thinks the title page should be page 1
    % but \frontmatter causes the page count to be reset.  So
    % we do it here, and forbid use of \frontmatter
    \iffogscopy\frontmatter\fi
    \pagestyle{empty}	% in case of \cleardoublepage in end-titlepage
    \begin{titlepage}
    \null\vfil\par
    \begin{center}\setlength{\baselineskip}{20pt}
        {\Large \textbf{\@title}}\\[1em]
	\ifx\@subtitle\empty%
	    \relax
	\else%
	    {\large\bfseries\@subtitle}
	    \vspace{2em}
	\fi

	{\large by}\\[1em]
	{\large \@author}\\[1em]
	\ifx\@previousdegrees\empty\relax\else\@previousdegrees\vspace{2em}\fi

	{\Large \textsc{a thesis submitted in partial fulfillment}}\\
	{\Large \textsc{of the requirements for the degree of}}\\[1em]

	{\large \textbf{\@degreetitle}}\\[1em]
	{\large in}\\[1em]
	{\Large \textsc{\MakeTextLowercase{\f@culty}}}\\
	\ifx\dep@rtment\empty\relax\else(\dep@rtment)\fi
	\vspace{1em}

	{\large \@institution}\\
	{\large (\c@mpus)}\\[1em]
	{\large \@submonth\ \@subye@r}\\[1em]

	{\large \textcopyright\ \@author, \@subye@r}
    \end{center}
    \vfill\null
    \end{titlepage}
    \iffogscopy\setcounter{page}{2}\else\frontmatter\fi
    \pagestyle{plain}
    \renewcommand{\frontmatter}{%
	\ClassError{ubcdiss}{frontmatter should not be used}}
}

