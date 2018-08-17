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
pip3-deps: pip3-deps-installed.txt

go-deps-installed.txt: go-deps.txt
	cat go-deps.txt | xargs go get -u
	date +"%s" > go-deps-installed.txt

brew-deps-installed.txt: brew-deps.txt /home/linuxbrew/.linuxbrew/bin/brew
	brew update
	cat brew-deps.txt | xargs brew install
	date +"%s" > brew-deps-installed.txt

npm-deps-installed.txt: npm-deps.txt
	cat npm-deps.txt | xargs npm install -g --yes
	date +"%s" > npm-deps-installed.txt

pip-deps-installed.txt: pip-deps.txt
	cat pip-deps.txt | xargs pip2 install --user --upgrade
	date +"%s" > pip-deps-installed.txt

pip3-deps-installed.txt: pip3-deps.txt
	cat pip3-deps.txt | xargs pip3 install --user --upgrade
	date +"%s" > pip3-deps-installed.txt

install: brew-deps go-deps npm-deps pip-deps bin-deps

bin-deps: brew-install

phpbrew-install: opt/phpbrew/bin/phpbrew
opt/phpbrew/bin/phpbrew:
	mkdir -p opt/phpbrew/bin/
	curl -L -O https://github.com/phpbrew/phpbrew/raw/master/phpbrew
	mv phpbrew opt/phpbrew/bin/phpbrew
	chmod +x opt/phpbrew/bin/phpbrew

brew-install: /home/linuxbrew/.linuxbrew/bin/brew
/home/linuxbrew/.linuxbrew/bin/brew:
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
