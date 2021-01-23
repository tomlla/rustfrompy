.PHONY: clean run build

build:
	docker build . -t rustfrompy --target production
	date > build

run: build
	docker run rustfrompy

clean:
	rm -rf build
