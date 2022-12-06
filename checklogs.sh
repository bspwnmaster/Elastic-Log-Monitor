#!/bin/bash

#/etc/cron.d/elasticstatus
# Hourly check for no logs
#0 * * * * root /root/checklogs.sh 2>&1

#curl -XGET -K /opt/conf/example/elasticsearch/curl.config -k -s "https://X.X.X.X:9200/_cat/count" -H 'Content-Type: application/json' -d'
doc_count=$(curl -XGET -k -s "https://X.X.X.X:9200/_cat/count" -H 'Content-Type: application/json' -d'
{
  "query": {
          "range": {
            "@timestamp": {
              "gte": "now-1h",
              "lte": "now",
              "format": "epoch_millis"
      }
    }
  }
}')
doc_compare="$(echo $doc_count |  cut -d ' ' -f 3)"
last_mail="$(find /root/lastemailtime.txt -type f -mmin +720)" #Find if last alert sent more than 12 hours ago

if [ $doc_compare -eq 0 ] && [ $last_mail ]
then
    echo "Elasticsearch no logs in 1 hour." 2>&1 | mail -s "Elasticsearch Error" example@email[.]com
    touch /root/lastemailtime.txt
else
    exit 0
fi
