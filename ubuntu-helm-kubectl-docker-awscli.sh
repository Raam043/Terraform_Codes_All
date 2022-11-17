# Docker Installation
# Ubuntu focal
# cat /etc/os-release

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh
rm -f get-docker.sh
systemctl start docker
systemctl enable docker


# Helm3 installation
# https://helm.sh/docs/intro/install/

curl -# -LO https://get.helm.sh/helm-v3.5.3-linux-amd64.tar.gz
tar -xzvf helm-v3.5.3-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v3.5.3-linux-amd64.tar.gz && rm -rf linux-amd64



# Install AWS Cli

apt update -y  2>&1 >/dev/null
apt  install awscli  -y   2>&1 >/dev/null
apt install python3-pip -y   2>&1 >/dev/null
pip3 install --upgrade --user awscli  2>&1 >/dev/null


# Kubectl Installation
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl

chmod +x ./kubectl

mv ./kubectl /usr/local/bin/kubectl
