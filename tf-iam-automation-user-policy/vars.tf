variable "region" {
  default = "us-west-2"
}

variable "account" {
  default = "default"
}

# User Name to run Programmatic API only automation. 
variable "iam_user" {
  default = "automation"
}

variable "policy_name" {
  default = "automation-user-policy"
}

