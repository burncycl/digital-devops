### 2020/05 Michael Grate

Reference: 
- https://github.com/nozaq/terraform-aws-remote-state-s3-backend
- https://registry.terraform.io/modules/nozaq/remote-state-s3-backend/aws/0.2.1

This will provision AWS S3 remote state bucket using best practices. Modified original code (main.tf and variables.tf) to default to us-west-2 for Primary region, and us-east-1 for replica. 
Also added an alias for easier identification fo the KMS key.

I did not change much. Probably could make this more my style by separating out the polices.

## Create Bucket

Push button magic with 
```
make bucket
```

## Create Backup, since no remote state.

Because the remote state bucket doesn't have a remote state of it's own (Inception, ikr?), only local. It should be backed-up once created for good measure.
```
make backup
```

## Destroy Bucket
Destroy requires terraform.tfstate 

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_noask
``` 
