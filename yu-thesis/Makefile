CRUFT = aux pdf bbl blg log snm nav out toc

all: thesis.pdf

%.aux: %.tex
	pdflatex -shell-escape $* </dev/null || true

%.bbl: references.bib %.aux
	bibtex $*
	pdflatex -shell-escape $* </dev/null || true

%.pdf: %.tex %.aux
	pdflatex -shell-escape $*

clean:
	$(RM) $(patsubst %,thesis.%,$(CRUFT)) 
	
thesis.pdf: thesis.bbl
