numClients=$1
numOps=$2
echo ${numClients}
echo ${numOps}
for ((i = 0; i < ${numClients}; i++)); do
  ./shardBench.sh start $i cnodes ${numOps} &
done
wait
