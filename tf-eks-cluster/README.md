### 2020/05 Michael Grate

Terraform automation to deploy EKS Cluster.

References:
- https://aws.amazon.com/blogs/startups/from-zero-to-eks-with-terraform-and-helm/
- https://github.com/terraform-providers/terraform-provider-aws.git

Modified the original source code for readability.

Push button magic with
```
make cluster finalize
```
To just address infrastructure changes, use only `make cluster` target.

Pay attention to the ELB address output. You'll need this for the CNAME record for DNS. Not using Route53 for
my DNS so this is a manual process.


### Troubleshooting

#### Problem
```
error: You must be logged in to the server (Unauthorized)
```

#### Solution

Reference: 
- https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/

Ended up needing to use the automation role which has kms policy.
```
aws eks --region us-west-2 update-kubeconfig --name digital-devops-eks-cluster --role-arn arn:aws:iam::351484734788:role/automation-role
```

