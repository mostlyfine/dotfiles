ENV ?= development
.DEFAULT_GOAL := help
.PHONY: build deploy

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

help: ## this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

