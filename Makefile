IMAGE = hugo-hub
PROJECT_DIR = $(shell pwd)
USER_ID = $(shell id -u)
GROUP_ID = $(shell id -g)

image:
	docker build \
		--build-arg UID=$(USER_ID) \
		--build-arg GID=$(GROUP_ID) \
		-t $(IMAGE) .

server: image
	docker run --rm -it \
		-u $(USER_ID):$(GROUP_ID) \
		-v $(PROJECT_DIR):/src \
		-p 1313:1313 \
		$(IMAGE)

re: clean server

theme:
	git submodule add https://github.com/adityatelange/hugo-PaperMod themes/PaperMod || true

build: image
	docker run --rm -it \
		-u $(USER_ID):$(GROUP_ID) \
		-v $(PROJECT_DIR):/src \
		$(IMAGE) \
		hugo --minify

clean:
	./scripts/dev.sh

help:
	@echo "Comandos disponíveis:"
	@echo "  make server   - roda o servidor local do Hugo"
	@echo "  make build    - gera o site estático"
	@echo "  make clean    - limpa public/ e resources/"
	@echo "  make re       - limpa tudo e sobe o server novamente"
