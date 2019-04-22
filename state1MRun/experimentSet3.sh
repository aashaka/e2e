numRuns=5

#TEST different pruneDepth

for ((i = 0; i < ${numRuns}; i++)); do
    for c in 1 4 8 16 32 64 256 512 1024
    do
    ./storage.sh start snodes 8;
    ./runShardBench.sh ${c};
    ./pullLogs.sh shard/${c}clients/run${i}
    ./helper.sh removeLogs livenodes
    ./storage.sh stop snodes 8
    ./logs/summarize.sh ./logs/shard/${c}clients/run${i} >> ./logs/shard/${c}clients/run${i}
    done
done

# TEST scalability with verifier-verifier

for ((i = 0; i < ${numRuns}; i++)); do
    for pruneDepth in 8 7 6 5 4 3 2 1 0
    do
    ./storage.sh start snodes 8;
    ./runShardBench.sh 8;
    ./pullLogs.sh prune/${pruneDepth}depth8clients/run${i}
    ./helper.sh removeLogs livenodes
    ./storage.sh stop snodes 8
    ./logs/summarize.sh ./logs/prune/${c}clients 
    done
done
