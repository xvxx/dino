dino: src/main.ldpl src/assembler.ldpl
	@ldpl -i=src/assembler.ldpl src/main.ldpl -o=dino

test: dino
	@./dino bytes examples/99.dino