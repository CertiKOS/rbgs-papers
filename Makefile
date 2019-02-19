CRUFT = aux pdf bbl blg log snm nav out toc

all: lwcc.pdf slides.pdf compcert.pdf

%.aux: %.tex
	pdflatex $* </dev/null || true

%.bbl: lwcc.bib %.aux
	bibtex $*
	pdflatex $* </dev/null || true

%.pdf: %.tex %.aux
	pdflatex $*

clean:
	$(RM) $(patsubst %,lwcc.%,$(CRUFT))
	$(RM) $(patsubst %,slides.%,$(CRUFT))

lwcc.aux: intro.tex ideas.tex rbgs.tex modsem.tex cklr.tex
lwcc.pdf: lwcc.bbl
compcert.pdf: compcert.bbl
