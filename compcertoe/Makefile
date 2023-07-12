MAIN = compcertoe

$(MAIN).pdf: $(MAIN).bbl
compcertoe-with-appendix.pdf: compcertoe-with-appendix.bbl

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

clean:
	rm -f $(patsubst %,$(MAIN).%,aux aux~ log pdf nav out bbl blg toc pyg)
	rm -rf _minted-$(MAIN)

.PRECIOUS: %.aux %.aux~
ALWAYS:

