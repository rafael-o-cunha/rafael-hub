# Image Hugo Extended
IMAGE = hugo-hub
PROJECT_DIR = $(shell pwd)

# ============ COMMANDS ============ #

## Build da imagem local com base no Dockerfile
image:
	docker build -t $(IMAGE) .

## Iniciar servidor local
server: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		-p 1313:1313 \
		$(IMAGE)

## Create a new Hugo site in the current directory
new-site: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		hugo new site --force .

## Add PaperMod theme as submodule
theme:
	git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod || true

## Create a new blog post: make new-post name=meu-post
new-post: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		hugo new posts/$(name).md

## Create a new page: make new-page name=sobre
new-page: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		hugo new $(name)/_index.md

## Build static site (output in /public)
build: image
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		hugo --minify

## Remove generated /public
clean:
	rm -rf public

## Help
help:
	@echo "Comandos disponíveis:"
	@echo "  make server             - roda o servidor local do Hugo"
	@echo "  make new-post name=xxx  - cria um novo post"
	@echo "  make new-page name=xxx  - cria uma nova página"
	@echo "  make build              - gera o site estático"
	@echo "  make clean              - remove a pasta public"
