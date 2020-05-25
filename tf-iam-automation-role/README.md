### 2020/05 Michael Grate

Deploys IAM role for Users who need to perform automation (e.g. Terraform) to assume. 

In an effort to adhear to best-practices, henceforth we'll use a role assumption for all subsequent automation.

Push button magic with
```
make role
```

All subsequent automation can utilize the following role assumption in the provider block.
```
provider "aws" {
  region                        = var.region
  profile                       = var.account
  assume_role {
    role_arn                    = var.deploy_role
    session_name                = "Deploy_tf"
  }
}
```

Deployment role variables
```
variable "region" {
  default       =       "us-west-2"
}

variable "account" {
  default       =       "default"
}

# Role managed by tf-iam-automation-user-policy 
variable "deploy_role" {
  default      =       "arn:aws:iam::351484734788:role/automation-role"
}
```

## Note about security
Due to time constraints, I did not work to tighten permissions on KMS or EKS.

Reference: https://docs.aws.amazon.com/eks/latest/userguide/security_iam_id-based-policy-examples.html

Experimenting with the following policy generator might help: https://awspolicygen.s3.amazonaws.com/policygen.html
