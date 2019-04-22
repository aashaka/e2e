#!/bin/bash
USERNAME=cc
HOSTS=$(<$2)
echo ${HOSTS[@]}

INST_DEPS="chmod u+x /home/cc/deps_commands.sh; /bin/bash /home/cc/deps_commands.sh;"

get_logs(){
	mkdir ./logs
	for HOSTNAME in ${HOSTS} ; do
		scp -i ~/disaggregatedblockchain.pem ${USERNAME}@${HOSTNAME}:~/logs/* ./logs/${HOSTNAME}
	done
}

rm_logs(){
	for HOSTNAME in ${HOSTS} ; do
		ssh -i ~/disaggregatedblockchain.pem ${USERNAME}@${HOSTNAME} "rm ~/logs/*"
	done
}

setup(){
	for HOSTNAME in ${HOSTS} ; do single_setup "${HOSTNAME}" & done
}

send_client(){
	for HOSTNAME in ${HOSTS} ; do scp -i  ~/disaggregatedblockchain.pem ./rainblock-client ${USERNAME}@${HOSTNAME}:~/sosp19/client/rainblock-client & done
}

send_bench(){
	for HOSTNAME in ${HOSTS} ; do scp -i  ~/disaggregatedblockchain.pem ./benchClient.ts ${USERNAME}@${HOSTNAME}:~/sosp19/storage/src/ & done
}


send_state(){
	for HOSTNAME in ${HOSTS} ; do scp -i  ~/disaggregatedblockchain.pem ./state10M* ${USERNAME}@${HOSTNAME}:~/sosp19/storage/src/test_data/ & done
}

if [ $1 = "logs" ]; then
	get_logs
fi
if [ $1 = "sendfile" ]; then
	send_file
fi
if [ $1 = "sendstate" ]; then
	send_state
fi
if [ $1 = "removeLogs" ]; then
	rm_logs
fi
