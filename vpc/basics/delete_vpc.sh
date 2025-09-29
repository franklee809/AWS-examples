#!/usr/bin/env bash

# VPC IGW SUBNET RT

# Check if the argument is not provided
if [ -z "$1" ]; then
  echo "Argument not provided."
else
  export VPC_ID="$1"
fi

REGION=${REGION:-ap-southeast-1}

# Retrieve non-main Route Table IDs
ROUTE_TABLE_IDS=( $(aws ec2 describe-route-tables \
  --filters Name=vpc-id,Values=$VPC_ID \
  --query 'RouteTables[?Associations[?Main==`false`]].RouteTableId' \
  --output text --region "$REGION") )

# Retrieve non-default Network ACL IDs
NACL_IDS=( $(aws ec2 describe-network-acls \
  --filters Name=vpc-id,Values=$VPC_ID \
  --query 'NetworkAcls[?IsDefault==`false`].NetworkAclId' \
  --output text --region "$REGION") )

# Retrieve non-default Security Group IDs
SG_IDS=( $(aws ec2 describe-security-groups \
  --filters Name=vpc-id,Values=$VPC_ID \
  --query 'SecurityGroups[?GroupName!=`default`].GroupId' \
  --output text --region "$REGION") )

# 1) Internet Gateway
export IGW_ID=$(
  aws ec2 describe-internet-gateways \
    --filters Name=attachment.vpc-id,Values=$VPC_ID \
    --query 'InternetGateways[0].InternetGatewayId' \
    --output text
)

# 2) Pick the first Subnet
export SUBNET_ID=$(
  aws ec2 describe-subnets \
    --filters Name=vpc-id,Values=$VPC_ID \
    --query 'Subnets[0].SubnetId' \
    --output text
)

# 3) Main Route Table ID
export RT_ID=$(
  aws ec2 describe-route-tables \
    --filters Name=vpc-id,Values=$VPC_ID \
    --query 'RouteTables[0].RouteTableId' \
    --output text
)

# 4) Association ID between that Route Table and the Subnet
export ASSOC_ID=$(
  aws ec2 describe-route-tables \
    --route-table-ids $RT_ID \
    --query "RouteTables[0].Associations[?SubnetId=='$SUBNET_ID'].RouteTableAssociationId" \
    --output text
)


# detach the IGW
aws ec2 detach-internet-gateway --internet-gateway-id $IGW_ID --vpc-id $VPC_ID

# delete the IGW

# dissaociate subnet

aws ec2 disassociate-route-table --association-id $ASSOC_ID

# delete subnet
aws ec2 delete-subnet --subnet-id $SUBNET_ID

# delete route table
aws ec2 delete-route-table --route-table-id $RT_ID

# Automatically detect and delete non-default Security Groups associated with the VPC
SG_IDS=$(aws ec2 describe-security-groups --filters Name=vpc-id,Values=$VPC_ID --query 'SecurityGroups[?GroupName!=`default`].GroupId' --output text --region "$REGION")
if [ -n "$SG_IDS" ]; then
  for SG_ID in $SG_IDS; do
    echo "Deleting Security Group: $SG_ID"
    aws ec2 delete-security-group --group-id "$SG_ID" --region "$REGION"
    echo "Deleted Security Group: $SG_ID"
  done
else
  echo "No non-default Security Groups found associated with VPC $VPC_ID"
fi

# delete vpc

aws ec2 delete-vpc --vpc-id $VPC_ID