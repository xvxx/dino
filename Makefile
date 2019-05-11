.PHONY=clean

LDPL_FILES=$(shell ls -f src/{bytecode,compiler,vm}.ldpl src/{util,compiler,vm}/*.ldpl | sed -e 's/^/-i=/' | tr -s '\n' ' ')
dino: src/*.ldpl src/**/*.ldpl
	ldpl $(LDPL_FILES) src/main.ldpl -o=dino

test: dino
	@./dino run 99.dinocode

clean:
	rm -f dino