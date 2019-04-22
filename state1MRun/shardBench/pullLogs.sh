USERNAME="cc"
logDir=$1
ALL=($(<./livenodes))
mkdir -p ./logs/${logDir}/
for i in ${ALL[@]}; do
  echo "Pulling logs from ${i} to ${logDir}"
  scp -i ~/disaggregatedblockchain.pem  ${USERNAME}@${i}:~/logs/* ./logs/${logDir}/
done
