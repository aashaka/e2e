import statistics 
import sys
clients=[1,10,100,1000]#,10000]
mean_throughput=[]
std_throughput=[]
benchmark=sys.argv[1]
runs=1

for client in clients:

	tlist=[]
	sum_across_run=0
	for run in range(runs):
		sum_shards=0
		file='./data/'+benchmark+'/'+str(client)+'Clients/run'+str(run)+'.txt'
		with open(file, "r") as infile:
		  for line in infile:
		  	l = line.split(" ");
		  	shard_thru = int(l[2])
		  	sum_shards+=shard_thru
		tlist.append(sum_shards)
		print("Run ", run, ": ", sum_shards)
		sum_across_run+=sum_shards
	avg_thru = float(sum_across_run)/runs
#	std_thru = statistics.stdev(tlist)
	mean_throughput.append(avg_thru)
#	std_throughput.append(std_thru)

print(mean_throughput)
print(std_throughput)
print(clients)
