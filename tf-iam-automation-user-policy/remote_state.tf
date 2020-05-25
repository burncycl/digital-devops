terraform {
  backend "s3" {
    bucket     = "tf-remote-state20200522220753917200000002"
    key        = "dev/iam-automation-user-policy"
    region     = "us-west-2"
    encrypt    = true
    kms_key_id = "dc70bb66-24c0-482d-a2a6-28667f207bc7"
  }
}

