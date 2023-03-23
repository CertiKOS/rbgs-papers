MAIN = compcertoe

all: $(MAIN).pdf

%.pdf: %.tex dummy
	pdflatex -shell-escape $*

clean:
	rm -f $(patsubst %,$(MAIN).%,aux log pdf nav out bbl blg toc)
	rm -rf _minted-$(MAIN)

dummy:
