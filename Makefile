.PHONY=clean

dino: src/*.ldpl src/**/*.ldpl
	@INCLUDES=$(ls -f src/{util,compiler,vm}/*.ldpl src/{compiler,vm}.ldpl | sed -e 's/^/-i=/' | tr -s '\n' ' ')
	@ldpl $(INCLUDES) src/main.ldpl -o=dino

test: dino
	@./dino run 99.dinocode

clean:
	rm -f dino