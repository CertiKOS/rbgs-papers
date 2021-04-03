LATEXDIFFEXCL= \
  picture|DIFnomarkup|tikzpicture|tile|figure|CCSXML|optional

LATEXDIFFOPTS= \
  --config PICTUREENV='(?:$(LATEXDIFFEXCL))[\w\d*@]*' \
  --math-markup=0 \
  --type=CULINECHBAR \

diff: diff-magnus-2.tex diff-magnus-2.pdf

old-%.tex:
	git show >$@.n $*:./rbgs-compcert.tex
	mv $@.n $@

diff-%.tex: old-%.tex rbgs-compcert.tex
	latexdiff >$@.n $(LATEXDIFFOPTS) $< rbgs-compcert.tex
	mv $@.n $@

%.pdf %.aux %.log %.out: %.tex
	pdflatex $*
	pdflatex $*
	pdflatex $*

