dino: src/main.ldpl
	@ldpl src/main.ldpl -o=dino

test: dino
	@./dino bytes examples/99.dino