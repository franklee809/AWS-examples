## Create a bucket 

```bash
aws s3 mb s3://metadata--fun-ab-1232

```

### Create a new file 


echo 'Hello Mars' > hello.txt

### Upload file with metadata


aws s3api put-object --bucket metadata--fun-ab-1232 --key hello.txt --metadata="Planet=Mars" --body hello.txt


### Get metadata through head object 

aws s3api head-object --bucket metadata--fun-ab-1232 --key hello.txt 

## cleanup 
aws s3 rb s3://metadata--fun-ab-1232 --force