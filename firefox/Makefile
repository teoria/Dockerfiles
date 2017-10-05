# Makefile >> Mozilla Firefox on Docker
# Marco Matos <marco@marco.ae>

NAME:= firefox

.PHONY: all build alpine ubuntu

all: build

build:
	echo "kindly choose between alpine or ubuntu version"; \
    read version; \
	make $$version 

alpine:
	cat alpine.Dockerfile > Dockerfile
	docker build -t firefox:alpine .
	docker run -ti --rm \
	   --name $(NAME) \
	   -m 1GB \
       -e DISPLAY=unix$$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       firefox:alpine

ubuntu:
	cat ubuntu.Dockerfile > Dockerfile
	docker build -t firefox:ubuntu .
	docker run -ti --rm \
	   --name $(NAME) \
	   -m 1GB \
       -e DISPLAY=unix$$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       firefox:ubuntu
