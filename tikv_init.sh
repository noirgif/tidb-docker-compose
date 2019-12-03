#!/bin/bash

echo Removing containers, data and logs ... need supervisor privilege
cd tidb-docker-compose || exit 1
yes | docker-compose rm -s
for f in workdir/* ; do 
    sudo rm -rf "$f"/{data,logs}/*
done
cd ..

docker-compose -f tidb-docker-compose/generated-docker-compose.yml up -d
cd goclient && sudo -u noma go run insert.go && cd ..

docker-compose -f tidb-docker-compose/generated-docker-compose.yml down
sudo chown -R noma:noma tidb-docker-compose/workdir

echo Backing up everything ...
for f in tidb-docker-compose/workdir/* ; do
	sudo rm -rf $f/data.snapshot
	cp -r $f/data $f/data.snapshot
	echo $(basename $f)
done
