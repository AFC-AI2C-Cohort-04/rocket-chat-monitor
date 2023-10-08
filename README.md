## rocket-chat-monitor
Rocket.Chat Monitor

### Usage
**Step 1.** Clone this repo.
```
git clone https://github.com/cyberphor/rocket-chat-monitor &&\
cd rocket-chat-monitor
```

**Step 2.** Build and run the containers using Docker Compose.
```
docker compose up 
```

**Step 3.** Open Kibana.
```
https://localhost:5601
```

### Troubleshooting
Listed below are issues and solutions I encountered while deploying a Docker-based Elastic stack.

**Max Memory is Too Low**  
> max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

If you are getting the error above on a Windows-based computer, enter the commands below.
```
# invoke the Windows Subsystem for Linux (WSL)
wsl -d docker-desktop -u root

# set the WSL kerne's "virtual memory areas max count" parameter
sysctl -w vm.max_map_count=262144

# reload the WSL kernel's parameters
sysctl -p

# exit WSL
exit
```

`sysctl` is a utility used for configuring kernel parameters at runtime. `sysctl -p` forces the kernel to reload parameters such as those saved in `/etc/sysctl.conf`. These steps are necessary when the WSL is used to run containers. By default, WSL-based containers are limited in the amount of memory they are allowed to use.  

**"Target" Option Was Not Specified**  
>  ECS compatibility is enabled but `target` option was not specified. This may cause fields to be set at the top-level of the event where they are likely to clash with the Elastic Common Schema. 

NOTE: I've since removed the fix below and only specify the port for Logstash to listen on. 

```bash
input {
  http {
    port => 1337
    additional_codecs => {} # <-- i added this line
    codec => json {
      target => "[document]"
    }
  }
}
```

**References**
* [https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
* [https://hub.docker.com/r/sebp/elk/](https://hub.docker.com/r/sebp/elk/)
* [https://elk-docker.readthedocs.io/](https://elk-docker.readthedocs.io/)
* [https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target)
* [https://discuss.elastic.co/t/json-codec-plugin-target-option-http-input/304217/4](https://discuss.elastic.co/t/json-codec-plugin-target-option-http-input/304217/4)
* [https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash#enable-tls-kibana](https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash#enable-tls-kibana)

## Copyright
This project is licensed under the terms of the [MIT license](/LICENSE).