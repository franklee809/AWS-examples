## Create a bucket 

aws s3 mb s3://encryption-frank-associate-1232


### Create a file 
echo "Hello World" > hello.txt
aws s3 cp hello.txt s3://encryption-frank-associate-1232


### Put Object with encryption of KMS 

aws s3api put-object --bucket encryption-frank-associate-1232 --key hello.txt --body hello.txt \
--server-side-encryption aws:kms --sse-kms-key-id "xczcxzczczcxzczcz"


### Donwload the object
aws s3 cp s3://encryption-frank-associate-1232/hello.txt hello.txt

### Put object with SSE-C

export BASE_64_ENCODED_KEY=$(openssl rand -base64 32)

<!-- echo -n $BASE_64_ENCODED_KEY | base64 --decode | md5sum | awk '{print $1}' | base64 -->
export MD5_VALUE=$($BASE_64_ENCODED_KEY | base64 | md5sum | awk '{print $1}' | base64 -w0)
echo $MD5_VALUE

aws s3api put-object --bucket encryption-frank-associate-1232 --key hello.txt --body hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE_64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE
  