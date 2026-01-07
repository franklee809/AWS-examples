## Convert to json 

```bash

yq -o json template.yml > policy.json

```

# The bash script 


```bash

./convert

```

# Create IAM Policy
```bash

aws iam create-policy \
    --policy-name my-s3-policy \
    --policy-document file:///root/code/AWS-examples/iam/policy/policy.json

```


## Attach policy to user 

```bash
aws iam attach-user-policy \
    --policy-arn arn:aws:iam::444051961052:policy/my-s3-policy \
    --user-name aws-examples

```


### Run the script to verify permission

```bash
aws s3 ls 

```