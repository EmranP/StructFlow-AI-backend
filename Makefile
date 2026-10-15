ifneq ("$(wildcard .env)", "")
  include .env
  export
endif

export PROJECT_ROOT=$(shell pwd)

DB_URL ?= postgres://$(DB_USER):$(DB_PASSWORD)@$(DB_HOST):$(DB_PORT)/$(DB_NAME)?sslmode=disable
MIGRATIONS_PATH ?= ./migrations

# App

up:
	@docker compose -f docker-compose.yml up --build

up-d:
	@docker compose -f docker-compose.yml up -d --build

up-nc:
	@docker compose -f docker-compose.yml build --no-cache
	@docker compose -f docker-compose.yml up -d --force-recreate

recreate:
	@docker compose -f docker-compose.yml up -d --no-deps --force-recreate $(service)

stop:
	@docker compose -f docker-compose.yml down $(service)

stops:
	@docker compose -f docker-compose.yml down

clear:
	@read -p "Clear all volume files of the environment? Data loss is dangerous. [y/N]: " ans; \
	if [ "$$ans" = "y" ] || [ "$$ans" = "yes" ]; then \
		docker compose -f docker-compose.yml down -v; \
		sudo rm -rf $(PROJECT_ROOT)/out; \
		echo "Files of the environment is clear"; \
	else \
		echo "Operation cancelled."; \
	fi;

migrate-up:
	@echo "Using DB_URL: $(DB_URL)"
	@echo "Running up migrations..."
	@docker run --rm --network sf-ai-net \
		-v $(PROJECT_ROOT)/$(MIGRATIONS_PATH):/migrations \
		migrate/migrate \
		-path=/migrations/ \
		-database "$(DB_URL)" up

migrate-down:
	@echo "Running down migrations..."
	@docker run --rm --network sf-ai-net \
		-v $(PROJECT_ROOT)/$(MIGRATIONS_PATH):/migrations \
		migrate/migrate \
		-path=/migrations/ \
		-database "$(DB_URL)" down 1

.PHONY: up up-d up-nc up-d-nc stop stops clear recreate migrate-up migrate-down