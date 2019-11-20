#!/bin/bash

echo Removing containers, data and logs ... need supervisor privilege
cd tidb-docker-compose || exit 1
yes | docker-compose rm -s
for f in workdir/* ; do 
    sudo rm -rf "$f"/{data,logs}/*
done
cd ..

docker-compose -f tidb-docker-compose/generated-docker-compose.yml up -d
# docker-compose -f docker/docker-compose-1pd3kv.yml run ycsb shell tikv -p tikv.pd=pd0:2379
cd goclient && sudo -u noma go run insert.go && cd ..

docker-compose -f tidb-docker-compose/generated-docker-compose.yml down
sudo chown -R noma:noma tidb-docker-compose/workdir