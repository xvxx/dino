dino: dino.ldpl upcase.ldpl is-digit.ldpl 
	@ldpl -i=is-digit.ldpl -i=upcase.ldpl dino.ldpl -o=dino

test:
	@ldpl src/main.ldpl -o=dino
	@./dino examples/99.dino