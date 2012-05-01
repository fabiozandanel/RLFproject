# Makefile to produce the article.
# LATEX  =  TEXINPUTS=.//: BSTINPUTS=.//: latex
LATEX  =  latex
DVIPS  =  dvips
PSPDF  =  ps2pdf
FIGURES = 

.PRECIOUS: $(FIGURES)

default: CR_and_sims.ps

%.ps :  $(FIGURES) %.tex
	$(LATEX) $*.tex	
	TEXINPUTS=:.// BSTINPUTS=:.// bibtex $*
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(LATEX) $*.tex
	$(DVIPS) -o $*.ps $*.dvi
	$(PSPDF) $*.ps $*.pdf
	make clean

figures/%.eps: figures/%_raw.eps figures/%.tex
	(cd figures; latex $*.tex; \
	dvips -E -o $*.eps $*.dvi; \
	perl -ane '{ s/%%BoundingBox: [-0-9]+/%%BoundingBox: 135/g; print}' $*.eps > tmp.eps; \
	mv tmp.eps $*.eps; \
	rm -f *.dvi *.log *.aux)

clean:
	rm -f *.log *.toc *.aux *.dvi *.bak *.blg *.obj *.out

realclean:
	rm -f *.log *.toc *.aux *.dvi *.obj *.bak *.bbl *.blg *.brf \
              *.ps */*.ps *~ */*~ *.bak */*.bak 

