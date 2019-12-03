#!/bin/bash

./tikv_init.sh
cd ../..
sudo trace.py --trace_files ./systems/tikv/trace{0,1,2} --data_dirs ./systems/tikv/tidb-docker-compose/workdir/tikv{0,1,2}/data --workload_command ./systems/tikv/tikv_workload_read.py
sudo cords.py --trace_files ./systems/tikv/trace0 ./systems/tikv/trace1 ./systems/tikv/trace2 --data_dirs ./systems/tikv/tidb-docker-compose/workdir/tikv{0,1,2}/data --workload_command ./systems/tikv/tikv_workload_read.py --cords_results_base_dir $PWD/systems/tikv/results
