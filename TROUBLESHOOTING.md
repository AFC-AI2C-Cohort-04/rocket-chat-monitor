## Troubleshooting
This file documents some of the issues I have encountered and resolved while deploying a Docker-based Elastic stack.

**Max Memory is Too Low**  
> max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]

If you are getting the error above on a Windows-based computer, you can either (1) run the provided script or (2) invoke the Windows Subsystem for Linux (WSL), append `vm.max_map_count = 262144` to `/etc/sysctl.conf` and reload the WSL's kernel parameters. `sysctl` is a utility used for configuring kernel parameters at runtime. `sysctl -p` forces the kernel to reload parameters such as those saved in `/etc/sysctl.conf`. All of this is necessary when the WSL is used to run containers. By default, WSL-based containers are limited in the amount of memory they are allowed to use.  
```bash
Import-Module Elastic.psm1
Set-VirtualMemorySize
```

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

## References
* [https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
* [https://hub.docker.com/r/sebp/elk/](https://hub.docker.com/r/sebp/elk/)
* [https://elk-docker.readthedocs.io/](https://elk-docker.readthedocs.io/)
* [https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target](https://www.elastic.co/guide/en/logstash/current/plugins-codecs-json.html#plugins-codecs-json-target)
* [https://discuss.elastic.co/t/json-codec-plugin-target-option-http-input/304217/4](https://discuss.elastic.co/t/json-codec-plugin-target-option-http-input/304217/4)
* [https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash#enable-tls-kibana](https://www.elastic.co/blog/configuring-ssl-tls-and-https-to-secure-elasticsearch-kibana-beats-and-logstash#enable-tls-kibana)