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

brew-deps-installed.txt: brew-deps.txt $(HOME)/bin/brew
	cat brew-deps.txt | xargs brew install
	date +"%s" > brew-deps-installed.txt

npm-deps-installed.txt: npm-deps.txt
	cat npm-deps.txt | xargs npm install -g --yes
	date +"%s" > npm-deps-installed.txt

pip-deps-installed.txt: pip-deps.txt
	cat pip-deps.txt | xargs pip install --user --upgrade
	date +"%s" > pip-deps-installed.txt

install: brew-deps go-deps npm-deps pip-deps bin-deps

bin-deps: brew-install ngrok-install composer-install

composer-install: bin/composer
bin/composer: bin/composer.phar
	ln -sr bin/composer.phar bin/composer

bin/composer.phar:
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php -r "if (hash_file('SHA384', 'composer-setup.php') === 'aa96f26c2b67226a324c27919f1eb05f21c248b987e6195cad9690d5c1ff713d53020a02ac8c217dbf90a7eacc9d141d') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
	php composer-setup.php --install-dir=bin
	php -r "unlink('composer-setup.php');"

ngrok-install: bin/ngrok
bin/ngrok: bin/ngrok.zip
	unzip bin/ngrok.zip -d bin/
bin/ngrok.zip:
	wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O bin/ngrok.zip

brew-install: $(HOME)/.linuxbrew/bin/brew
$(HOME)/.linuxbrew/bin/brew:
	curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install | ruby
