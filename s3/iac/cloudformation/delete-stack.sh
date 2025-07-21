#! /usr/bin/env bash

echo '==Delete s3 bucket via cloudformation=='

STACK_NAME='cfn-s3-simple'

aws cloudformation delete-stack \
--stack-name $STACK_NAME \
--region ap-southeast-1