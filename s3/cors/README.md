### Create a bucket  
aws s3api create-bucket --bucket frank-cors-example-123 --create-bucket-configuration="LocationConstraint=ap-southeast-1" 

### Change block public access
aws s3api put-public-access-block \
    --bucket frank-cors-example-123 \
    --public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"

### Create a bucket policy 
aws s3api put-bucket-policy --bucket frank-cors-example-123 --policy file://bucket-policy.json


### Turn on static website hosting 
aws s3api put-bucket-website --bucket frank-cors-example-123 --website-configuration file://website.json


### Upload our index.html file and include a resource that would be cross-origin
aws s3api put-object --bucket frank-cors-example-123 --key index.html --body index.html --content-type text/html

<!-- http://<BucketName>.s3-website-<Region>.amazonaws.com -->
<!-- http://frank-cors-example-123.s3-website-ap-southeast-1.amazonaws.com -->
### Apply a CORS policy 
aws s3api put-bucket-cors --bucket frank-cors-example-123 --cors-configuration file://cors-policy.json

curl -X POST -H "Content-Type: application/json" https://hl9avg95ti.execute-api.ap-southeast-1.amazonaws.com/prod/hello


### Clean up 

aws s3 rb s3://frank-cors-example-123 --force
