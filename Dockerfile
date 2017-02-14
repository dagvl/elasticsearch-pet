FROM elasticsearch:5.2.0

#RUN bin/plugin install lmenezes/elasticsearch-kopf/v2.1.2
RUN bin/elasticsearch-plugin install io.fabric8:elasticsearch-cloud-kubernetes:5.2.0

ENV BOOTSTRAP_MLOCKALL=false NODE_DATA=true NODE_MASTER=true ES_JAVA_OPTS=-Djava.net.preferIPv4Stack=true

# pre-stop-hook.sh and dependencies
RUN apt-get update && apt-get install -y \
    jq \
    curl \
 && rm -rf /var/lib/apt/lists/*
COPY pre-stop-hook.sh /pre-stop-hook.sh

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml
