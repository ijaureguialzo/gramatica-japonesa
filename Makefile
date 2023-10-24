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
	@echo ---------------------------------------------
	@echo init
	@echo build
	@echo serve --\> http://localhost:${PUERTO}
	@echo update / clean
	@echo ---------------------------------------------

_header:
	@echo ------
	@echo MkDocs
	@echo ------

init: update
	@docker compose run --rm mkdocs new .

build:
	@docker compose run --rm mkdocs build

serve:
	@docker compose run --rm --service-ports mkdocs serve -a 0.0.0.0:${PUERTO} -t ${TEMA}

update:
	@docker compose build --pull --no-cache

clean:
	@docker compose down -v --remove-orphans
