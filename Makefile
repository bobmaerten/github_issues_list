# github_issues_list/Makefile

.PHONY: test watch
OUT_DIR=bin

# Aliases to everyday takss faster
b : build
r : run
s : setup
t : test
w : watch

# Don't forget : Makefiles use tabs indentation, not spaces !

setup: ## Install github_issues_list build/dev dependencies
	@echo "Installing Tools using Asdf ..." && asdf install
	@echo "Installing Entr using Homebrew ..." && brew install entr
	@echo "Installing Crystal dependencies ..."   && shards

run: ## Run the app
	# @echo "Running application ..." && crystal run src/github_issues_list.cr
	@ls src/github_issues_list.cr | entr crystal run src/github_issues_list.cr

clean:
	@rm -f $(OUT_DIR)/github_issues_list*

build: clean ## Compile the app without optimizations
	@echo "Compiling application ..." && crystal build -o $(OUT_DIR)/github_issues_list.cr src/github_issues_list.cr

release: clean ## Compile the app for release (optimized binary)
	@echo "Compiling application for release ..." && crystal build --release -o $(OUT_DIR)/github_issues_list src/github_issues_list.cr

test: ## Run the test suite
	@echo "Running tests ..." && crystal spec

watch: ## Run the test suite every time a file is changed
	@command find . -name '*.cr' | entr crystal spec
