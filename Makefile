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

init:
	@docker run --rm -v "`pwd`:/app" -w /app minidocks/mkdocs new .

build:
	@docker run --rm -v "`pwd`:/app" -w /app minidocks/mkdocs build

serve:
	@docker run --rm -v "`pwd`:/app" -w /app -p ${PUERTO}:${PUERTO} minidocks/mkdocs serve -a 0.0.0.0:${PUERTO} -t ${TEMA}
