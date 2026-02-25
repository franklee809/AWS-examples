aws ec2-instance-connect send-ssh-public-key \
    --instance-id i-06910ebfc3f8d3848 \
    --instance-os-user root \
    --region ap-southeast-5 \
    --availability-zone ap-southeast-5c \
    --ssh-public-key file:///home/franklee/code/AWS-examples/ec2connect.pub

ssh -i "ec2connect" root@ec2-43-216-252-237.ap-southeast-5.compute.amazonaws.com