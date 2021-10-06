#!/bin/bash

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
#echo $doc_compare
if [ $doc_compare -eq 0 ]
then
    echo "Elasticsearch no logs in 1 hour." 2>&1 | mail -s "Elasticsearch Error" example@gmail[.]com
else
    #echo "Elasticsearch." 2>&1 | mail -s "Deez" example@gmail[.]com
    exit 0
fi
