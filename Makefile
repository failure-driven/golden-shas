.DEFAULT_GOAL := usage

# user and repo
USER        = $$(whoami)
CURRENT_DIR = $(notdir $(shell pwd))

# terminal colours
RED     = \033[0;31m
GREEN   = \033[0;32m
YELLOW  = \033[0;33m
NC      = \033[0m
# versions
APP_REVISION    = $(shell git rev-parse HEAD)

.PHONY: install
install:
	bundle install

.PHONY: run
run:
	bundle exec rails server

.PHONY: prod-run
prod-run:
	RAILS_ENV=production bundle exec rails server

.PHONY: lint-safe
lint-safe:
	bundle exec rubocop -a

.PHONY: lint-unsafe
lint-unsafe:
	bundle exec rubocop -A

.PHONY: lint-checkonly
lint-checkonly:
	bundle exec rubocop

.PHONY: ci
ci: lint-checkonly

.PHONY: usage
usage:
	@echo
	@echo "Hi ${GREEN}${USER}!${NC} Welcome to ${RED}${CURRENT_DIR}${NC}"
	@echo
	@echo "Getting started"
	@echo
	@echo "${YELLOW}make install${NC}                  install dependencies"
	@echo
	@echo "${YELLOW}make run${NC}                      launch app in DEV mode"
	@echo "${YELLOW}make prod-run${NC}                 WIP(ADD KEYS) launch app in PRODUCTION mode"
	@echo
	@echo "${YELLOW}make lint-safe${NC}                lint app(SAFE)"
	@echo "${YELLOW}make lint-unsafe${NC}              lint app(UNSAFE)"
	@echo "${YELLOW}make lint-checkonly${NC}           check lintintg"
	@echo
	@echo "${YELLOW}make ci${NC}                       ci script"
	@echo

