#!/bin/bash
# OS: RHEL-7/8 Centos-7/8


ELASTIC_SEARCH_URL="vpc-abc-oeydc53oi53pes74763ztbukge.us-east-1.es.amazonaws.com:443"


# Java Requirement
# Install Java v8 (if it is lesser than v8)
yum -y install java-1.8.0-openjdk
yum -y remove java-1.7.0-openjdk
java -version


rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch


# Create Repo
# Create a file called logstash.repo in the /etc/yum.repos.d/ 
echo '[logstash-6.x]
name=Elastic repository for 6.x packages
baseurl=https://artifacts.elastic.co/packages/6.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
' | sudo tee /etc/yum.repos.d/elasticsearch.repo


# Install from RPM
yum -y install logstash


# Install the Amazon ES Logstash Output Plugin
/usr/share/logstash/bin/logstash-plugin update

/usr/share/logstash/bin/logstash-plugin install logstash-output-amazon_es

# Let’s create the input configuration:

cat << EOF > /etc/logstash/conf.d/10-input.conf
input {
  file {
    path => "/var/log/nginx/access.log"
    start_position => "beginning"
  }
}
EOF



# Our filter configuration: /etc/logstash/conf.d/20-filter.conf

cat << EOF > /etc/logstash/conf.d/20-filter.conf
ilter {
  grok {
    match => { "message" => "%{HTTPD_COMMONLOG}" }
  }
  mutate {
    add_field => {
      "custom_field1" => "hello from: %{host}"
    }
  }
}
EOF


# And lastly, our output configuration: /etc/logstash/conf.d/30-outputs.conf

#vNOTE- HERE YOU WILL PUT THE ELASTICSEARCH ENDPOINT

cat << EOF > /etc/logstash/conf.d/30-outputs.conf
output {
  amazon_es {
      hosts => ["$ELASTIC_SEARCH_URL"]
      index => "new-logstash-%{+YYYY.MM.dd}"
      region => "eu-west-1"
      aws_access_key_id => ''
      aws_secret_access_key => ''
  }
}
EOF


# Start LogStash
systemctl start logstash


# Status LogStash
systemctl status logstash




# END




# https://blog.ruanbekker.com/blog/2019/06/04/setup-a-logstash-server-for-amazon-elasticsearch-service-and-auth-with-iam/

# https://www.youtube.com/watch?v=YasrCKykAKo

# https://github.com/miztiik/elk-stack/tree/master/Logstash
