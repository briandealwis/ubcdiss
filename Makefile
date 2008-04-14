          NAME1 = template
       PRODUCT1 = $(NAME1).pdf
     TEXSOURCE1 = $(NAME1).tex \
		    abstract.tex ack.tex glossary.tex intro.tex conclusions.tex 
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
BUILTPDFFIGURES = \
		    ${PNGFIGURES:C/\.png/.pdf/g} \
		    ${GIFFIGURES:C/\.gif/.pdf/g} \
		    ${SVGFIGURES:C/\.svg/.pdf/g}

all: $(NAME1)

$(NAME1).pdf: $(TEXSOURCE1) $(BBL1) $(PDFFIGURES)

$(NAME1).dvi: $(TEXSOURCE1) $(BBL1) $(EPSFIGURES)
$(NAME1).bbl: $(TEXSOURCE1) $(BIBINPUTS) $(PDFFIGURES)

#$(NAME2).pdf: $(TEXSOURCE2) $(BBL2) $(BUILTPDFFIGURES)
#$(NAME2).dvi: $(TEXSOURCE2) $(BBL2) $(BUILTEPSFIGURES)
#$(NAME2).bbl: $(TEXSOURCE2) $(BIBINPUTS) $(BUILTEPSFIGURES) $(BUILTPDFFIGURES)

clean:
	rm -f ${BUILDPDFFIGURES} $

# configuration issues
.SUFFIXES: .tex .pdf .bbl

       PDFLATEX ?= pdflatex
	 BIBTEX ?= bibtex
        XELATEX ?= xelatex 
          LATEX ?= latex
       BIBLATEX ?= $(PDFLATEXENGINE)
         BIBTEX ?= bibtex -min-crossref=1000

.tex.pdf:
	$(PDFLATEX) $(LATEXFLAGS) $<
	@while egrep -q 'LaTeX Warning:.*Rerun|Rerun to get citations correct' $*.log; do \
	       echo $(PDFLATEX) $<; \
	      $(PDFLATEX) $(LATEXFLAGS) $< ||
	      exit $?; \
	done

.tex.bbl: 
	$(BIBLATEX) $(LATEXFLAGS) $<
	$(BIBTEX) $*
	$(RM) $*.aux $*.dvi $*.pdf

