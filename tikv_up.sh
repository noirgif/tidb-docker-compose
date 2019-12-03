#!/bin/bash

# set up the cluster
rm -rf tidb-docker-compose/workdir/*/logs/*
if ! [ $1 ] ; then
	echo Starting original...
    	docker-compose -f tidb-docker-compose/generated-docker-compose.yml up -d
else
	# recover the PD
	# ./recover_pd.sh
	# replace the path in docker-compose
	sed -E "s|workdir/tikv0/data[^:]*|$1|" tidb-docker-compose/generated-docker-compose.yml | \
	sed -E "s|workdir/tikv1/data[^:]*|$2|" | \
	sed -E "s|workdir/tikv2/data[^:]*|$3|" > tidb-docker-compose/generated-docker-compose-mp.yml
	docker-compose -f tidb-docker-compose/generated-docker-compose-mp.yml up -d
fi
