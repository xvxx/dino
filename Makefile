.PHONY=clean

LDPL_FILES=$(shell ls -f src/{bytecode,compiler,vm,version}.ldpl src/{util,compiler,vm}/*.ldpl | sed -e 's/^/-i=/' | tr -s '\n' ' ')
dino: src/*.ldpl src/**/*.ldpl
	@make version
	ldpl $(LDPL_FILES) src/main.ldpl -o=dino; true
	@git checkout src/version.ldpl

docs/index.html: docs/index.tpl README.txt dino
	dino run docs/build.ldpl

docs: docs/index.html

release: src/*.ldpl src/**/*.ldpl
	@make version
	ldpl $(LDPL_FILES) src/main.ldpl -o=dino -f=-O3
	strip dino
	@git checkout src/version.ldpl

ldpltest:
	git clone https://github.com/lartu/ldpltest

# remember to escape $ in the text
define VERSIONLDPL
DATA:
$$DINO.VERSION is text
$$DINO.BUILT   is text
PROCEDURE:
store "<v>" in $$DINO.VERSION
store "<b>" in $$DINO.BUILT
endef
export VERSIONLDPL

version:
	@echo "$$VERSIONLDPL" | sed "s/<v>/$(shell git rev-parse --short HEAD | tr -d '\n')/g" | sed "s/<b>/$(shell date +%Y-%m-%d | tr -d '\n')/g" > src/version.ldpl

clean:
	rm -f dino
