### Apply cloudformation

```bash
aws cloudformation validate-template --template-body file:///root/code/AWS-examples/iam/types-of-policies/template.yml
```

### Execute the stack cloudformation

```bash
aws cloudformation create-stack \
  --stack-name iam-policy-types \
  --template-body file:///root/code/AWS-examples/iam/types-of-policies/template.yml \
  --capabilities CAPABILITY_NAMED_IAM
```