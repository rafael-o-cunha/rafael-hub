# Image Hugo Extended
HUGO_IMAGE = klakegg/hugo:ext-alpine
PROJECT_DIR = $(shell pwd)

# ============ COMMANDS ============ #

## Iniciar servidor local
server:
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		-p 1313:1313 \
		$(HUGO_IMAGE) \
		server --bind 0.0.0.0 -D

## Create a new Hugo site in the current directory
new-site:
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(HUGO_IMAGE) \
		new site --force .

## Add PaperMod theme as submodule
theme:
	git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod || true

## Create a new blog post: make new-post name=meu-post
new-post:
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(HUGO_IMAGE) \
		new posts/$(name).md

## Create a new page: make new-page name=sobre
new-page:
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(HUGO_IMAGE) \
		new $(name)/_index.md

## Build static site (output in /public)
build:
	docker run --rm -it \
		-v $(PROJECT_DIR):/src \
		$(HUGO_IMAGE) \
		--minify

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
