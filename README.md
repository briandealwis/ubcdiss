# `ubcdiss` &ndash; a dissertation template for LaTeX

This distribution provides a community-maintained LaTeX template
for writing a dissertation that conforms with UBC Graduate and Postdoctoral Studies (GPS) specifications. 

This template provides a document class builds on top of the standard
LaTeX _book_ class to ensure much better compatibility with
standard LaTeX packages.  The functionality is implemented using
the commonly available packages found in most LaTeX distributions
such as [MacTeX](http://www.tug.org/mactex/), [MikTeX](https://miktex.org), and [TeXLive](https://www.tug.org/texlive/).
(Give thanks to the countless volunteers who write and maintain these many TeX packages!)

The template has some documentation in [`doc.pdf`](doc.pdf).  This
documentation is itself written using the template, and the content
is found in [`ack.tex`](ack.tex), [`glossary.tex`](glossary.tex),
and [`intro.tex`](intro.tex).  [`diss.tex`](diss.tex) is the
main file but all the content is contained in the other files which
are included from [`diss.tex`](diss.tex) using `\include`.

You will almost certainly need to use additional LaTeX packages for
your dissertation.  There are some pointers in [`diss.tex`](diss.tex)
and [`doc.pdf`](doc.pdf) to useful packages for handling common
problems/requirements.  You may need to manually install these for
your distribution; teTeX in particular seems to ship with a much
smaller package base.

GPS has very strict formatting requirements, and these requirements
may change.  You should review the GPS
[_Thesis Specifications_](http://www.grad.ubc.ca/current-students/dissertation-thesis-preparation/structure-ubc-theses-dissertations)
and [_Formatting Requirements_](http://www.grad.ubc.ca/current-students/dissertation-thesis-preparation/formatting-requirements).  GPS is very lenient with
font choice providing the fonts are used consistently.
Please [open an issue](https://github.com/briandealwis/ubcdiss/issues/new)
if GPS requires you to make formatting or organization changes:
I'll fold those changes into the template for future students.

Please report problems with the
template by [opening an issue on Github](https://github.com/briandealwis/ubcdiss/issues/new).  Before reporting a problem, please ensure that:

 1. you have the latest version of the template (see the abstract
    in [`doc.pdf`](doc.pdf)),
 2. you are using the latest version of your TeX distribution,
 3. your question isn't answered in [the FAQ file](FAQ.md), and
 4. you've exhausted your local LaTeX wizard's help.  Tip: You can
    often find your own wizard by buying beer for a CS grad at Koerner's.

When reporting a problem BE SURE TO INCLUDE:

 1. the version used of this template
 2. details on the operating system and TeX distribution you are using 
    (e.g., Windows XP and MikTeX 2.5, SuSE Linux 10 and its bundled
    installation, MacOS X 10.5.4 and MacTeX 2007),
 3. the log file (likely called `diss.log`).
