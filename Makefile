DOCUMENT=Bibliography
BUILD_DIR=build
TEST_DIR=test
TEST_FILE=bib
PDFLATEX_FLAGS= -output-directory=./$(BUILD_DIR) -jobname=$(DOCUMENT)

.bibs := $(shell find bib/ -type f -name '*.bib')
null  :=
space := $(null) $(null)
comma := ,
.bibz := $(subst $(space),$(comma),$(strip $(.bibs)))

texcontent  = "\\\\documentclass{article}\n"
texcontent += "\\\\usepackage[margin=1.0in]{geometry}\n"
texcontent += "\\\\begin{document}\n"
texcontent += "\\\\nocite{*}\n"
texcontent += "\\\\bibliographystyle{test/annote}\n"
texcontent += "\\\\bibliography{$(.bibz)}\n"
texcontent += "\\\\end{document}\n"

all: build
.PHONY: clean
build: 
	echo $(.bibz)
	if [ ! -d "./$(BUILD_DIR)" ]; then mkdir ./$(BUILD_DIR); fi
	@echo $(texcontent) > "./$(TEST_DIR)/$(TEST_FILE).tex"
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
	bibtex ./$(BUILD_DIR)/$(DOCUMENT).aux
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
view: 
	open ./$(BUILD_DIR)/$(DOCUMENT).pdf
clean:
	rm -rf ./$(BUILD_DIR)