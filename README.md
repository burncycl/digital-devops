### 2020/05 Michael Grate 

Automation for digital-devops coding demonstration.

Requirements:
* Deploy EKS Cluster.
* Deploy something to EKS Cluster
  - Deploy own Dockerized application to EKS Cluster.
  - Grab Helm Chart and deploy it.
  - Something else even cooler?
* Create S3 bucket that is not publicly accessible and has encryption at rest enabled.
* Automate tests to verify S3 bucket exists and has correct configuration.

[Message to the Audience](MESSAGE.md)

## Manual Prerequisites

Ubuntu Prerequisites (or as root)
```
sudo apt-add-repository universe
sudo apt update
sudo apt install -y git ansible make
```

Manually, make sure your user is a sudoer

/etc/sudoers
```
username ALL=(ALL:ALL) ALL
```

Configure Git as user.
```
git config --global user.email "your@email.com"
git config --global user.name "username"
```

Important: Be sure to update `./base/group_vars/all.yml` user variable to match your username where automation will be ran.

### Create AWS Free Tier Account

Create free tier account here:
- https://aws.amazon.com/free/

Login to root account, browse to IAM, create a non-root `automation` user account.  Give the user ONLY Programmatic/API access and the following Permissions:
- AdministratorAccess

Dont' worry, we'll remove this permission/policy later.

IMPORTANT TO NOTE: Creating a EKS cluster will incure charges at $0.10 per hour. Be sure to tear down the environment when you're done.

### Base ([./base](./base))
Deploys base dev environment from a virgin system.

#### Import AWS user secrets into Ansible automation

Take Access key ID & Secret access key and input them into ansible-vault secrets.yml

If file already exists
```
ansible-vault edit ./base/secrets.yml
```

If doesn't exist, copy from example, edit and update the variables, then encrypt.
```
cp secrets.yml.example secrets.yml
vi secrets.yml
ansible-vault encrypt secrets.yml
```

Support also exists for GCP Cloud Credentials, although not enabled.

#### Deploy local dev environment

Push button magic with
```
cd ./base && make env
```

## AWS Terraform S3 Remote State Backend ([./tf-s3-remote-state-backend](./tf-s3-remote-state-backend))
Reference: https://github.com/nozaq/terraform-aws-remote-state-s3-backend

Cloned and modified the above project.

All projects are defaulted to us-west-2.

### Create AWS Terraform S3 Remote State Backend

Push button magic with
```
cd ./tf-remote-state-s3-backend && make bucket
```

Create backup for good measure, since this doesn't have a remote state of it's own.
```
cd ./tf-remote-state-s3-backend && make backup
```

### Update Remote State and KMS Key ID for remote_state.tf

`update_rstate_backend.sh` will recursively update remote_state.tf with new S3 Bucket name and KMS Key ID.

These values can be looked up in the AWS Console:
- KMS: Browse to the proper region (e.g us-west-2) -> Customer Managed Keys. Locate name/remote-state alias.
- S3: Browse to S3. Locate bucket name tf-remote-stateXXXXXSUFFIX

Modify
```
vi update_rstate_backend.sh
```

Run
```
./update_rstate_backend.sh
```

## Deploy Automation role to be used by all subsequent automation ([./tf-iam-automation-role](./tf-iam-automation-role))

In an effort to adhear to best-practices, henceforth we'll use a role assumption for all subsequent automation.

Push button magic with
```
cd ./tf-iam-automation-role && make role
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

Deployment role variables held in `vars.tf`
```
variable "region" {
  default       =       "us-west-2"
}

variable "account" {
  default       =       "default"
}

# Role managed by tf-s3-remote-state-backend
variable "deploy_role" {
  default      =       "arn:aws:iam::351484734788:role/automation-role"
}
```

Remote state files should include the following henceforth
```
    role_arn = "arn:aws:iam::351484734788:role/automation-role"
```

## Deploy Automation user policy ([././tf-iam-automation-user-policy](././tf-iam-automation-user-policy))

Automation user policy. This helps to facilitate least privledge. Henceforth, we'll use role assumption for automation.
```
cd ./tf-iam-automation-user-policy &&  make policy
```

At this point, Remove the `AdministratorAccess` permission from the `automation` user. 


## Deploy S3 bucket with non-public permissions ([./tf-s3-private-bucket](./tf-s3-private-bucket))

Push button magic with
```
cd ./tf-s3-private-bucket && make bucket
```

## Deploy EKS Cluster ([./tf-eks-cluster](./tf-eks-cluster))
Push button magic with
```
cd ./tf-eks-cluster && make cluster finalize
```
Pay attention to the ELB address output. You'll need this for the CNAME record for DNS. Not using Route53 for my DNS so this is a manual process.
