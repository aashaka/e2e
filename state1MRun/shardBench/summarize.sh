for i in {0..15}; do
  total=`head -n -2 ${1}/storage${i}.log | awk -F ' ' '{sum+=$2} END {print sum}'`
  ops=`head -n -2 ${1}/storage${i}.log | wc -l`
  echo "Shard $i: $(( ops*1000000000/total )) ops/s $ops ops $total ns"
done

