CRUFT = aux pdf bbl blg log snm nav out toc

all: lwcc.pdf slides.pdf

%.aux: %.tex
	pdflatex $*

%.bbl: %.bib %.aux
	bibtex $*
	pdflatex $*

%.pdf: %.tex %.aux
	pdflatex $*

clean:
	$(RM) $(patsubst %,lwcc.%,$(CRUFT))
	$(RM) $(patsubst %,slides.%,$(CRUFT))

lwcc.aux: cklr.tex
lwcc.pdf: lwcc.bbl
lwcc.bbl: ACM-Reference-Format.bst
