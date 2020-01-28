#!/bin/bash
# Usage - ./deploy_client.sh NUM_STORAGE_SERVICES
# $1 start/stop $2 - num-clients

USERNAME="cc"
CLIENTS=($(<./$3))
clientToSpawn=$2
numOps=$4

stop() {
  for ((i = 0; i < ${#CLIENTS[@]}; i++)); do
    ssh -i ~/disaggregatedblockchain.pem ${USERNAME}@${CLIENTS[i]} '
        kill -9 $(pgrep -f rainblock-client)
    ' 
  done
}

start(){
  num=$(( ${clientToSpawn} % ${#CLIENTS[@]} ))
echo "DOing node --max-old-space-size=122880 -r ts-node/register src/shardBench.ts ${numOps}"
  ssh -i ~/disaggregatedblockchain.pem ${USERNAME}@${CLIENTS[num]} "cd ~/sosp19/storage; 
   node --max-old-space-size=122880 -r ts-node/register src/shardBench.ts ${numOps}"
  echo "DONE CLIENT INSTANCE"
}

if (($# != 4)); then
  echo "./client.sh start/stop clientToSpawn clientIps numOps"
fi

# setup_docker_deps $1
if [ $1 = "start" ]; then
	start
fi
if [ $1 = "stop" ]; then
	stop
fi
