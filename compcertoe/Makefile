MAIN = compcertoe

$(MAIN).pdf: $(MAIN).bbl
compcertoe-with-appendix.pdf: compcertoe-with-appendix.bbl
compcertoe-with-appendix.aux: compcertoe.tex
compcertoe-diff.pdf: compcertoe-diff.bbl
compcertoe-diff.aux: compcertoe-diff.tex

%.bbl: ALWAYS
	pdflatex -shell-escape $*
	bibtex $*

%.aux: %.tex
	pdflatex -shell-escape $*

%.aux~: %.aux
	if cmp -s $< $@; then \
	  touch $@; \
	else \
	  cp $< $@; \
	  pdflatex -shell-escape $*; \
	fi

%.pdf: %.aux~
	# The target $@ should be up-to-date, but be sure
	# to run 'make $*.bbl' when citing new papers.

compcertoe-ref.tex:
	git show compcertoe-popl25-submitted:compcertoe/compcertoe.tex >$@.n
	mv $@.n $@

compcertoe-diff.tex: compcertoe.tex compcertoe-ref.tex
	latexdiff compcertoe-ref.tex compcertoe.tex > $@.n
	mv $@.n $@

clean:
	rm -f $(patsubst %,$(MAIN).%,aux aux~ log pdf nav out bbl blg toc pyg)
	rm -f compcertoe-ref.tex
	rm -rf _minted-$(MAIN)

.PRECIOUS: %.aux %.aux~
ALWAYS:

