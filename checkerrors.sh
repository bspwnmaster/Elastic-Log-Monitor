#!/bin/bash

checkme="$(grep -i "java.lang.OutOfMemoryError" /opt/so/log/logstash/logstash.log)"

if [ "$checkme" ]
then
    #echo "here"
    echo "Logstash Out Of Memory Error in /opt/so/log/logstash/logstash.log" 2>&1 | mail -s "Logstash Error" example@gmail[.]com
elif [ -z "$checkme" ]
then
    #echo "not here"
    exit 0
fi
