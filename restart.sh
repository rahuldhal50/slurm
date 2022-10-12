#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games

func="$(ps aux |grep ethminer| wc -l)"
 if [[ $func -eq 1 ]]
 then
   /opt/start.sh
 else
   gpu_load="$(nvidia-smi |grep '100%' |wc -l)"
   if [[ $gpu_load -lt 2 ]]
   then
    echo "$gpu_load"
    /opt/start.sh
   fi
 fi
