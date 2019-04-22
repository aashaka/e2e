numClients=$1
echo ${numClients}
for ((i = 0; i < ${numClients}; i++)); do
  ./shardBench.sh start $i cnodes &
done
wait
