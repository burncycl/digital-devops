provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
  profile = var.account
}

resource "aws_iam_policy" "policy" {
  name        = var.policy_name
  description = "KMS Read-only"
  policy      = file("./policy.json")
}

resource "aws_iam_user_policy_attachment" "attach" {
  user       = var.iam_user
  policy_arn = aws_iam_policy.policy.arn
}

