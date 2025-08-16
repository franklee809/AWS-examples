### Create a bucket 

aws s3 mb s3://frank-example-18292313


### Create new bucket policy 

aws s3api put-bucket-policy --bucket frank-example-18292313 --policy file://policy.json


### In the other account access the s3 bucket 
touch test.txt
aws s3 cp test.txt s3://frank-example-18292313/test.txt
aws s3 ls s3://frank-example-18292313


### CLean up 
aws s3 rb s3://frank-example-18292313 --force