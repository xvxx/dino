.PHONY=clean

dino: src/registers.ldpl src/opcodes.ldpl src/main.ldpl src/assembler.ldpl
	@ldpl -i=src/registers.ldpl -i=src/opcodes.ldpl -i=src/assembler.ldpl src/main.ldpl -o=dino

test: dino
	@./dino bytes examples/99.dino

clean:
	rm -f dino