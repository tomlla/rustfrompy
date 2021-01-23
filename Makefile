.PHONY: clean run build

FUNC="call_func01"

build:
	docker build . -t rustfrompy --target production

run: build
	docker run rustfrompy python entrypoint.py ${FUNC}

clean:
	rm -rf build
