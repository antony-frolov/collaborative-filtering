#!/bin/bash

# Remove namenode directories if present
docker exec namenode rm -r /data /src /run_hadoop.sh

# Copy input data and source code to namenode
docker exec namenode mkdir /data
docker cp ./data/input namenode:/data/input
docker cp ./src namenode:/src
docker cp ./run_hadoop.sh namenode:/run_hadoop.sh

# Execure hadoop.sh script on namenode
docker exec namenode chmod 0777 /run_hadoop.sh
docker exec namenode /run_hadoop.sh

# Remove local output directory if present
rm -r ./data/output

# Copy output from namenode to local
docker cp namenode:/data/output ./data/output

mv ./data/output/stage_6 ./data/output/final
