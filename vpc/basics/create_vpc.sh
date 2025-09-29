#!/usr/bin/env bash
set -euo pipefail

# Default configuration
REGION=${REGION:-ap-southeast-1}
VPC_CIDR=${VPC_CIDR:-172.1.0.0/16}
SUBNET_CIDR=${SUBNET_CIDR:-172.1.0.0/20}
AZ=${AZ:-${REGION}a}
VPC_NAME=${VPC_NAME:-MyVPC}
SUBNET_NAME=${SUBNET_NAME:-PublicSubnet}
IGW_NAME=${IGW_NAME:-InternetGateway}
RT_NAME=${RT_NAME:-PublicRouteTable}

# Create a VPC
VPC_ID=$(aws ec2 create-vpc --cidr-block "$VPC_CIDR" --instance-tenancy default --region "$REGION" \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=$VPC_NAME}]" \
    --query 'Vpc.VpcId' --output text)
echo "Created VPC: $VPC_ID"

# Enable DNS hostnames
aws ec2 modify-vpc-attribute --vpc-id $VPC_ID --enable-dns-hostnames "{\"Value\":true}" --region "$REGION"

# Create and attach an Internet Gateway
IGW_ID=$(aws ec2 create-internet-gateway \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=$IGW_NAME}]" \
    --query 'InternetGateway.InternetGatewayId' --output text --region "$REGION")
echo "Created IGW: $IGW_ID"
aws ec2 attach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID --region "$REGION"

# Create a Route Table and public route
RT_ID=$(aws ec2 create-route-table --vpc-id $VPC_ID \
    --tag-specifications "ResourceType=route-table,Tags=[{Key=Name,Value=$RT_NAME}]" \
    --query 'RouteTable.RouteTableId' --output text --region "$REGION")
echo "Created Route Table: $RT_ID"
aws ec2 create-route --route-table-id $RT_ID --destination-cidr-block 0.0.0.0/0 --gateway-id $IGW_ID --region "$REGION"

# Create a Public Subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block "$SUBNET_CIDR" \
    --availability-zone "$AZ" \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=$SUBNET_NAME}]" \
    --query "Subnet.SubnetId" --output text --region "$REGION")
echo "Created Subnet: $SUBNET_ID"

# Enable auto-assign public IP for the subnet
aws ec2 modify-subnet-attribute --subnet-id $SUBNET_ID --map-public-ip-on-launch --region "$REGION"

# Associate the Route Table with the Subnet
aws ec2 associate-route-table --route-table-id $RT_ID --subnet-id $SUBNET_ID --region "$REGION"
echo "Associated Subnet $SUBNET_ID with Route Table $RT_ID"

# Summary
echo "VPC ($VPC_ID), Subnet ($SUBNET_ID), IGW ($IGW_ID), and Route Table ($RT_ID) created and configured in $REGION."


# Add a route for our Route table to our IGW 
aws ec2 create-route \
--route-table $RT_ID \
--destination-cidr-block 0.0.0.0/0 \
--gateway-id $IGW_ID \
--region $REGION


