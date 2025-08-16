## Create a bucket 

aws s3 mb s3://class-fun-ab-123132213

echo 'Hello world' > hello-world.txt

aws s3 cp hello-world.txt s3://class-fun-ab-123132213/hello-world.txt --storage-class STANDARD_IA