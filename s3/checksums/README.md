l## Create a new s3 bucket 

```md
aws s3 mb s3://checksums-example-ab-123331
```


## create a file that will do checksums 

```
echo 'Hello Mars' > file.txt
```

## Get a checksum of file for md5 

```md
md5sum file.txt

8ed2d86f12620cdba4c976ff6651637f  file.txt
```

## upload file to s3 bucket 

```sh
aws s3 cp file.txt s3://checksums-example-ab-123331/file.txt 
aws s3api get-object --bucket checksums-example-ab-123331 --key file.txt 
``` 

## lets upload a file with a different checksum 


```sh
aws s3api put-object \
--bucket="checksums-example-ab-123331" \
--key="myfilecrc32.txt" \
--body="/workspaces/AWS-examples/s3/checksums/file.txt" \
--checksum-sha1="c28ccc2c5e214036806014df9fb43634f3e770b2" \
--checksum-algorithm="SHA1"
```