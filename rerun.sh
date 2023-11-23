#!/bin/bash

for i in {1..10} ; 
do
    bash ./launch-IntegraPlanetEarth-RelWithDebInfo.sh --dev &
    workTime=$(( $RANDOM % 30 + 20 ))
    echo "sleep - ${workTime} seconds"
    sleep $workTime
    ipePid=$(pgrep IntegraPlanetEa)
    ipePid="$(echo "$ipePid"|tr '\n' ' ')"
    echo "killing process with pid - ${ipePid}, iteration - ${i}"
    kill $ipePid
    idleTime=$(( $RANDOM % 4 + 3 ))
    echo "idle - ${idleTime} seconds"
    sleep $idleTime
done

