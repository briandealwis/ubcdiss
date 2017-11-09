          NAME1 = diss
       PRODUCT1 = $(NAME1).pdf
     TEXSOURCE1 = $(NAME1).tex \
		    abstract.tex ack.tex glossary.tex intro.tex laysummary.tex \
		    ubcdiss.cls
           BBL1 = $(NAME1).bbl

#         NAME2 =
#      PRODUCT2 = $(NAME2).pdf
#    TEXSOURCE2 = $(NAME2).tex 
#          BBL2 = $(NAME2).bbl

      BIBINPUTS = biblio.bib

     PDFFIGURES = $(BUILTPDFFIGURES) ${PNGFIGURES}
     PNGFIGURES = 
     GIFFIGURES = 
     SVGFIGURES = 
# Following is for Berkeley Make syntax:
#BUILTPDFFIGURES = \
#		    ${PNGFIGURES:C/\.png/.pdf/g} \
#		    ${GIFFIGURES:C/\.gif/.pdf/g} \
#		    ${SVGFIGURES:C/\.svg/.pdf/g}

all: doc.pdf $(PRODUCT1)

$(NAME1).pdf: $(TEXSOURCE1) $(BBL1) $(PDFFIGURES)
$(NAME1).dvi: $(TEXSOURCE1) $(BBL1) $(EPSFIGURES)
$(NAME1).bbl: $(TEXSOURCE1) $(BIBINPUTS) $(PDFFIGURES)

#$(NAME2).pdf: $(TEXSOURCE2) $(BBL2) $(BUILTPDFFIGURES)
#$(NAME2).dvi: $(TEXSOURCE2) $(BBL2) $(BUILTEPSFIGURES)
#$(NAME2).bbl: $(TEXSOURCE2) $(BIBINPUTS) $(BUILTEPSFIGURES) $(BUILTPDFFIGURES)

clean:
	$(RM) ${BUILTPDFFIGURES} $(NAME1).aux $(NAME1).dvi \
	    $(NAME1).log $(NAME1).blg $(NAME1).bbl $(NAME1).out \
	    $(NAME1).toc $(NAME1).lof $(NAME1).lot $(NAME1).brf \
            *.aux

# configuration issues
.SUFFIXES: .tex .pdf .bbl

PDFLATEX=	pdflatex
BIBTEX=		bibtex
XELATEX=	xelatex 
LATEX=		latex
BIBLATEX=	$(PDFLATEX)
BIBTEX=		bibtex -min-crossref=1000
RM=		rm -f
MV=		mv
CP=		cp -p

.tex.pdf:
	$(PDFLATEX) $(LATEXFLAGS) $<
	@while egrep -q 'LaTeX Warning:.*Rerun|Rerun to get' $*.log; do \
	       echo $(PDFLATEX) $<; \
	      $(PDFLATEX) $(LATEXFLAGS) $< || exit $$?; \
	done

.tex.bbl: 
	$(BIBLATEX) $(LATEXFLAGS) $<
	$(BIBTEX) $*
	$(RM) $*.aux $*.dvi $*.pdf

doc.pdf: diss.pdf
	$(CP) diss.pdf doc.pdf
