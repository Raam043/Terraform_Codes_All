#!/bin/bash
#Purpose: To Update Private-hosted-zone strimzi kafka bridge
#Maintainer: Muhammad Asim <quickbooks2018@gmail.com>
#https://stackoverflow.com/questions/4922943/test-if-remote-tcp-port-is-open-from-a-shell-script

 
bridge="kafka.cloudgeeks.ca"
health=`timeout 2 bash -c "</dev/tcp/"$bridge"/8080"; echo $?`
if [ "$health" = "0" ]
then
 echo "Bridge is Up & Running"
 exit 200
else
 echo "Birdge is down time to update route53"

 

# Route53 Section


kafkabridge1=`kubectl get endpoints cloudgeeks-ca-bridge-exposed -n kafka -o yaml | grep -i ip | head -n1 | awk -F ':' '{print $2}'`
export kafkabridge1

kafkabridge2=`kubectl get endpoints cloudgeeks-ca-bridge-exposed -n kafka -o yaml | grep -i ip | head -n3 | tail -n1 | awk -F ':' '{print $2}'`
export kafkabridge2

kafkabridge3=`kubectl get endpoints cloudgeeks-ca-bridge-exposed -n kafka -o yaml | grep -i ip | head -n5 | tail -n1 | awk -F ':' '{print $2}'`
export kafkabridge3

kafkabridge4=`kubectl get endpoints cloudgeeks-ca-bridge-exposed -n kafka -o yaml | grep -i ip | head -n7 | tail -n1 | awk -F ':' '{print $2}'`
export kafkabridge4

kafkabridge5=`kubectl get endpoints cloudgeeks-ca-bridge-exposed -n kafka -o yaml | grep -i ip | head -n9 | tail -n1 | awk -F ':' '{print $2}'`
export kafkabridge5

hostedzoneid="Z01622182BHQRDJZMW08Q"
file="record.json"
domain="kafka.cloudgeeks.ca"


cat << EOF > $file
{
  "Comment": "Update the A record set",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "$domain",
        "Type": "A",
        "TTL": 10,
        "ResourceRecords": [
          {
            "Value": "$kafkabridge1"
          },
          {
            "Value": "$kafkabridge2"
          },
          {
            "Value": "$kafkabridge3"
          },
          {
            "Value": "$kafkabridge4"
          },
          {
            "Value": "$kafkabridge5"
          }
          
        ]
      }
    }
  ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id $hostedzoneid --change-batch file://$file


fi

#END
