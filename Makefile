test:
	@ldpl -i=is-digit.ldpl -i=upcase.ldpl dino.ldpl -o=dino
	@./dino hi.ldpl