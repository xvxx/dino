.PHONY=clean

LDPL_FILES=$(shell ls -f src/{bytecode,compiler,vm,version}.ldpl src/{util,compiler,vm}/*.ldpl | sed -e 's/^/-i=/' | tr -s '\n' ' ')
dino: src/*.ldpl src/**/*.ldpl
	make version
	ldpl $(LDPL_FILES) src/main.ldpl -o=dino
	git checkout src/version.ldpl

test: dino
	@./dino run 99.dinocode

# remember to escape $ in the text
define VERSIONLDPL
DATA:
$$DINO.VERSION is text
PROCEDURE:
store "<v>" in $$DINO.VERSION
endef
export VERSIONLDPL

version:
	echo "$$VERSIONLDPL" | sed "s/<v>/$(shell git rev-parse --short HEAD | tr -d '\n')/g" > src/version.ldpl

clean:
	rm -f dino
	rm -f src/version.ldpl