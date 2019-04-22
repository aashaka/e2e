numRuns=5

#TEST different pruneDepth

for ((i = 0; i < ${numRuns}; i++)); do
    for c in 1 4 16 64 256 1024
    do
    ./storage.sh start snodes 8;
     sleep 90
    ./runShardBench.sh ${c};
    ./pullLogs.sh shard/${c}Clients/run${i}
    ./helper.sh removeLogs livenodes
    ./storage.sh stop snodes 8
    ./logs/summarize.sh ./logs/shard/${c}Clients/run${i} >> ./logs/shard/${c}Clients/run${i}
    done
done

# TEST scalability with verifier-verifier

for ((i = 0; i < ${numRuns}; i++)); do
    for pruneDepth in 8 7 6 5 4 3 2 1 0
    do
    ./storage.sh start snodes ${pruneDepth};
     sleep 90
    ./runShardBench.sh 16;
    ./pullLogs.sh prune/${pruneDepth}Depth16clients/run${i}
    ./helper.sh removeLogs livenodes
    ./storage.sh stop snodes ${pruneDepth};
    ./logs/summarize.sh ./logs/prune/${pruneDepth}Depth16clients/run${i} 
    done
done
