.PHONY: all clean distclean

all: proposal.pdf 

clean:
	rm -f *~ *.pdf *.aux *.log *.dvi *.ps *.bbl *.blg

distclean: clean
	rm -f *.tfm *.*pk

%.pdf: %.tex *.tex shao.bib 
	pdflatex $< && (bibtex $(basename $<) || true) && pdflatex $< && pdflatex $<  # NO LONGER works with PSTricks

