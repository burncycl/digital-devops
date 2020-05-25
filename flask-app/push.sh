#!/bin/bash

# Refresh ECR auth
#$(aws ecr get-login --no-include-email --region us-west-2)

sleep 2

VER="v2"

# Push to ECR
docker tag digital-devops:${VER} 351484734788.dkr.ecr.us-west-2.amazonaws.com/digital-devops:${VER}
docker push 351484734788.dkr.ecr.us-west-2.amazonaws.com/digital-devops:${VER}
