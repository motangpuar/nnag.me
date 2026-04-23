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

local-test:
	podman run --rm -it   -v $(CURDIR):/src:z   -p 1313:1313   hugomods/hugo:exts-0.146.0   server --bind 0.0.0.0 --port 1313 --buildDrafts
