# Licenses

The docker-compose file comes from [tidb-docker-compose](https://github.com/pingcap/tidb-docker-compose/), under Apache-2.0 license.

# How to run

# Current Problems

1. Raft is non-deterministic. Different files may be accessed each time.
2. No fs footprint for tikvs, and only one PD has fs accesses.
   1. Update: because CORDS need I/O to be done on its specified folder rather than the original folders
   2. Update: FUSE doesn't allow other users to access the files, including root. This prevents the docker container, which uses ROOT user, to run. -> solution: run everything as root.
3. TiKV keep restarting
   1. Because PD is stateful and keeps the information about TiKV instances, bringing up a new instance might trigger duplicates?
      1. Is the snapshot in a healthy state?