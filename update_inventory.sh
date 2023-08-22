#!/bin/bash

INSTANCE_TAG_KEY="Name"
INSTANCE_TAG_VALUE="terraform-cicd"

INSTANCE_ID=$(aws ec2 describe-instances --filters "Name=tag:$INSTANCE_TAG_KEY,Values=$INSTANCE_TAG_VALUE" --query "Reservations[0].Instances[0].InstanceId" --output text)

if [ -z "$INSTANCE_ID" ]; then
    echo "Instance with tag '$INSTANCE_TAG_KEY:$INSTANCE_TAG_VALUE' not found."
    exit 1
fi

PUBLIC_IP=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --query "Reservations[0].Instances[0].PublicIpAddress" --output text)

sed -i "2s|.*|$PUBLIC_IP ansible_ssh_user=ubuntu|" playbooks/inventory.yml