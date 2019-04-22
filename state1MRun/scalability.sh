numRuns=1

#TEST different pruneDepth
for ((i = 1; i <= ${numRuns}; i++)); do
  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 1 cnodes trace1M final/scale/1Clients/run${i};

  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 2 cnodes trace1M final/scale/2Clients/run${i};

  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 4 cnodes trace1M final/scale/4clients/run${i};

  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 6;
  ./run.sh 8 cnodes trace1M final/scale/8Clients/run${i};

  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 16 cnodes trace1M final/scale/16Clients/run${i};


  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 32 cnodes trace1M final/scale/32Clients/run${i};

  ./storage.sh start snodes 9;
  ./verifier.sh start 1 vnodes 9;
  ./run.sh 64 cnodes trace1M final/scale/64Clients/run${i};
done
