numRuns=3

#TEST different pruneDepth

for ((i = 1; i < ${numRuns}; i++)); do
    for c in 1 10 100 1000
    do
     mkdir -p ./data/shard/${c}Clients
     numOps=$(( 10000000/${c}))
	echo "Starting snodes"
    ./storage.sh start snodes 8;
     sleep 90
	echo "Starting shardBench"
    ./runShardBench.sh ${c} ${numOps};
	echo "Pulling logs"
   ./pullLogs.sh shard/${c}Clients/run${i}
	echo "Removing logs"
    ./helper.sh removeLogs livenodes
	echo "Stopping storage nodes"
    ./storage.sh stop snodes 8
	echo "Summarizing"
    ./summarize.sh ./logs/shard/${c}Clients/run${i} >> ./data/shard/${c}Clients/run${i}.txt
    done
done

# TEST scalability with verifier-verifier

#for ((i = 0; i < ${numRuns}; i++)); do
#    for pruneDepth in 8 7 6 5 4 3 2 1 0
#    do
#    ./storage.sh start snodes ${pruneDepth};
#     sleep 90
#    ./runShardBench.sh 100;
#    ./pullLogs.sh prune/${pruneDepth}Depth16clients/run${i}
#    ./helper.sh removeLogs livenodes
#    ./storage.sh stop snodes ${pruneDepth};
#    ./logs/summarize.sh ./logs/prune/${pruneDepth}Depth16clients/run${i} 
#    done
#done
