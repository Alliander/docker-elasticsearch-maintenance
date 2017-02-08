FROM ubuntu
RUN apt-get update && apt-get install -y gawk && apt-get install -y curl

ADD elasticsearch-close-old-indices.sh /usr/local/bin/elasticsearch-close-old-indices.sh
ADD elasticsearch-remove-old-indices.sh /usr/local/bin/elasticsearch-remove-old-indices.sh
RUN chmod 755 /usr/local/bin/elasticsearch-close-old-indices.sh
RUN chmod 755 /usr/local/bin/elasticsearch-remove-old-indices.sh

CMD /usr/local/bin/elasticsearch-close-old-indices.sh -i 14 -e http://elasticsearch:9200 && /usr/local/bin/elasticsearch-remove-old-indices.sh -i 25 -e http://elasticsearch.kube-system:9200
