#!/bin/bash

############################################################
# $Name:         redis_discovery.sh
# $Function:     REDIS DISCOVERY
# $Description:  Monitor REDIS DISCOVERY
############################################################

port=(`sudo netstat -tpln | awk -F "[ :]+" '/redis/ && /0.0.0.0/ {print $5}'`)

printf '{\n'
printf '\t"data":[\n'
    for key in ${!port[@]}; do
         if [[ "${#port[@]}" -gt 1 && "${key}" -ne "$((${#port[@]}-1))" ]]; then
             socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
             printf '\t {\n'
             printf "\t\t\"{#REDISPORT}\":\"${port[${key}]}\"},\n"
         else [[ "${key}" -eq "((${#port[@]}-1))" ]]
             socket=`ps aux|grep ${port[${key}]}|grep -v grep|awk -F '=' '{print $10}'|cut -d ' ' -f 1`
             printf '\t {\n'
             printf "\t\t\"{#REDISPORT}\":\"${port[${key}]}\"}\n"
         fi
    done
printf '\t ]\n'
printf '}\n'
