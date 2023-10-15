.PHONY: all clean distclean diff

all: proposal.pdf 

clean:
	rm -f *~ *.pdf *.aux *.log *.dvi *.ps *.bbl *.blg
	rm -rf *.tex.old diff

distclean: clean
	rm -f *.tfm *.*pk

%.pdf: %.tex *.tex shao.bib 
	pdflatex $< && (bibtex $(basename $<) || true) && pdflatex $< && pdflatex $<  # NO LONGER works with PSTricks

PARTS := $(patsubst %.tex,%,$(shell echo *.tex))
COMMIT = c9ae005287ef901a44d30bfe96855b85a78d9811

%.tex.old:
	git show $(COMMIT):shf21/$*.tex > $@.n
	mv $@.n $@

diff/macros.tex: macros.tex
	cp $< $@

diff/%.sty: %.sty
	cp $< $@

diff/%.bib: %.bib
	cp $< $@

diff/%.tex: %.tex.old %.tex
	mkdir -p diff
	latexdiff $*.tex.old $*.tex > $@.n
	mv $@.n $@

diff/stamp: $(patsubst %,diff/%.tex,$(PARTS))
	touch diff/stamp

diff/stamp: diff/local.sty diff/lstcoq.sty
diff/stamp: diff/references.bib diff/shao.bib diff/wang.bib

diff: diff/stamp
