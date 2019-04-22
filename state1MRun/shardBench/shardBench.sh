#!/bin/bash
# Usage - ./deploy_client.sh NUM_STORAGE_SERVICES
# $1 start/stop $2 - num-clients

USERNAME="cc"
CLIENTS=($(<./$3))
clientToSpawn=$2

stop() {
  for ((i = 0; i < ${#CLIENTS[@]}; i++)); do
    ssh -i ~/disaggregatedblockchain.pem ${USERNAME}@${CLIENTS[i]} '
        kill -9 $(pgrep -f rainblock-client)
    ' 
  done
}

start(){
  num=$(( ${clientToSpawn} % ${#CLIENTS[@]} ))
  ssh -i ~/disaggregatedblockchain.pem ${USERNAME}@${CLIENTS[num]} "cd ~/sosp19/storage; 
   node --max-old-space-size=122880 -r ts-node/register src/shardBench.ts 1000000"
  echo "DONE CLIENT INSTANCE"
}

if (($# != 3)); then
  echo "./client.sh start/stop clientToSpawn clientIps"
fi

# setup_docker_deps $1
if [ $1 = "start" ]; then
	start
fi
if [ $1 = "stop" ]; then
	stop
fi
