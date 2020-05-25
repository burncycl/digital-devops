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

### Base (./base)
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

## AWS Terraform S3 Remote State Backend (./tf-s3-remote-state-backend)
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

