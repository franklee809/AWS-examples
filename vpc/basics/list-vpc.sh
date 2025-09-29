#! /usr/bin/env bash 

VPC_ID="vpc-0c566845741245d5d" 
AWS_REGION="ap-southeast-1"

aws ec2 describe-internet-gateways --region $AWS_REGION --filters 'Name=attachment.vpc-id,Values='$VPC_ID | grep InternetGatewayId
aws ec2 describe-subnets --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep SubnetId
aws ec2 describe-route-tables --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep RouteTableId
aws ec2 describe-network-acls --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep NetworkAclId
aws ec2 describe-vpc-peering-connections --region $AWS_REGION --filters 'Name=requester-vpc-info.vpc-id,Values='$VPC_ID | grep VpcPeeringConnectionId
aws ec2 describe-vpc-endpoints --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep VpcEndpointId
aws ec2 describe-nat-gateways --region $AWS_REGION --filter 'Name=vpc-id,Values='$VPC_ID | grep NatGatewayId
aws ec2 describe-security-groups --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep GroupId
aws ec2 describe-instances --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep InstanceId
aws ec2 describe-vpn-gateways --region $AWS_REGION --filters 'Name=attachment.vpc-id,Values='$VPC_ID | grep VpnGatewayId
aws ec2 describe-network-interfaces --region $AWS_REGION --filters 'Name=vpc-id,Values='$VPC_ID | grep NetworkInterfaceId
# echo "Carrier Gateways (if supported):"
# aws ec2 describe-carrier-gateways --region $AWS_REGION --filters Name=vpc-id,Values=$VPC_ID 2>/dev/null | grep CarrierGatewayId || echo "Carrier Gateways not supported in region $AWS_REGION or none exist."
# aws ec2 describe-local-gateway-route-table-vpc-associations --region $AWS_REGION --filters Name=vpc-id,Values=$VPC_ID | grep LocalGatewayRouteTableVpcAssociationId
# aws ec2 describe-vpc-peering-connections --region $AWS_REGION --filters 'Name=accepter-vpc-info.vpc-id,Values='$VPC_ID | grep VpcPeeringConnectionId