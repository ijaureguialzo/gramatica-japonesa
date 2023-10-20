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
	@echo ---------------------------------------------

_header:
	@echo ------
	@echo MkDocs
	@echo ------

_docker:
	@docker build . -t mkdocs

init: _docker
	@docker run --rm -v "`pwd`:/app" -w /app new .

build: _docker
	@docker run --rm -v "`pwd`:/app" -w /app mkdocs build

serve: _docker
	@docker run --rm -v "`pwd`:/app" -w /app -p ${PUERTO}:${PUERTO} mkdocs serve -a 0.0.0.0:${PUERTO} -t ${TEMA}
