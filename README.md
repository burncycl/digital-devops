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
