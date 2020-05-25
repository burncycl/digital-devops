provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
  profile = var.account
  assume_role {
    role_arn     = var.deploy_role
    session_name = "Deploy_tf"
  }
}

resource "aws_ecr_repository" "repo" {
  count = length(var.repos)
  name  = var.repos[count.index]
}

# Outputs
output "registry_id" {
  description = "The account ID of the registry holding the repository."
  value       = aws_ecr_repository.repo[*].registry_id
}

output "repository_url" {
  description = "The URL of the repository."
  value       = aws_ecr_repository.repo[*].repository_url
}
