### Create a user with no permission

```sh
aws iam create-user \
    --user-name Bob

aws iam create-access-key \
    --user-name Bob \
    --output table

aws configure 

input the access and secret key
```
make sure this profile no access to s3 

```sh
aws sts get-caller-identity --profile bob
```

### Create a role

create a role that will access a new resource 

```sh
chmod u+x bin/deploy
./bin/deploy
```


### Use new user credentials and assume role

Add aassume Role to identity policy for user bob
```sh
aws iam put-user-policy \
    --user-name Bob \
    --policy-name assumeRolePolicy \
    --policy-document file:///root/AWS-examples/api/sts/policy.json
```

```sh
aws sts assume-role \
    --role-arn "arn:aws:iam::444051961052:role/my-sts-fun-stack-STSRole-KdKg7wtmHG0Q" \
    --role-session-name "s3-sts-fun" \
    --profile bob

```
 
configure the temporary account
```sh

aws configure --profile assumed
aws configure set aws_session_token {xxx} --profile assumed
aws sts get-caller-identity --profile assumed
```


### Cleanup 

```sh
aws cloudformation delete-stack --stack-name my-sts-fun-stack
```