.ONESHELL:

DOC_DIR = src
BUILD_DIR = out

LATEX_SOURCES = $(wildcard $(DOC_DIR)/*.tex)
PDFS = $(patsubst $(DOC_DIR)/%.tex, $(BUILD_DIR)/%.pdf, $(LATEX_SOURCES))

.SILENT: clean
clean:
	rm -rf out
	rm -f src/*.aux
	rm -f src/*.fdb_latexmk
	rm -f src/*.fls
	rm -f src/*.log
	rm -f src/*.nav
	rm -f src/*.out
	rm -f src/*.synctex.gz
	rm -f src/*.snm
	rm -f src/*.toc
	rm -f src/*.vrb
	rm -rf src/_minted-*

pdf: ${PDFS} 

$(BUILD_DIR)/%.pdf: $(DOC_DIR)/%.tex | build_dirs
	rubber --unsafe --pdf --into $(BUILD_DIR) $<

build_dirs:
	mkdir -p $(BUILD_DIR)
	
