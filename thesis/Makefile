CRUFT = aux pdf bbl blg log snm nav out toc
EPSFIGS = element hcomp vcomp overview

all: thesis.pdf slides.pdf

%.eps: %.dia
	dia -e $@ $<

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
	$(RM) $(patsubst %,thesis.%,$(CRUFT)) \
              $(patsubst %,slides.%,$(CRUFT)) \
              $(patsubst %,fig/%.eps,$(EPSFIGS))

thesis.pdf: thesis.bbl $(patsubst %,fig/%.eps,$(EPSFIGS))
