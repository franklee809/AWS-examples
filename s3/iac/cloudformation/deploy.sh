#! /usr/bin/env bash 

echo '== deploy s3 bucket via cfn =='

STACK_NAME='cfn-s3-simple'

aws cloudformation deploy \
--template-file template.yml \
--region ap-southeast-1 \
--no-execute-changeset \
--stack-name ${STACK_NAME}  
