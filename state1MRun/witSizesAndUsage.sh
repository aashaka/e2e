numRuns=1

#TEST different pruneDepth
for ((i = 1; i <= ${numRuns}; i++)); do
    ./storage.sh start snodes 9;
    ./verifier.sh start 1 vnodes 9;
    ./run.sh 8 cnodes trace1M final/prune/88With8Clients/run${i};
    
    ./storage.sh start snodes 8;
    ./verifier.sh start 1 vnodes 8;
    ./run.sh 8 cnodes trace1M final/prune/88With8Clients/run${i};

    ./storage.sh start snodes 7;
    ./verifier.sh start 1 vnodes 7;
    ./run.sh 8 cnodes trace1M final/prune/77With8Clients/run${i};

    ./storage.sh start snodes 6;
    ./verifier.sh start 1 vnodes 6;
    ./run.sh 8 cnodes trace1M final/prune/66With8Clients/run${i};

    ./storage.sh start snodes 5;
    ./verifier.sh start 1 vnodes 5;
    ./run.sh 8 cnodes trace1M final/prune/55With8Clients/run${i};
done
