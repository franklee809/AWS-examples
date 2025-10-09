```bash

aws ec2 describe-vpcs \
  --query "Vpcs[].{Name: Tags[?Key=='Name']|[0].Value, VpcId: VpcId, IsDefault: IsDefault}" \
  --output table
  
aws ec2 create-network-acl --vpc-id vpc-09a28a7b7058f06b6 
```



### GET the latest AMI for amazon linux 2 

```bash
aws ec2 describe-images \
  --owners amazon \
  --filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" \
           "Name=state,Values=available" \
           "Name=virtualization-type,Values=hvm" \
           "Name=root-device-type,Values=ebs" \
  --region ap-southeast-1 \
  --output table

```


### Add entry 

```bash
aws ec2 create-network-acl-entry \
  --network-acl-id acl-0731f82f20e36a61 \
  --ingress \
  --rule-number 100 \
  --protocol tcp \
  --port-range From=0,To=65535 \
  --rule-action allow \
  --cidr-block 175.137.59.124/32 \ 
  --rule-action deny
```

### Validate the template yaml format  

```bash
aws cloudformation validate-template --template-body  file:///root/AWS-examples/vpc/nacl/template.yml 

```


### Execute the stack cloudformation

```bash

aws cloudformation create-stack \
    --stack-name MyEc2 \
    --template-body file:///root/AWS-examples/vpc/nacl/template.yml \
    --capabilities CAPABILITY_IAM \
    --region ap-southeast-1 
```
