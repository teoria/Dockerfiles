#escape = `
IMAGE:= jetbrains/upsource:2017.2.2307
CONTAINER_NAME:= upsource
HOSTNAME:= upsource.emaratech.ae
ENDPOINT:=  http://0.0.0.0:8081
DATA_DIR:= /repo/dockerfiles/upsource/data/var/lib/
CONF_DIR:= /repo/dockerfiles/upsource/data/upsource/
LOG_DIR:= /repo/dockerfiles/upsource/data/var/log/
BACKUP_DIR:= /repo/dockerfiles/upsource/data/var/backups

PHONY: all build test run shell kill restart logs  endpoint

all: 


test: 
	@echo 'creating the upsource container' 
	docker run -it --name upsource -v $(DATA_DIR):/opt/upsource/data -v $(CONF_DIR):/opt/upsource/conf -v $(LOG_DIR):/opt/upsource/logs -v $(BACKUP_DIR):/opt/upsource/backups -p 8081:8080 $(IMAGE)

run: 
	@echo 'running the upsource container'
	docker create -it --name upsource -v $(DATA_DIR):/opt/upsource/data -v $(CONF_DIR):/opt/upsource/conf -v $(LOG_DIR):/opt/upsource/logs -v $(BACKUP_DIR):/opt/upsource/backups -p 8081:8080 $(IMAGE)
	docker start $(CONTAINER_NAME)

shell:
	 docker exec -ti $(CONTAINER_NAME) /bin/bash 

kill:
	docker kill $(CONTAINER_NAME)
	docker rm -f $(CONTAINER_NAME)

rm:
	docker rm -f $(CONTAINER_NAME)

restart:
	docker restart $(CONTAINER_NAME)

logs:
	docker logs -f $(CONTAINER_NAME)

endpoint:
	echo $(ENDPOINT)

push:
	docker push $(IMAGE)