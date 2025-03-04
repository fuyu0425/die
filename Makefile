MAIN ?= p
DIFF ?= HEAD^
CODE := $(addsuffix .tex,$(filter-out %.tex,$(wildcard code/*)))
FIGS := $(patsubst %.svg,%.pdf,$(wildcard fig/*.svg))
ODGS := $(patsubst %.odg,%.pdf,$(wildcard fig/*.odg))
AIS := $(patsubst %.ai,%.pdf,$(wildcard fig/*.ai))
PLOT := $(patsubst %.gp,%.tex,$(wildcard data/*.gp))
PYPLOT := $(patsubst %.py,%.pdf,$(wildcard pyplot/*.py))
DEPS := rev.tex code/fmt.tex abstract.txt $(CODE) $(FIGS) $(ODGS) $(AIS) $(PLOT) $(PYPLOT)
LTEX := --latex-args="-synctex=1"
# LTEX := --latex-args="-synctex=1 -shell-escape" # for minted version < 3 texlive < 2024
BTEX := --bibtex-args="-min-crossrefs=99"
# SHELL:= $(shell echo $$SHELL)

all: $(DEPS) ## generate a pdf
	@TEXINPUTS="sty:" bin/latexrun $(LTEX) $(BTEX) $(MAIN)
	cp latex.out/$(MAIN).synctex.gz .

submit: $(DEPS) ## proposal function
	@for f in $(wildcard submit-*.tex); do \
		TEXINPUTS="sty:" bin/latexrun $$f; \
	done

diff: $(DEPS) ## generate diff-highlighed pdf
	@bin/diff.sh $(DIFF)

checkout: $(DEPS) ## generate checkout pdf
	@[ "${COMMIT}" ] || ( echo "COMMIT is not set"; exit 1 )
	@ MAIN=${MAIN} bin/checkout.sh $(COMMIT) $(NAME)

help: ## print help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	  | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

rev.tex: FORCE
	@printf '\\gdef\\therev{%s}\n\\gdef\\thedate{%s}\n' \
	   "$(shell git rev-parse --short HEAD)"            \
	   "$(shell git log -1 --format='%cd' --date=format:'%Y-%m-%d %H:%M:%S' HEAD)" > $@

code/%.move.tex: code/%.move ## build highlighted tex code from source code
  pygmentize -P tabsize=4 -P mathescape -x -l ./pygments/lexers/move.py:MoveLexer -f latex $^ | bin/mark.py > $@

code/%.tex: code/% ## build highlighted tex code from source code
	pygmentize -P tabsize=4 -P mathescape -f latex $^ | bin/mark.py > $@

code/fmt.tex: ## generate color table
	pygmentize -f latex -S default > $@

fig/%.pdf: fig/%.svg ## generate pdf from svg
	bin/svg2pdf.sh ${CURDIR}/$^ ${CURDIR}/$@

fig/%.pdf: fig/%.odg ## generate pdf from LibreOffice Draw
	bin/odg2pdf.sh $^ $@

fig/%.pdf: fig/%.ai ## generate pdf from Adobe Illustrator
  bin/ai2pdf.sh $^ $@

pyplot/%.svg: pyplot/%.py ## generate svg from pyplot
	OUT=$@ PYTHONPATH=pyplot/shared python $^

pyplot/%.pdf: pyplot/%.svg ## generate pdf from pyplot svg
	bin/svg2pdf.sh ${CURDIR}/$^ ${CURDIR}/$@

data/%.tex: data/%.gp ## generate plot
	gnuplot $^

data/%.pdf: data/%.py ## generate plot
	python3 $^

draft: $(DEPS) ## generate pdf with a draft info
	@printf '\\newcommand*{\\DRAFT}{}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(LTEX) $(BTEX) $(MAIN)

watermark: $(DEPS) ## generate pdf with a watermark
	@printf '\\usepackage[firstpage]{draftwatermark}' >> rev.tex
	@TEXINPUTS="sty:" bin/latexrun $(LTEX) $(BTEX) $(MAIN)

spell: ## run a spell check
	@for i in *.tex fig/*.tex; do bin/aspell.sh tex $$i; done
	@for i in *.tex; do bin/double.pl $$i; done
	@for i in *.tex; do bin/abbrv.pl  $$i; done
	@bin/hyphens.sh *.tex
	@pdftotext $(MAIN).pdf /dev/stdout | grep '??'
	@for i in fig/*.svg; do bin/aspell.sh svg $$i; done
	@for i in code/*.c; do bin/aspell.sh code $$i; done

bib: all ## print bib used in the paper
	bibexport latex.out/$(MAIN).aux

clean: ## clean up
	@bin/latexrun --clean
	rm -f abstract.txt
	rm -f $(MAIN).synctex.gz

distclean: clean ## clean up completely
	rm -f code/*.tex
	rm -rf _minted_p

abstract.txt: abstract.tex $(MAIN).tex ## generate abstract.txt
	@bin/mkabstract $(MAIN).tex $< | fmt -w72 > $@

text:
	@bin/mktext p.tex

.PHONY: all help FORCE draft clean spell distclean init bib
