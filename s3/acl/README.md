## Create a new bucket 

``` sh
aws s3api create-bucket --bucket frank-bucket-32323 --region ap-southeast-1 --create-bucket-configuration LocationConstraint=ap-southeast-1
```

### Turn off block public access for ACLs 

``` sh
aws s3api put-public-access-block \
--bucket frank-bucket-32323 \
--public-access-block-configuration "BlockPublicAcls=false,IgnorePublicAcls=false,BlockPublicPolicy=false,RestrictPublicBuckets=false"
``` 

```sh
aws s3api get-public-access-block --bucket frank-bucket-32323
```

## Change bucket ownership

``` sh
aws s3api put-bucket-ownership-controls \
--bucket frank-bucket-32323 \
--ownership-controls="Rules=[{ObjectOwnership=BucketOwnerPre ferred}]"
```

## Change ACL to allow another account to access the bucket

``` sh

aws s3api put-bucket-acl \
--bucket frank-bucket-32323 \
--access-control-policy "file:///workspaces/AWS-examples/s3/acl/policy.xml"
```


## Access Bucket from other account 
```sh
touch test.txt
aws s3 cp test.txt s3://frank-bucket-32323/test.txt --acl bucket-owner-full-control
aws s3 ls s3://frank-bucket-32323
aws s3 cp s3://frank-bucket-32323/test.txt ./test.txt
cat test.txt
```

### Clean up
```sh
aws s3 rb s3://frank-bucket-32323 --force
aws s3 ls s3://frank-bucket-32323
```