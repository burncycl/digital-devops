provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
  profile = var.account
}

# Create IAM Role and attach trust policy
resource "aws_iam_role" "role" {
  name               = var.automation_role
  description        = "Access resources using AWS API for S3, SSM, etc."
  assume_role_policy = file("./trust-policy.json")
}

# Create Instance profile from the role
#resource "aws_iam_instance_profile" "role" {
#        name      = var.ec2_role
#        path      = "/"
#        role      = aws_iam_role.role.name
#}

# Use custom policy
resource "aws_iam_role_policy" "policy" {
  name   = var.automation_role
  role   = aws_iam_role.role.name
  policy = file("./iam-permissions-policy.json")
}

# Use existing polices
resource "aws_iam_role_policy_attachment" "policy" {
  count      = length(var.policy_arn)
  role       = aws_iam_role.role.name
  policy_arn = element(var.policy_arn, count.index)
}

# Outputs
#output "role" {
#   value = aws_iam_instance_profile.role.name
#}

