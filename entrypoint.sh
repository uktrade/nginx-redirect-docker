#!/bin/bash -xe

aws s3 cp --sse AES256 $S3_SRC vars.yml

ansible-playbook main.yml

nginx -g "daemon off;"
