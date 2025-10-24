### Validate cloudformation template 
```bash
aws cloudformation validate-template \
  --template-body file:///root/AWS-examples/vpc/sg/template.yml
```



### Deploy cloudformation template 

```bash
aws cloudformation create-stack \
  --stack-name my-stack-security-group \
  --template-body file:///root/AWS-examples/vpc/sg/template.yml \
    --capabilities CAPABILITY_IAM \
    --region ap-southeast-1 
```


### Cleanup 

```bash

aws cloudformation delete-stack \
  --stack-name my-stack-security-group \
      --region ap-southeast-1 

  ```