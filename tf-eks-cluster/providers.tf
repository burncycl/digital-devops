provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
  profile = var.account
  assume_role {
    role_arn     = var.deploy_role
    session_name = "Deploy_tf"
  }
}

# Using these data sources allows the configuration to be generic for any region.
data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

# Not required: currently used in conjuction with using
# icanhazip.com to determine local worker external IP
# to open EC2 Security Group access to the Kubernetes cluster.
# See worker-external-ip.tf for additional information.
provider "http" {}
