CRUFT = aux pdf bbl blg log snm nav out toc

all: rbgs-cal.pdf slides.pdf

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
	$(RM) $(patsubst %,rbgs-cal.%,$(CRUFT)) $(patsubst %,slides.%,$(CRUFT))

rbgs-cal.pdf: rbgs-cal.bbl
