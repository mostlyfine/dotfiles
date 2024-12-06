ENV ?= development
.DEFAULT_GOAL := help
.PHONY: $(shell grep -E '^[a-zA-Z_-]+:' $(MAKEFILE_LIST) | sed 's/://')

ifdef CONTENT
build: ## build with content
	@echo 'build ${CONTENT}'
else
build: ## build
	@echo 'build'
endif

ifeq ($(ENV), production)
deploy: build ## deploy production
	@echo 'deploy'
else
deploy: build ## deploy
	@echo 'deploy ${ENV}'
endif

clean: ## execute cleanup
	@echo 'cleanup'

help: ## this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

