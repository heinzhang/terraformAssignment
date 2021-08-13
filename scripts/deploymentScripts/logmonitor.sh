#!/bin/bash

# since cron job does not support 10 seconds running I need to use the script below

i=0

while [ $i -lt 6 ]; do
    currentTime=$(date +"%Y-%m-%d %H:%M:%S %z %Z")
    # todo:check if this is the first line 
    currentDockerStatus=$(sudo /usr/bin/docker ps -f "name=nginx-assignment" --format "{{.CreatedAt}} ~ {{.State}} ~ {{.Status}}")
    currentDockerResourceStatus=$(sudo /usr/bin/docker stats nginx-assignment --no-stream --format "{{.Name}} ~ {{.ID}} ~ {{.CPUPerc}} ~ {{.MemUsage}} ~ {{.NetIO}} ~ {{.BlockIO}} ~ {{.MemPerc}} ~ {{.PIDs}}")
    searchLogLine=${currentTime}" ~ "${currentDockerResourceStatus}" ~ "${currentDockerStatus}
    echo ${searchLogLine}
    sleep 10
    i=$(( i + 1 ))
done
