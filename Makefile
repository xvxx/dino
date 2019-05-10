.PHONY=clean

dino: src/util/upcase.ldpl src/util/digit.ldpl src/registers.ldpl src/opcodes.ldpl src/main.ldpl src/assembler.ldpl src/vm.ldpl src/loader.ldpl
	@ldpl -i=src/util/upcase.ldpl -i=src/util/digit.ldpl -i=src/registers.ldpl -i=src/opcodes.ldpl -i=src/vm.ldpl -i=src/assembler.ldpl -i=src/loader.ldpl src/main.ldpl -o=dino

test: dino
	@./dino run examples/99.dinocode

clean:
	rm -f dino