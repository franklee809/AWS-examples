
```bash

aws cloudformation validate-template \
    --template-body file:///root/AWS-examples/vpc/peering-connection/template-a.yml

aws cloudformation create-stack \
    --stack-name MyStack \
    --template-body file:///root/AWS-examples/vpc/peering-connection/template-a.yml \
    --capabilities CAPABILITY_IAM

```



```bash

aws cloudformation validate-template \
    --template-body file:///root/AWS-examples/vpc/peering-connection/template-b.yml

aws cloudformation create-stack \
    --stack-name MyStack2 \
    --template-body file:///root/AWS-examples/vpc/peering-connection/template-b.yml \
    --capabilities CAPABILITY_IAM

```