# Dockerfile metadata
FROM kibana:8.7.1
LABEL Author="Victor Fernandez III, @cyberphor"

# Copy Kibana configuration files
COPY . .

# Set the Kibana service account password and start Kibana
# TODO: make the code block below only run when the image is built
CMD curl -X POST https://localhost:9200/_security/user/kibana_system/_password \
    --cacert config/certs/ca.crt \
    -u "elastic:elasticsearch" \
    -H "Content-Type: application/json" \
    -d '{"password": "kibana"}' \
    -s &&\
    echo "Set Kibana password to 'kibana'" &&\
    /usr/local/bin/kibana-docker