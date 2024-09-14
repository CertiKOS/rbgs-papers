#PANDOPTS = --standalone --mathjax=file:///usr/share/javascript/mathjax/jax/MathJax.js
#PANDOPTS = --standalone --webtex
PANDOPTS = --standalone --css=buttondown.css --webtex=https://latex.codecogs.com/svg.latex?

all: popl2025-response-239.html

%.html: %.txt
	pandoc -f markdown -t html $(PANDOPTS) $< > $@.n
	mv $@.n $@
