# Dockerfile metadata
FROM elasticsearch:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Elasticsearch configuration files
COPY . .

# Generate a CA certificate (needed to sign X.509 certificates)
USER root
RUN elasticsearch-certutil ca --silent --pem \
    --out config/certs/ca.zip &&\
    unzip config/certs/ca.zip -d config/certs 

# Generate X.509 certificates for mutual authentication between Elasticsearch, Kibana, Logstash, and Elastalert
RUN elasticsearch-certutil cert --silent --pem \
    --in config/certs/instances.yml \
    --ca-cert config/certs/ca/ca.crt \
    --ca-key config/certs/ca/ca.key \
    --out config/certs/elastic.zip &&\ 
    unzip config/certs/elastic.zip -d config/certs 

# Reorganize and restrict Elasticsearch files
RUN mv config/certs/*/* config/certs/ &&\
    rm -r config/certs/instances.yml config/certs/*/ config/certs/*.zip &&\
    chmod g+w config/ 

# Switch user accounts back to Elasticsearch
USER elasticsearch