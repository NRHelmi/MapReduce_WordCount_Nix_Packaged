SHELL := /usr/bin/env bash
MVN := $(shell which mvn)
NIX_BUILD := $(shell which nix-build)
NIX_ENV := $(shell which nix-env)

install:
	cd .. && \
	$(MVN) clean install
run:
	cd .. && \
	rm -rf output && \
	java -jar target/wordcount-0.1-jar-with-dependencies.jar data/input.txt output && \
	cat output/part-r-00000
package:
	cd .. && \
	$(MVN) org.nixos.mvn2nix:mvn2nix-maven-plugin:mvn2nix
build:
	cd .. && \
	$(NIX_BUILD)
install_to_env:
	cd .. && \
	$(NIX_ENV) -if default.nix
remove_from_env:
	cd .. && \
	$(NIX_ENV) -e wordCount

