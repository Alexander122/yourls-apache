init:
	rm -rf site
	mkdir site
	sudo docker-compose up -d
	curl -o site/yourls.tar.gz -SL "https://github.com/YOURLS/YOURLS/archive/1.7.2.tar.gz";
	tar -xzf site/yourls.tar.gz -C site;
	mv site/YOURLS-1.7.2/* site;
	cp -a docker/php-apache/config.php site/user/
	rm -rf site/YOURLS-1.7.2;
	rm site/yourls.tar.gz;
build:
	sudo docker-compose build --no-cache
rmv:
	#sudo docker volume prune --force
	sudo docker images purge
	sudo docker volume rm $(docker volume ls -qf dangling=true)
lsv:
	sudo docker volume ls
kill:
	sudo docker-compose kill
recreate:
	sudo docker-compose up -d --force-recreate
expand:
	curl --data "shorturl=$(SHORTURL)&format=$(FORMAT)&action=expand&username=admin&password=pwd" http://localhost:8080/yourls-api.php
shorturl:
	curl --data "username=admin&password=pwd&action=shorturl&format=$(FORMAT)&url=$(URL)&keyword=$(KEYWORD)&title=$(TITLE)" http://localhost:8080/yourls-api.php
stats:
	curl --data "username=admin&password=pwd&action=stats&format=$(FORMAT)&filter=$(FILTER)&limit=$(LIMIT)" http://localhost:8080/yourls-api.php
db-stats:
	curl --data "username=admin&password=pwd&action=db-stats&format=$(FORMAT)" http://localhost:8080/yourls-api.php
