### 2020/05 Michael Grate

Terraform automation to deploy EKS Cluster.

References:
- https://aws.amazon.com/blogs/startups/from-zero-to-eks-with-terraform-and-helm/
- https://github.com/terraform-providers/terraform-provider-aws.git

Modified the original source code for readability.

## Create Cluster

Push button magic with
```
make cluster finalize
```
To just address infrastructure changes, use only `make cluster` target.

Pay attention to the ELB address output. You'll need this for the CNAME record for DNS. Not using Route53 for
my DNS so this is a manual process.


## Destroy Cluster
Destroy requires terraform.tfstate

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_cluster
```


### Troubleshooting

#### Authorization issues
##### Problem
```
error: You must be logged in to the server (Unauthorized)
```

##### Solution

Reference: 
- https://aws.amazon.com/premiumsupport/knowledge-center/eks-api-server-unauthorized-error/

Ended up needing to use the automation role which has kms policy.
```
aws eks --region us-west-2 update-kubeconfig --name digital-devops-eks-cluster --role-arn arn:aws:iam::351484734788:role/automation-role
```

#### Terraform doesn't destroy

##### Problem
Terraform timesout trying to delete resources (e.g. subnets)

##### Solution
The ENI's struggle to detach + delete. Thus, you'll need to manually:
- Delete the ELB. 
- Delete the ENI's
- To keep things moving along, manually delete the VPC.

Terraform should be able to delete the cluster after this effort.

