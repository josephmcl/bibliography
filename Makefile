output := Bibliography
builddir := build
testdir := .test
genfile := bib
cc := xelatex
bc := bibtex
cflags := -output-directory=./$(builddir) -jobname=$(output)
.bibs := $(shell find bib/ -type f -name '*.bib')
null :=
space := $(null) $(null)
comma := ,
.bibz := $(subst $(space),$(comma),$(strip $(.bibs)))
texcontent  = "\\documentclass{article}\n"
texcontent += "\\usepackage[margin=1.0in]{geometry}\n"
texcontent += "\\usepackage{fontspec}\n"
texcontent += "\\setmainfont{XITSMath-Regular.otf}\n"
texcontent += "\\begin{document}\n"
texcontent += "\\nocite{*}\n"
texcontent += "\\bibliographystyle{$(testdir)/annote}\n"
texcontent += "\\bibliography{$(.bibz)}\n"
texcontent += "\\end{document}\n"
texcontent := $(subst $(space),$(null),$(strip $(texcontent)))

all: build
.PHONY: clean
build: 
	if [ ! -d "./$(builddir)" ]; then mkdir ./$(builddir); fi
	if [ ! -d "./$(testdir)" ]; then mkdir ./$(testdir); fi
	@echo $(texcontent) > "./$(testdir)/$(genfile).tex"
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex
	$(bc) ./$(builddir)/$(output).aux
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex
view: 
	open ./$(builddir)/$(output).pdf
clean:
	rm -rf ./$(builddir)
