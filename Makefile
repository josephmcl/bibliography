DOCUMENT=Bibliography
BUILD_DIR=build
TEST_DIR=test
TEST_FILE=bib
PDFLATEX_FLAGS= -output-directory=./$(BUILD_DIR) -jobname=$(DOCUMENT)
all: build
.PHONY: clean
build:  bib/default.bib
	if [ ! -d "./$(BUILD_DIR)" ]; then mkdir ./$(BUILD_DIR); fi
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
	bibtex ./$(BUILD_DIR)/$(DOCUMENT).aux
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
	pdflatex $(PDFLATEX_FLAGS) ./$(TEST_DIR)/$(TEST_FILE).tex
view: 
	open ./$(BUILD_DIR)/$(DOCUMENT).pdf
clean:
	rm -rf ./$(BUILD_DIR)