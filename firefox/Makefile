# Makefile >> Mozilla Firefox on Docker
# Marco Matos <marco@marco.ae>

NAME:= firefox

.PHONY: all build dev current

all: build

build:
	echo ">>> kindly type 'current' and hit enter > dev version is still under development \n ---"; \
    read version; \
	make $$version 

dev:
	cat dev.Dockerfile > Dockerfile
	docker build -t firefox:dev .
	docker run -ti --rm \
	   --name $(NAME) \
	   -m 1GB \
       -e DISPLAY=unix$$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       firefox:dev

current:
	cat current.Dockerfile > Dockerfile
	docker build -t firefox:current .
	echo ">>> how much memory you want to allocate to this container? (512M, 1GB, 2GB and so on) \n ---"; \
    read memory; \
	docker run -ti --rm \
	   --name $(NAME) \
	   -m $$memory \
       -e DISPLAY=unix$$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       firefox:current
