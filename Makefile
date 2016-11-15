# when you run 'make' alone, run the 'css' rule (at the
# bottom of this makefile)
all: install

# .PHONY is a special command, that allows you not to
# require physical files as the target (allowing us to
# use the 'all' rule as the default target).
.PHONY: all

clean:
	git clean -Xdf

go-deps: brew-deps go-deps-installed.txt

brew-deps: brew-deps-installed.txt

npm-deps: npm-deps-installed.txt

pip-deps: pip-deps-installed.txt

go-deps-installed.txt: go-deps.txt
	cat go-deps.txt | xargs go get -u
	date +"%s" > go-deps-installed.txt

brew-deps-installed.txt: brew-deps.txt
	cat brew-deps.txt | xargs brew install
	date +"%s" > brew-deps-installed.txt

npm-deps-installed.txt: npm-deps.txt
	cat npm-deps.txt | xargs npm install -g --yes
	date +"%s" > npm-deps-installed.txt

pip-deps-installed.txt: pip-deps.txt
	cat pip-deps.txt | xargs pip install --user --upgrade
	date +"%s" > pip-deps-installed.txt

install: brew-deps go-deps npm-deps pip-deps
