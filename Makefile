.PHONY: build
build: ## build the postgres_sqlc_guide binary
	CGO_ENABLED=0 go build -a -o postgres_sqlc_guide ./cmd/main.go

.PHONY: start
start: ## run the postgres_sqlc_guide:
	go run ./cmd/main.go

.PHONY: test
test: ## run the postgres_sqlc_guide:
	go test ./...

.PHONY: build-start
build-start: ## run the postgres_sqlc_guide:
	make build
	./postgres_sqlc_guide

.PHONY: flags
flags: ## run the postgres_sqlc_guide:
	go run ./cmd/main.go --help

.PHONY: gendb
gendb: ## run the db generator:
	sqlc generate -f ./internal/postgres/config/sqlc.yaml

# Docker
.PHONY : docker
docker: ## build and run the postgres_sqlc_guide:latest docker image
	make build-docker
	- docker stop postgres_sqlc_guide
	- docker rmi $(docker images -q -f "dangling=true" -f "label=autodelete=true")
	make run-docker

.PHONY: build-docker
build-docker: ## build the postgres_sqlc_guide:latest docker image
	docker build -t postgres_sqlc_guide:latest .

.PHONY: run-docker
run-docker: ## run the postgres_sqlc_guide:latest docker image to start the service
	docker run -d\
		-p 8096:8096 \
		--network="host" \
		--rm \
		--name postgres_sqlc_guide \
		postgres_sqlc_guide:latest

.PHONY: logs
logs: ## print docker logs into console
	docker logs -f postgres_sqlc_guide

.PHONY: help
help:  ## 🤔 Show help messages for make targets
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}'