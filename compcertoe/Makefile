MAIN = compcertoe
LDIFREF = compcertoe-popl25-revised
LDIFOPTS = --packages=amsmath,hyperref,biblatex
SOURCES = acmart.cls ACM-Reference-Format.bst references.bib $(MAIN).tex $(MAIN).bbl Makefile

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
	git show $(LDIFREF):compcertoe/compcertoe.tex >$@.n
	mv $@.n $@

compcertoe-diff.tex: compcertoe.tex compcertoe-ref.tex
	latexdiff $(LDIFOPTS) compcertoe-ref.tex compcertoe.tex > $@.n
	mv $@.n $@

source.zip: $(SOURCES)
	rm -f $@
	zip $@ $(SOURCES)

clean:
	rm -f $(patsubst %,$(MAIN).%,aux aux~ log pdf nav out bbl blg toc pyg)
	rm -rf _minted-$(MAIN) comment.cut
	rm -f compcertoe-ref.tex compcertoe-diff.tex
	rm -f $(patsubst %,$(MAIN)-with-appendix.%,aux aux~ log pdf nav out bbl blg toc pyg)
	rm -f $(patsubst %,$(MAIN)-diff.%,aux aux~ log pdf nav out bbl blg toc pyg)
	rm -rf _minted-$(MAIN)-diff
	rm -rf _minted-$(MAIN)-with-appendix
	rm -f source.zip

.PRECIOUS: %.aux %.aux~
ALWAYS:

