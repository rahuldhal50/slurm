#!/bin/bash

while read -r line;
do
        count=$(sacct -X -n  --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=User,JobID,state | grep COMPLETED |wc -l)
	time=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=ElapsedRaw,state | grep COMPLETED | awk '{sum+=$1} END {print sum}' )
	queuetime=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=Reserved,state | grep COMPLETED | awk -F'[-:]' '{ if (NF == 4) {print ($1 * 3600 * 24) + ($2 * 3600) + ($3 * 60) + $4 } else print ($1 * 3600) + ($2 * 60) + $3 }' | awk '{sum+=$1} END {print sum}')
	cpu=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=ElapsedRaw,state,AllocTres%90 | grep COMPLETED | awk '{print $3}' | awk -F'[,]' '{if (NF == 4) {print$1} else {print$2}}'| awk -F'[=]' '{sum+=$2} END {print sum}')
	gpu=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=ElapsedRaw,state,AllocTres%90 | grep COMPLETED | awk '{print $3}' | awk -F'[,]' '{if (NF == 4) {print$2} else {print$3}}'| awk -F'[=]' '{sum+=$2} END {print sum}')
        mem=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=ElapsedRaw,state,AllocTres%90 | grep COMPLETED | awk '{print $3}' | awk -F'[,]' '{if (NF == 4) {print$3} else {print$4}}' | awk -F'[=]' '{print$2} ' | awk '{if ($0 ~ /G/) {print $1 *1000} else {print $1}}' | awk '{sum+=$1} END {print sum}')
	nodes=$(sacct -X -n --starttime 2021-09-01 --endtime 2021-10-01 -u $line --format=ElapsedRaw,state,AllocTres%90 | grep COMPLETED | awk '{print $3}' | awk -F'[,]' '{if (NF == 4) {print$4} else {print$5}}'| awk -F'[=]' '{sum+=$2} END {print sum}')
	if [  -z $count ] || [ $count == 0 ] 
        then
           averagetime=0		
        else
           averagetime=$(echo "scale=3 ; $time / $count / 60 / 60 " | bc)		
	fi   

        if [  -z $queuetime ] || [ $queuetime == 0 ] || [  -z $count ] || [ $count == 0 ]
        then
           averagequeuetime=0
        else
           averagequeuetime=$(echo "scale=3 ; $queuetime / $count / 60 / 60 " | bc)
        fi

        if [  -z $cpu ] || [ $cpu == 0 ] || [  -z $count ] || [ $count == 0 ]
        then
           averagecpu=0
        else
           averagecpu=$(echo "scale=0 ; $cpu / $count " | bc )
        fi

        if [  -z $mem ] || [ $mem == 0 ] || [  -z $count ] || [ $count == 0 ]
        then
           averagemem=0
        else
           averagemem=$(echo "scale=0 ; $mem / $count " | bc)
        fi	

        if [  -z $gpu ] || [ $gpu == 0 ] || [  -z $count ] || [ $count == 0 ]
        then
           averagegpu=0
        else
           averagegpu=$(echo "scale=0 ; $gpu / $count " | bc) 
        fi	

        if [  -z $nodes ] || [ $nodes == 0 ] || [  -z $count ] || [ $count == 0 ]
        then
           averagenodes=0
        else
           averagenodes=$(echo "scale=0 ; $nodes / $count " | bc )
        fi	

#        echo "$line,Jobs=$count,Avtime=$averagetime-hours,AvWaitingtime=$averagequeuetime-hours,AvCPU=$averagecpu,AvMem=$averagemem,AvGPU=$averagegpu,AvNodes=$averagenodes"
       echo "$line,$count,$averagetime,$averagequeuetime,$averagecpu,$averagemem,$averagegpu,$averagenodes"

done < users
