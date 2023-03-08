#!bin/bash

echo "Creating profile..."

aws configure set aws_access_key_id default_access_key --profile=localstack
aws configure set aws_secret_access_key default_secret_key --profile=localstack
aws configure set region us-east-1 --profile=localstack

echo "listing profiles..."

aws configure list --profile=localstack

echo "Build infra..."

aws --endpoint-url=http://localhost:4566 --profile=localstack cloudformation create-stack --stack-name localstack --template-body file:///docker-entrypoint-initaws.d/templates/infra.yml

echo "listing infra..."
aws --endpoint-url=http://localhost:4566 --profile=localstack sqs list-queues