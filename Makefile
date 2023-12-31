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
	@(brew -v && echo "\n\t${GREEN}using brew" `brew -v` "${NC}\n") && \
		brew bundle || \
		echo "\n\t${YELLOW}brew not installed${NC}, continuing 🚀\n"
	bundle
	yarn

config/master.key:
	@bw status | jq '.status=="unauthenticated"' | \
		awk '/true/ { exit 1 }' && \
		echo "signed in to ${GREEN}Bitwarden${NC}" || \
		{ \
		echo "need to be signed into ${YELLOW}Bitwarden${NC}"; \
		echo "with ${RED}bw login${NC}"; \
		exit 1; \
		}
	bw get item ba68ca45-54ed-474e-9e38-b0a8005069aa | \
		jq --raw-output '.login.password' > config/master.key
	# probably setting RAILS_MASTER_KEY would be better than writing it to
	# a file

.PHONY: setup
setup: install config/master.key

.PHONY: db-migrate
db-migrate:
	RAILS_ENV=test bin/rails db:drop db:create db:migrate

.PHONY: test
test:
	yarn build
	yarn build:css
	bin/rspec

.PHONY: run
run:
	bin/dev

.PHONY: prod-run
prod-run:
	yarn build
	yarn build:css
	RAILS_ENV=production bin/rails server

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
ci: install db-migrate lint-checkonly test

.PHONY: clean
clean:
	# file -f config/master.key
	@rm config/master.key || \
		echo 'config/master.key already removed'

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

