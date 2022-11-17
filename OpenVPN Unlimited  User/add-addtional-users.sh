#!/bin/bash

OVPN_DATA=/root/OpenVPN/openvpn_data

echo -e "\n$OVPN_DATA\n"

export OVPN_DATA

echo -e "\nMust type -----> no <------ in small letters, otherswise existing data will be lost from Database\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn ovpn_initpki

sleep 1

read -p "Please Provide Your Client Name " CLIENTNAME

echo -e "\nI am adding a client with name $CLIENTNAME\n"

#docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME nopass

docker run -v $OVPN_DATA:/etc/openvpn --rm -it quickbooks2018/openvpn easyrsa build-client-full $CLIENTNAME

echo -e "\nWe are now at 6TH Step, don't worry this is last step, you lazy GUY,Now we retrieve the client configuration with embedded certificates\n"


echo -e "\n$CLIENTNAME ok\n"

docker run -v $OVPN_DATA:/etc/openvpn --rm quickbooks2018/openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn

# END
################################################################################################################################################

----------------------------------------> Enter in to the Container & Remove the User <---------------------------------------------------------
#To revoke a client or user

# Container Id 03670e2a6bd3 & Container Name is OpenVPN


# docker exec -it  03670e2a6bd3 bash

### Run this command inside container ###
# ovpn_revokeclient qasim remove

# docker exec -it OpenVPN bash
### Run this command inside container ###
# ovpn_revokeclient asim remove
