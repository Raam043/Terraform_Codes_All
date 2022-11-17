#!/bin/bash
# Purpose: ALB Ingress Setup


# Update me

StackName="cloudgeeksca-cluster-eks"
Region="us-east-1"
EksCluster="$StackName"

# Update Me
##############################################################################
Policy_Arn="arn:aws:iam::YOURAWSACCOUNT:policy/ALBIngressControllerIAMPolicy"
##############################################################################
export Region
# VPC ID
VPC_ID=`aws ec2 describe-vpcs --region ${Region} --filter Name=tag:Name,Values=${EksCluster} --query Vpcs[].VpcId --output text`

echo "Your Eks Cluster Vpc ID is "$VPC_ID""



# Create an IAM OIDC provider and associate it with your cluster. If you don't have eksctl version 0.14.0 or later installed, complete the instructions in Installing or Upgrading eksctl to install or upgrade it. You can check your installed version with eksctl version.

eksctl utils associate-iam-oidc-provider \
    --region $Region \
    --cluster $EksCluster \
    --approve

curl -# -LO https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/iam-policy.json

sleep 10

aws iam create-policy --policy-name ALBIngressControllerIAMPolicy --policy-document file://iam-policy.json

kubectl create serviceaccount alb-ingress-controller -n kube-system

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/rbac-role.yaml


eksctl create iamserviceaccount \
    --region $Region \
    --name alb-ingress-controller \
    --namespace kube-system \
    --cluster $EksCluster \
    --attach-policy-arn $Policy_Arn \
    --override-existing-serviceaccounts \
    --approve

# Deploy the ALB Ingress Controller with the following command.

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/alb-ingress-controller.yaml


kubectl describe sa alb-ingress-controller -n kube-system

echo -e "\nOpen the ALB Ingress Controller deployment manifest for editing with the following command\n"

echo -e "\nkubectl edit deployment.apps/alb-ingress-controller -n kube-system\n"

echo -e "\nThe line number is 41, at the  end of line press ENTER\n"

echo -e "- --cluster-name=$EksCluster"
echo -e "- --aws-vpc-id=$VPC_ID"
echo -e "- --aws-region=$Region"

echo -e "\n If ALB is not setup check the logs with mentioned below commands \n"


echo -e "\n    kubectl logs -n kube-system   deployment.apps/alb-ingress-controller   \n"


echo -e "\n Confirm that the ALB Ingress Controller is running with the following command\n"

echo -e "\n kubectl get pods -n kube-system \n"


#END