.PHONY: clean run build

build:
	docker build . -t rustfrompy
	date > build

run: build
	docker run rustfrompy

clean:
	rm -rf build
