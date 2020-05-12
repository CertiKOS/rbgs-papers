CRUFT = aux pdf bbl blg log snm nav out toc

all: thesis.pdf

%.aux: %.tex
	pdflatex $* </dev/null || true

%.bbl: ../references.bib %.aux
	bibtex $*
	pdflatex $* </dev/null || true

%.pdf: %.tex %.aux
	pdflatex $*

%.html: %.mdwn
	markdown $< > $@

clean:
	$(RM) $(patsubst %,thesis.%,$(CRUFT))

thesis.aux: abstract.tex intro.tex rbgs.tex compcerto.tex
thesis.pdf: thesis.bbl
