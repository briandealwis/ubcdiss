%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ubcdiss.cls: A LaTeX document class for the revised UBC Thesis Guidelines
%% Originally created by Brian de Alwis.  I developed this separately from
%% Michael McNeil Forbes's ubcthesis.cls/genthesis.class: unlike Forbes' class,
%% this class builds on top of the standard LaTeX book class and should have
%% better compatibility with standard LaTeX packages.
%%
%% GPS Thesis Specifications and Formatting Requirements
%% <https://www.grad.ubc.ca/current-students/dissertation-thesis-preparation/structure-ubc-theses-dissertations>
%% <https://www.grad.ubc.ca/current-students/dissertation-thesis-preparation/formatting-requirements>
%% 
%% Useful documents:
%%  * LaTeX2e for class and package writers
%%    <http://www.latex-project.org/guides/clsguide.pdf>
%%
%% This package, and all its contents, are placed in the public domain.
%% 

%% Options that can be specified with the documentclass
%%   balanced         cause text of each page to be centred
%%   gpscopy          special weird formatting as demanded by GPS
%%                    (aka fogscopy from when GPS was the Faculty of
%%                    Graduate Studies)
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
\ProvidesClass{ubcdiss}[2018/05/18]

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

% balanced: cause the text of each page to be centred; only effective
% if using twosided
\newif\ifb@l@nced\b@l@ncedfalse
\DeclareOption{balanced}{\b@l@ncedtrue}

% gpscopy: default is to use onesided
\newif\ifgpscopy\gpscopyfalse
\DeclareOption{gpscopy}{
    \gpscopytrue%
    \PassOptionsToClass{oneside}{book}}
% fogscopy kept for backwards compatibility
\def\iffogscopy{\ifgpscopy}
\DeclareOption{fogscopy}{
    \ClassWarning{ubcdiss}{‘\CurrentOption’ now called 'gpscopy'}
    \gpscopytrue%
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
% GPS apparently now require the ToC to be itself listed in the ToC,
% which seems redundant (why would you look for the ToC in the ToC?)
\ifgpscopy
\RequirePackage{tocbibind}
\else
\RequirePackage[nottoc]{tocbibind}
\fi

\ifgpscopy
% GPS requires the Table of Contents to be labelled
% "Table of Contents" and not "Contents"
\renewcommand{\contentsname}{Table of Contents}

% GPS wants each line of the ToC/LoT/LoF to have dotted leaders.
% Ugh, looks like Word
\RequirePackage[titles]{tocloft}        % typesetting of ToC, LoT, & LoF
\renewcommand{\cftpartdotsep}{\cftdotsep}
\renewcommand{\cftchapdotsep}{\cftdotsep}

%% GPS now wants items in the LoF and LoT to be preceded by the entry type
%% (e.g., "Figure 1.1  blah blah") (via Brett Eaton, 2010/04/16)
%% We have two options for typesetting such entries:
%%
%%   Option 1: The first option is to cause all lines of the entry
%%             to be indented by the the width of the label.  This
%%             is a bit undesirable as the width of the label depends
%%             on the label itself, and "Figure" and "Table" have
%%             different widths.
%%
%%   Option 2: The second option is to typeset the entries using a
%%      hanging indent.  Thus only the first line of the entries are
%%      different between pages, and subsequent lines are the same.
%%
%% Typographic purists may prefer using Option 2.  But we've chosen
%% Option 1 as we cannot change the spacing between the label and text
%% to be sufficiently snug.  And people should provide shortened titles
%% for their entries anyways.
%
% set the initial indents to 0: we'll need all the space we can get
\setlength{\cfttabindent}{0em}\setlength{\cftfigindent}{0em}
\newlength{\@figprefixlen}
\renewcommand{\cfttabpresnum}{Table }
\settowidth{\@figprefixlen}{\cfttabfont\cfttabpresnum}
\newlength{\@tabprefixlen}
\renewcommand{\cftfigpresnum}{Figure }
\settowidth{\@tabprefixlen}{\cftfigfont\cftfigpresnum}
%%
%% OPTION 1: maintain a consistent indentation for all lines of an entry
%%           (comment out the following lines if you choose Option 2)
\addtolength{\cfttabnumwidth}{\@figprefixlen}
\addtolength{\cftfignumwidth}{\@tabprefixlen}
%%
%% OPTION 2: typeset subsequent lines in an entry with a hanging indent
%%   (comment out the following lines if you choose Option 1)
% It's a bit unfortunate that tocloft doesn't use a macro for
% typesetting the field; it'd be nice to make the text a bit more
% snug to the entry number.
%\renewcommand{\cfttabaftersnumb}{\makebox[\@figprefixlen][l]{}}
%\renewcommand{\cftfigaftersnumb}{\makebox[\@tabprefixlen][l]{}}

\fi  % gpscopy

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
\newcommand*{\@subtitle}{}
\newcommand*{\@previousdegrees}{}
\newcommand{\@degreetitle}{%
    \ClassError{ubcdiss}{Missing degree title}{%
	Specify \protect\degreetitle\space in your dissertation
	metadata section.}
    \emph{missing degree title}}
\newcommand{\@institution}{The University of British Columbia}
\newcommand{\f@culty}{Graduate and Postdoctoral Studies}
\newcommand*{\dep@rtment}{}
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
    % For some reason GPS thinks the title page should be page 1
    % but \frontmatter causes the page count to be reset.  So
    % we do it here, and forbid use of \frontmatter
    \ifgpscopy\frontmatter\fi
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
    \ifgpscopy\setcounter{page}{2}\else\frontmatter\fi
    \pagestyle{plain}
    \renewcommand{\frontmatter}{%
	\ClassError{ubcdiss}{frontmatter should not be used}}
}

\newcommand*{\ex@miners}{}
\newcommand*{\@supervisory}{}
\newcommand{\examiningcommittee}[2]{\@addto{ex@miners}{%
    \par\medskip\noindent#1\\\emph{#2}}}
    %\noindent#1\\\emph{#2}\\[0.75em]}}
\newcommand{\supervisorycommittee}[2]{\@addto{@supervisory}{%
    \par\medskip\noindent#1\\\emph{#2}}}
    %\noindent#1\\\emph{#2}\\[0.75em]}}
\newcommand{\makecommitteepage}{%
    \begin{singlespace}
    \noindent The following individuals certify that they have read,
    and recommend to the Faculty of Graduate and Postdoctoral Studies
    for acceptance, the thesis entitled:\\[1em]
        {\large \textbf{\@title}}\\[1em]
    submitted by 
	\textbf{\@author}
    in partial fulfillment of the requirements for the degree of
	\textbf{\@degreetitle}
    in
	\textbf{\ifx\dep@rtment\empty\f@culty\else\dep@rtment\fi}.%
    \par\bigskip%
    \noindent\textbf{Examining Committee:}%
    \ex@miners%
    \ifx\@supervisory\empty\relax\else%
        \par\bigskip%
        \noindent\textbf{Additional Supervisory Committee Members:}%
        \@supervisory\fi%
    \end{singlespace}
    \cleardoublepage
}

