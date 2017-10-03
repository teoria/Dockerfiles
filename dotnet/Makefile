# makefile for Docker containers management/automation
# Marco Matos  <marco.matos@marco.ae>

NAME = registry.your.repo.here:5000/dotnet
TIMESTAMP:= `date +%Y`-`date +%m`-`date +%d`-`date +%s`
BRANCH:= $$(git branch)
REVISION:= $$(git rev-parse HEAD)
USER:= $$(git config user.name)
VERSION:= 1.0.1
CONTAINER_NAME:= test_dotnet
URL:= http://localhost


.PHONY: all build clean backup test tag_latest push push_latest run last_built_date dockerfile 

all: build 

build: 
	docker build -t $(NAME):$(VERSION) --rm . 

clean: 
	@echo 'Removing old releases...'
	rm -rf release-*

backup: clean
	@echo 'Performing Backup...'
	@echo 'Creating new release...'
	@printf "\nDate: $(TIMESTAMP)\nBranch: $(BRANCH)\nRevision: $(REVISION)\nDeployed by: $(USER)\n\n" > Metainf
	zip -r release-$(TIMESTAMP) ./*
	@echo Release release-$(TIMESTAMP).zip created.
	
test:
	@echo 'testing the dotnet container'
	docker run --rm -ti --name test_dotnet -P $(NAME):$(VERSION)
#	docker port test_dotnet | sed 's/\:/ /g'|awk {'print $4'}
#	@echo 'after deployed, access http://localhost:8080' 

#test:
#	@echo 'testing the dotnet container'
#	docker run --rm --name $(CONTAINER_NAME) -P $(NAME):$(VERSION)
#	@echo 'after deployed, access:'
#	@echo $(URL):$(PORT) 

tag_latest: 
	docker tag $(NAME):$(VERSION) $(NAME):latest 

push: 
	docker push $(NAME):$(VERSION) 

push_latest: 
	docker push $(NAME):latest 

run: 
	@echo 'running the dotnet container'
	docker run -d --name dotnet -p 8080:8080 -p 50000:50000 -v `pwd`/dotnet_home:/var/dotnet_home $(NAME):$(VERSION)
	@echo 'deploy done, access http://localhost:8000' 

run_latest:
	@echo 'running the dotnet container'
	docker run -p 8000:80 -e "ASPNETCORE_URLS=http://+:80" -it $(NAME):latest
#	docker run -d --name dotnet -p 8080:8080 -p 50000:50000 -v `pwd`/dotnet_home:/var/dotnet_home $(NAME):latest
	@echo 'deploy done, access http://localhost:8000' 

last_built_date: 
	docker inspect -f '{{ .Created }}' $(NAME):$(VERSION)

dockerfile:
	@echo 'overwrite current Dockerfile with the development file contents'
	cat dotnet.Dockerfile > Dockerfile
	@echo 'now you just need to run make build' 	

rm:
	@echo 'your running containers arent removed by this command'
	@echo 'in order to do it, you must stop your container before run "make rm" again'
	docker rm `docker ps -a|grep $(NAME) | awk '{print $$1}'`

force_rm:
	docker rm -f `docker ps -a|grep $(NAME) | awk '{print $$1}'`

deploy: dockerfile build tag_latest push_latest force_rm run_latest
