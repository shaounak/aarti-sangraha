.PHONY: all clean lint setup

LATEX ?= xelatex

all: example.pdf

setup:
	./bin/setup-latex-env.sh

clean:
	latexmk -C

lint:
	npx eclint check *.cls *.sty *.tex lib/

%.pdf: %.tex
	latexmk --interaction=nonstopmode --pdf --pdflatex=$(LATEX) $<
