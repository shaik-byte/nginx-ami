#!/bin/bash
set -e

INSTANCE_ID=$1
REGION=$2

echo "Getting public IP..."
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "Waiting for instance to be ready..."
sleep 30

echo "Curling Nginx..."
if curl -s --connect-timeout 5 "http://$PUBLIC_IP" | grep -qi "nginx"; then
  echo "✅ Nginx is running!"
else
  echo "❌ Nginx is NOT running."
  exit 1
fi

echo "Terminating instance..."
aws ec2 terminate-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
