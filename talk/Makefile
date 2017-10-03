# Makefile for Docker containers management/automation
# Marco Matos  <marco@marco.ae>

NAME = reg.your.registry.com:5000/talk
TIMESTAMP:= `date +%Y`-`date +%m`-`date +%d`-`date +%s`
BRANCH:= $$(git branch)
REVISION:= $$(git rev-parse HEAD)
USER:= $$(git config user.name)
VERSION:= latest
CONTAINER_NAME:= talk


.PHONY: all build run dockerfile

all: build

build:
	docker build -t $(NAME):$(VERSION) --rm .

run:
	@echo 'running TALK'
	docker run -d --name talk -p 2222:22 talk

dockerfile:
	@echo 'overwrite current Dockerfile with the development file contents'
	cat talk.Dockerfile > Dockerfile
	@echo 'now you just need to run make build'

kill:
	docker stop $(CONTAINER_NAME)
	docker rm $(CONTAINER_NAME)
