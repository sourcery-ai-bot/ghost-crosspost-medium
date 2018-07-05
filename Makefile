
define msg
    @printf "\033[36m# %s\033[0m\n" $(1)
endef

test:  ## Run tests
	$(call msg,"Running tests")
	py.test src/

lint:  ## Run PyLint
	$(call msg,"Running PyLint")
	find src -iname "*.py" | xargs pylint

code-coverage: ## Run coverage.py
	$(call msg,"Running coverage.py")
	coverage run --omit="venv/*" src/medium_crosspost.py && coverage report -m

travis-coverage: ## Run coverage.py formatted for build
	$(call msg,"Running coverage.py formatted for build")
	coverage run --omit="venv/*" src/medium_crosspost.py && coverage xml && cat coverage.xml

create-venv: ## Create a virtualenv for this project
	$(call msg,"Creating a virtualenv for this project")
	virtualenv --python=/usr/bin/python2.7 venv
	venv/bin/pip install -r requirements.txt
	echo "$(shell pwd)/src" > venv/lib/python2.7/site-packages/ghost-crosspost-medium.pth
