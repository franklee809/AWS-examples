### Create a bucket

aws s3 mb s3://sse-client-frank-solution-architect-0032


### Create a file

cd s3/sse-client
echo "Hello World" > hello.txt


## run the ruby encrypt file

bundle exec ruby encrypt.rb


### Clean up
aws s3 rb s3://sse-client-frank-solution-architect-0032 --force