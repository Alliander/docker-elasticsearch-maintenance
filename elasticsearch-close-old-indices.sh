#!/bin/bash

usage()
{
cat << EOF

elasticsearch-close-old-indices.sh

Compares the current list of indices to a configured value and closes any
indices surpassing that value. Sort is lexicographical; the first n of a 'sort
-r' list are kept, all others are closed.


USAGE: ./elasticsearch-close-old-indices.sh [OPTIONS]

OPTIONS:
  -h    Show this message
  -i    Indices to keep open (default: 14)
  -e    Elasticsearch URL (default: http://localhost:9200)
  -g    Consistent index name (default: logstash)

EXAMPLES:

  ./elasticsearch-close-old-indices.sh

    Connect to http://localhost:9200 and get a list of indices matching
    'logstash'. Keep the top lexicographical 14 indices, close any others.

  ./elasticsearch-close-old-indices.sh -e "http://es.example.com:9200" \
  -i 28 -g my-logs

    Connect to http://es.example.com:9200 and get a list of indices matching
    'my-logs'. Keep the top 28 indices, close any others. When using a custom
    index naming scheme be sure that a 'sort -r' places the indices you want to
    keep at the top of the list. Output index closes to stdout

EOF
}

# Defaults
ELASTICSEARCH="http://localhost:9200"
KEEP=14
GREP="logstash"

# Validate numeric values
RE_D="^[0-9]+$"

while getopts ":i:e:g:o:h" flag
do
  case "$flag" in
    h)
      usage
      exit 0
      ;;
    i)
      if [[ $OPTARG =~ $RE_D ]]; then
        KEEP=$OPTARG
      else
        ERROR="${ERROR}Indexes to keep must be an integer.\n"
      fi
      ;;
    e)
      ELASTICSEARCH=$OPTARG
      ;;
    g)
      GREP=$OPTARG
      ;;
    ?)
      usage
      exit 1
      ;;
  esac
done

# If we have errors, show the errors with usage data and exit.
if [ -n "$ERROR" ]; then
  echo -e $ERROR
  usage
  exit 1
fi

# Get the indices from elasticsearch
INDICES_TEXT=`curl -s "$ELASTICSEARCH/_cat/indices?v" | awk '/'$GREP'/{match($0, /[:blank]*('$GREP'.[^ ]+)[:blank]*/, m); print m[1];}' | sort -r`

if [ -z "$INDICES_TEXT" ]; then
  echo "No indices returned containing '$GREP' from $ELASTICSEARCH."
  exit 1
fi


# Close indices
declare -a INDEX=($INDICES_TEXT)
if [ ${#INDEX[@]} -gt $KEEP ]; then
  for index in ${INDEX[@]:$KEEP};do
    # We don't want to accidentally close everything
    if [ -n "$index" ]; then
      echo -n `date "+[%Y-%m-%d %H:%M] "`" Closing index: $index."
      curl -s -XPOST "$ELASTICSEARCH/$index/_flush"
      curl -s -XPOST "$ELASTICSEARCH/$index/_close"
      echo "."
    fi
  done
fi

