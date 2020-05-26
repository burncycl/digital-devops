terraform {
  backend "s3" {
    bucket     = "tf-remote-state20200522220753917200000002"
    key        = "dev/s3-digital-devops-images"
    region     = "us-west-2"
    role_arn   = "arn:aws:iam::351484734788:role/automation-role"
    encrypt    = true
    kms_key_id = "dc70bb66-24c0-482d-a2a6-28667f207bc7"
  }
}

