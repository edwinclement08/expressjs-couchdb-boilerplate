define assert_command_exists
	@command -v "$(1)" >/dev/null 2>&1 || { echo >&2 "\033[31;1m Install $(1) and try again.\033[0m"; exit 1;}
endef

.PHONY: help prod dev build up down getshell

# This code below will pretty print out the help data
help: ## This help dialog.
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##/:/'`); \
	printf "%-30s %s\n" "target" "help" ; \
	printf "%-30s %s\n" "------" "----" ; \
	for help_line in $${help_lines[@]}; do \
		IFS=$$':' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf '\033[36m'; \
		printf "%-30s %s" $$help_command ; \
		printf '\033[0m'; \
		printf "%s\n" $$help_info; \
	done

# This is used for tagging the images
# COMMIT_HASH := $(shell git rev-parse HEAD | colrm 8 )
# export COMMIT_HASH=$(COMMIT_HASH)
PROJECT_NAME=expressjs-couchdb-boilerplate

prod: ## [ENVIRON] set the build mode to `production`
	@echo 'ENVIRON=prod' > ./.environ
	@echo 'Set the environment to production'

dev: ## [ENVIRON] set the build mode to `development` with code auto-reloading
	@echo 'ENVIRON=dev' > ./.environ
	@echo 'Set the environment to development'

build: ## [ACTION] build the images
		@source ./.environ && echo "Building Environment: $${ENVIRON}"
		@source ./.environ && docker-compose -f docker-compose.$$ENVIRON.yml -p $(PROJECT_NAME)_$$ENVIRON build

up: ## [ACTION] run the app
		@source ./.environ && echo "Bringing Up Environment: $${ENVIRON}"
		@source ./.environ && docker-compose -f docker-compose.$$ENVIRON.yml -p $(PROJECT_NAME)_$$ENVIRON up -d

down: ## [ACTION] bring down the app
	@source ./.environ && echo "Shutting Down Environment: $${ENVIRON}"
	@source ./.environ && docker-compose -f docker-compose.$$ENVIRON.yml -p $(PROJECT_NAME)_$$ENVIRON down


# utility functions
getshell: ## [tool] get shell into the $(project_name) container
	@echo "getting a shell into (`docker ps --format "table {{.ID}}\t{{.Image}}" | grep '$(PROJECT_NAME)' | sed 's/ [ ]*/ -- /g' `)"
	@docker exec -it `docker ps --format "table {{.ID}}\t{{.Image}}" | grep '$(PROJECT_NAME)' | cut -d " " -f 1` bash || sh

logs: ## [TOOL] Tail the running log of the backend server
	@source ./.environ && echo "Getting Logs Environment: $$ENVIRON"
	@source ./.environ && echo "Matching Containers (`docker ps -a --format "table {{.ID}}\t{{.Image}}" | grep "$(PROJECT_NAME)_$$ENVIRON" | sed 's/ [ ]*/ -- /g' `)"
	@source ./.environ && docker logs -f "`docker ps -a --format "table {{.ID}}\t{{.Image}}" | grep "$(PROJECT_NAME)_$$ENVIRON" | cut -d " " -f 1`"
