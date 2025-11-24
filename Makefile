IMAGE = hugo-hub
PROJECT_DIR = $(shell pwd)

image:
	docker build -t $(IMAGE) .

server: image 
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		-p 1313:1313 \
		$(IMAGE) \
		server --bind 0.0.0.0 --disableFastRender -D

re: clean server

theme:
	git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod || true

build: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		/bin/sh -c "hugo --minify"

clean:
	./scripts/dev.sh

help:
	@echo "Comandos disponíveis:"
	@echo "  make server             - roda o servidor local do Hugo"
	@echo "  make build              - gera o site estático"
	@echo "  make clean              - remove a pasta public e o conteúdo da resources"
	@echo "  make re                 - remove a pasta public e o conteúdo da resources e depois sobe o server novamente"
