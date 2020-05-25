#!/bin/bash

# 2020/05 Michael Grate
# This will recursively replace the Terraform remote state bucket name and KMS key id.
# These values can be looked up in the AWS Console. 
# KMS: Browse to the proper region (e.g us-west-2) Customer Managed Keys. Locate name/remote-state alias.
# S3: Browse to S3. Locate bucket name tf-remote-stateXXXXXSUFFIX 

# New bucket and kms key id
NEW_TF_RSTATE_BUCKET_NAME="tf-remote-state20200522220753917200000002"
NEW_KMS_KEY_ID="dc70bb66-24c0-482d-a2a6-28667f207bc7"

# Old bucket and kms key id
OLD_TF_RSTATE_BUCKET_NAME="tf-remote-state20200522220753917200000002"
OLD_KMS_KEY_ID="dc70bb66-24c0-482d-a2a6-28667f207bc7"


egrep -lRZ ${OLD_TF_RSTATE_BUCKET_NAME} . | xargs -0 -l sed -i -e "s/${OLD_TF_RSTATE_BUCKET_NAME}/${NEW_TF_RSTATE_BUCKET_NAME}/g"
egrep -lRZ ${OLD_KMS_KEY_ID} . | xargs -0 -l sed -i -e "s/${OLD_KMS_KEY_ID}/${NEW_KMS_KEY_ID}/g"
