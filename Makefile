HUGO        := hugo
PUBLIC_DIR  := /var/www/portfolio/public
SITE_URL    := https://nnag.duckdns.org

.PHONY: all build dev clean deploy init

all: build

## Build site into PUBLIC_DIR
build:
	$(HUGO) --minify

## Local dev server with live reload
dev:
	$(HUGO) server --buildDrafts --port 1313

## Wipe Hugo build cache and public output
clean:
	rm -rf resources .hugo_build.lock
	rm -rf $(PUBLIC_DIR)/*

## Full clean + build
deploy: clean build
	@echo [DONE] Site live at $(SITE_URL)

## First-time setup on a new machine
init:
	@which hugo > /dev/null 2>&1 || (echo [ERROR] hugo not found. Install it first. && exit 1)
	@echo [PASS] hugo found
	mkdir -p $(PUBLIC_DIR)
	@echo [DONE] Run make build to deploy
