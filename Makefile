dino: dino.ldpl upcase.ldpl is-digit.ldpl 
	@ldpl -i=is-digit.ldpl -i=upcase.ldpl dino.ldpl -o=dino

test:
	@ldpl -i=is-digit.ldpl -i=upcase.ldpl dino.ldpl -o=dino
	@./dino while.ldpl