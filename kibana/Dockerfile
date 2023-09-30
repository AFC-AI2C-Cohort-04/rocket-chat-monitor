# Dockerfile metadata
FROM kibana:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Kibana configuration files
COPY . .

# Set the Kibana service account password and start Kibana
CMD curl -X POST https://172.16.0.10:9200/_security/user/kibana_system/_password \
    --cacert config/certs/ca.crt \
    -u "elastic:elasticsearch" \
    -H "Content-Type: application/json" \
    -d '{"password": "kibana"}' \
    -s &&\
    echo "Set Kibana password to 'kibana'" &&\
    /usr/local/bin/kibana-docker