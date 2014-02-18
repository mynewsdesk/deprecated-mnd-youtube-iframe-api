all: build

build:
				@./node_modules/coffee-script/bin/coffee \
								-c \
								-o lib src

test:
				@./node_modules/mocha/bin/mocha

.PHONY: all test clean
