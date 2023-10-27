#!make

ifneq (,$(wildcard ./.env))
    include .env
    export
else
$(error No se encuentra el fichero .env)
endif

help: _header
	${info }
	@echo Opciones:
	@echo ----------------------------------------
	@echo init
	@echo build
	@echo start / stop / restart
	@echo logs / update / stats / clean
	@echo ----------------------------------------

_header:
	@echo ------
	@echo MkDocs
	@echo ------

_urls: _header
	${info }
	@echo ----------------------------------------
	@echo [MkDocs] http://localhost:${PUERTO}
	@echo ----------------------------------------

init: update
	@docker compose run --rm mkdocs new .

build:
	@docker compose run --rm mkdocs build

_start_command:
	@docker compose up -d mkdocs

start: _start_command _urls

stop:
	@docker compose rm -fs

restart: stop start

logs:
	@docker compose logs mkdocs

update:
	@docker compose build --pull --no-cache

stats:
	@docker stats

clean:
	@docker compose down -v --remove-orphans
