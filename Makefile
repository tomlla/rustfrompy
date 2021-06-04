.PHONY: clean run build

FUNC="call_func01"

build:
	docker build . -t rustfrompy --target production

run: build
	docker run rustfrompy python entrypoint.py ${FUNC}

clean:
	rm -rf build


PYTHON_COMMAND_PREFIX:=poetry run
PYTHON:=$(PYTHON_COMMAND_PREFIX) python

py/mypy:
	cd pyapp/ && $(PYTHON_COMMAND_PREFIX) mypy .

py/fmt:
	cd pyapp/ && $(PYTHON_COMMAND_PREFIX) black .

py/check: py/mypy py/fmt

