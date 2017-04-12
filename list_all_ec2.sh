#!/usr/bin/env bash
for r in $(aws ec2 describe-regions --region us-east-1 --output text | cut -f3); do
  my_instances=$(aws ec2 describe-instances --query 'Reservations[].Instances[].InstanceId' --filters "Name=tag:Owner,Values=arun.sanna" --output text --region $r)
  for instance in $my_instances; do
    aws ec2 create-tags --resources $instance --tags Key=\"ExpirationDate\",Value=$(date -d "+10days" +%Y-%m-%d) --region $r
    echo "updated tags for $instance in $r"
  done
done