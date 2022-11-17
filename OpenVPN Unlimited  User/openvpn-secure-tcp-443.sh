#!/bin/bash
# Author: Muhammad Asim
# Purpose: Setup OpenVPN in quick time.

# Docker Installation for Ubuntu
#sudo apt update -y > /dev/null
#
#sudo apt install -y curl > /dev/null
#
#sudo curl -fsSL https://get.docker.com -o get-docker.sh > /dev/null
#
#sudo sh get-docker.sh > /dev/null
#
#sudo curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose > /dev/null
#
#sudo chmod +x /usr/local/bin/docker-compose > /dev/null
#
#sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose > /dev/null

# Docker Installation for AmazonLinux

yum install -y docker

systemctl restart docker

systemctl enable docker

#We we are pulling the best Image of docker for OpenVPN on earth.

echo -e "\nWe we are pulling the best Image of OpenVPN for docker on earth by quickbooks2018/openvpn\n"

docker pull quickbooks2018/openvpn

#Step 1

echo -e "\nStep 1\n"
sleep 1
echo -e "\nPerforming Step 1, we are going to make a directory at /root/OpenVPN/openvpn_data\n"

mkdir -p /root/OpenVPN/openvpn_data


OVPN_DATA=/root/OpenVPN/openvpn_data

echo -e "\n$OVPN_DATA\n"

export OVPN_DATA

sleep 1
read -p "Please enter your Server Main IP Address IP/DNS: " IP

echo -e "\nYour Server IP is $IP\n"

#Step 2
echo -e "\nStep 2\n"
docker run -v $OVPN_DATA:/etc/openvpn --rm quickbooks2018/openvpn ovpn_genconfig -u tcp://$IP


echo -e "\nAfter a Shortwhile You need to enter your Server Secure Password details please wait ...\n"

#Step 3
sleep 3

echo -e "\nWe are now at Step 3\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn ovpn_initpki



#Step 4
sleep 1
echo -e "\nStep 4, We are Starting OpenVPN server process please wait ...\n"

docker run --name openvpn -p 443:1194/tcp -v $OVPN_DATA:/etc/openvpn -d  --restart unless-stopped --cap-add=NET_ADMIN quickbooks2018/openvpn

sleep 3

echo "\nSee I am up and running Alhumdulliah\n"

docker ps -a

echo -e "\nMy name is OpenVPN, I am running inside the container name OpenVPN\n"

sleep 3

#Step 5
echo -e "\nWe are now at 5th Step, Generate a client certificate with  a passphrase SAME AS YOU GIVE FOR SERVER...PASSPHRASE please wait...\n"

sleep 1
read -p "Please Provide Your Client Name " CLIENTNAME

echo -e "\nI am adding a client with name $CLIENTNAME\n"

#docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME nopass

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME

#Step 6
echo -e "\nWe are now at 6TH Step, don't worry this is last step, you lazy GUY,Now we retrieve the client configuration with embedded certificates\n"


echo -e "\n$CLIENTNAME ok\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm quickbooks2018/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

#END



################################################################### Update your .ovpn file sample ###########################################################

client
nobind
dev tun
remote-cert-tls server

remote vpn.saqlainmushtaq.com 443 tcp -------------------------------------------> Very Important

# For DNS

remote YOURIP/DNS 25530 udp
dhcp-option DNS  10.20.4.77
dhcp-option DNS  10.20.5.160
dhcp-option DOMAIN cloudgeeks.ca.local

<key>
-----BEGIN ENCRYPTED PRIVATE KEY-----
MIIFHDBOBgkqhkiG9w0BBQ0wQTApBgkqhkiG9w0BBQwwHAQIaPkMj3iJqt0CAggA
MAwGCCqGSIb3DQIJBQAwFAYIKoZIhvcNAwcECF4CuljjpZuNBIIEyKtsJPgOW0x9
kuDKBz8Uaivbzcup8bzwrjvQ3+T/2deoJ1c2Gxm992fzeE+DaQjL1FwHEJFT9b/P
nxIRcpNjPLA1ZzJ+ipKUtYZbRQ1v/YimXbx5KNPizdrKKzS2lcXog2Oij3Il3M5t
P6Ls5Y0RbczVzXdmb2mtq9iHabyjfDwnWQosvH1PQ952zguKYR0nilAMNr37uCvd
sU3Vgf+5SazruVQu15gfgJzweLXCj08K6HBuixA/Kfb7z8mut1TdPlcHLiuPuRSj
Ab8PFTL/U2xVEBdRycUSblNKhWgULDgKmCWTQTa+RFtfowhT5Q1CIbxioBSrG0Ky
9SZRGnF5ddSB5iFGkbb32OF9tcCyLrlisJZNNKq8bKbJOuH1AfEOrlOuE7iVulOW
TcQlFf0m1TRHY0nvDxWZWEXN0VXjb5p2Ben754TUk7YOMsbYmx5bqe0K7OCWLpTK
Ec2ky6M2YjJ5PLoMGIN6YU/+Iw4fefbFGH18LVvvGU6+5xT+QCbHnzm54OGve4qo
EpHmSDHCWx7ZR5xuevV6shId2vnf3EEjdM0i/hGEy0H/DOIKCOJt9sWoJUnZhS/6
1wU9/9c2F4VejhLuyjl81mouGUvZ6LdaYdv6Dr+UKw9xmEUwMEXw/NCWQjoSXvUe
kIV26v9CRlrBGxCIUqi8oa72tdQmaDWtHd5nc32aQ6A2YYStv5MMmuuYR4CQOuc7
oeB4IIZKLM0KHDv+2Mcc7fw8XRrjhQxTf5BG6gt1XvgmKIuibLrDK2bs6AotuaY5
1OsQJdvMxAUZQbHQ9uMGp0l35CRgcobnopRd8003Eu5rUk07NvhUpYGk+INJVBhG
i5Zt6WPqP/6WMM44i8eUUqM7D0SIw/Pmij4jbi8naSVSKF7G7v5EczvCW9jRlljY
M/Oe/O8pxWIpGL6YrxJxRlzNnOJBgpU1Cw0y/CLjF0mhqyGQ1/v8h7JM5woLZkus
DDBrWFXEfKvk5RbFZtFW4Myxtm9u7vXHcZPRJHP/EW9uKQcSZe+sJ6lOSkYk5jvs
2xnAoEbYadmSmrUmZV0YC8wVcaRlgH4leU0hXg2hrV9ZrJ7+LXZ/ruuIKUiv0N8L
ygAgM/u6pgwqzzQSnvhoHtn8oAL7mlewoeXhWFkk8PpuzcOsZTZ0tRwIE+bDu2dl
4tvwwjvd07H6BBjhrqKUvlVy9VumVTzeOjfya8uVl9+2MW3yqZ7f4wXyu+0B3NWt
eLYxkmH6/jel+c/RPTKGMbN+Vgojs4KL0xIqJFmwtyyTkeRJRHKR9B/ssJRidfme
XUfiAP+fx/gtj9UzZWHSS5six28Zirn8Wy9VsaWZQFRtrWi/XL/ikXwHeryYI218
chHhcuwvvuGLgKwTzcdjJqCL/DLKuPbm3UqGG1AT33ppQLUAiUl7DinjQUKpoh8x
tvOnDo4VCSfJ1gWBZOe7Tu7xSIJv+cduCvtFP03ioq3aZ4GY/GwS5swUqwSmgFL2
4AZU865qqnFBTKAd+spP15BseAFdL49oI+2JSHYzfeWQ9/Hrm1jcM2F3IcdQ3PpB
RgEMI7/ph+U6flb3RseykS5bdGN5WNDmHBQiiJhu6hJ5w7yORc2Zt67YzE1WTuE1
NEITYw9OEuOnUUgRx+usGA==
-----END ENCRYPTED PRIVATE KEY-----
</key>
<cert>
-----BEGIN CERTIFICATE-----
MIIDUjCCAjqgAwIBAgIQDKKo9fV2IfbNe4tc0CccdTANBgkqhkiG9w0BAQsFADAW
MRQwEgYDVQQDDAtFYXN5LVJTQSBDQTAeFw0yMDA5MjYwNjI2MDZaFw0yMzA5MTEw
NjI2MDZaMA8xDTALBgNVBAMMBHRlc3QwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQD4asTIlAgJmeJ6fCFqq70yX9uY2uxmWVhWUOAShngnXhhnOpgXIFAf
B2mdKVtbe2onZV8EpYZqUlLj0fXsZf3y08OUBWbA3/js2ZSjm752SwFDoBsnfRjn
d9nGnKPzlXfcAn2sqSgHTpqq/d61PwfGP8AVPgjk3p/FaRnOiuhMiJDmx00JiKTX
mfIbCSVIJAo328s4DYi4N2FsR9UuL9FRaCSucVTy9L7QISAYgUA18brYHMiFV+DF
2Rj9IxnKRL29I8puhRmN2RFfwWNL/ITvyQr4hwDXH5Ga1+bIgT6kdaVnM6Dz7D0/
m2hV+45Km8NeTb7UToaKXJSXB5g2e5dDAgMBAAGjgaIwgZ8wCQYDVR0TBAIwADAd
BgNVHQ4EFgQUGLmA9sr3hxCT42WQ3ICVxqbyRokwUQYDVR0jBEowSIAUiscQutB7
hRL87W0CnElJTo026QyhGqQYMBYxFDASBgNVBAMMC0Vhc3ktUlNBIENBghQpmI0y
CPMP3h6nvhE9v/B9qXv1ZTATBgNVHSUEDDAKBggrBgEFBQcDAjALBgNVHQ8EBAMC
B4AwDQYJKoZIhvcNAQELBQADggEBABHR0aXPRNPxXQrCUsd/l64zrHUFPDBWzWXR
YbdMXb7k+kHbwwwD8rUA7/G2z7fV152MYKyutwf/hA5/v9IA5TIJQvaBP0Tviwe1
XCNbU3J5McaZgqQdHibhaOIIqBhhmj3diWTV2MIDWk0f24Pdttcn3eJsYbKlkQ+7
J6j0qpvjT6s4bGfvlAW02FSbsvgUYRFhnFxVhah8ibW9NDwdjY70B61eDQahlU/o
RzHSnJnddxGa3eqTh4mSvsfSemK6x1K2vfAHpDzfT5jk1hWF9Eff/klUxMEoBvAm
NKnITdEVJEzPSH/uEI+I3ZwXg9lLyHcn0Z2eISCuJiWXswHlA+c=
-----END CERTIFICATE-----
</cert>
<ca>
-----BEGIN CERTIFICATE-----
MIIDSzCCAjOgAwIBAgIUKZiNMgjzD94ep74RPb/wfal79WUwDQYJKoZIhvcNAQEL
BQAwFjEUMBIGA1UEAwwLRWFzeS1SU0EgQ0EwHhcNMjAwOTI2MDYyNDUzWhcNMzAw
OTI0MDYyNDUzWjAWMRQwEgYDVQQDDAtFYXN5LVJTQSBDQTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBAMCq7JeYwC89jaAbte6h3944ChY7ODcrnudsa/Uv
gXwNPrODESmhz3a4fCl0pz+NoLlYCPQjHxGemfUS8ja4Kzr6xGVQ8u4OuaD3Cquw
0LbUWLnwAWUQMSgn78KOWLuvtL2jxAcBmC05kZFcP6/edrVpZ+idibsH8n24+MU7
1Zg2tOsT1wITfN2lF7BnJrf43+byCTEaRUgCCpWHYlS+boHYlotHW0o3cpp5e6r8
tgpD94KPiWl/psC+mWx2dA1ZRowudb+GU9mW/9q4WdJX/f4TNDiqZ1T3rShv/mJr
ZtDMKOa63MmohwTTdWZNUKtBqa+uYw1zZB4AXcZnGKm6HnsCAwEAAaOBkDCBjTAd
BgNVHQ4EFgQUiscQutB7hRL87W0CnElJTo026QwwUQYDVR0jBEowSIAUiscQutB7
hRL87W0CnElJTo026QyhGqQYMBYxFDASBgNVBAMMC0Vhc3ktUlNBIENBghQpmI0y
CPMP3h6nvhE9v/B9qXv1ZTAMBgNVHRMEBTADAQH/MAsGA1UdDwQEAwIBBjANBgkq
hkiG9w0BAQsFAAOCAQEAKhHr8/rCOurKoO6LCGSjsUAWJTSoFtVe7qlIjeXbntiz
uZTq40P0lVZsBAN4QjUJFDZvdsZiLIOwDEx7mXAHlN+TkWNucYa+/k6IAXv5c5aD
Yk3wnF8u6XEjIkKLsO1+noA6g5n2ryN0TdOX/lcZpi+lOuH/hNFAWh0qEPmYes1E
TIVdbGAubnx3emunb1OZ2cTiRlXc7WsZtVGZd8u00gB7sFMCEBycM4OJRRX2E/0u
mPcMGSHT/dzElUeU4eRTtYj+JfXC+BJeBiHCaQu8yzSZXDP0sgwhyjIsZ2qn/s6P
JTs3p/t5EZgkb9QuYsd0THjdzhjHRnL7euZx/yo3ug==
-----END CERTIFICATE-----
</ca>
key-direction 1
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
faf7ae29eb27de004cb0d61b7ac156e9
7bc6b4fcb2202299a5267f179964e898
f08cf3b2542f225e828faf2c64f8bff3
e7939ac74b3b0e77634d5148263f9fa0
cd9a6abbc727d8ff5d7e5c607fbfde52
c80ee22b805320793d7d5c152a53a2ad
d4864dd7dec5bd685effbd81c76b11b5
84adccec038654c576e3c72e377a50ca
c9431a5f0989962cbb23abcc322848a8
4b2e6b92282294434cf2dbe81d0b4b86
b0e139249874533847585c6b724d0caa
6a1b97b837e1d76c43493c7cd17ef166
37708be54e6b8410c53c165930bd4cbe
c67556f6337f874625d06735e86666a0
516635ba10177bb78675b992ec2956d0
000d63a3b011109d2db2a7282a75a5d1
-----END OpenVPN Static key V1-----
</tls-auth>

redirect-gateway def1
