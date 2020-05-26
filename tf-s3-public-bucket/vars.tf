variable "region" {
  default = "us-west-2"
}

variable "account" {
  default = "default"
}

# Role managed by tf-automation-iam-role
variable "deploy_role" {
  default = "arn:aws:iam::351484734788:role/automation-role"
}

variable "bucket_name" {
  default = "digital-devops-images"
}
