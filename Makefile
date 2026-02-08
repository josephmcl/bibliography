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

define texcontent
\\documentclass{article}
\\usepackage[margin=1.0in]{geometry}
\\usepackage{fontspec}
\\setmainfont{XITSMath-Regular.otf}
\\begin{document}
\\nocite{*}
\\bibliographystyle{$(testdir)/annote}
\\bibliography{$(.bibz)}
\\end{document}
endef

export texcontent

all: build

build:
	mkdir -p ./$(builddir) ./$(testdir)
	# Using printf ensures backslashes and newlines are written correctly
	printf "%b" "$$texcontent" > "./$(testdir)/$(genfile).tex"
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex
	$(bc) ./$(builddir)/$(output).aux
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex
	$(cc) $(cflags) ./$(testdir)/$(genfile).tex

clean:
	rm -rf ./$(builddir) ./$(testdir)
