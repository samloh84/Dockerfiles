SHELL := /bin/bash

.PHONY: all base stacks

all: base stacks

base:
	make -C $@

stacks:
	make -C $@
