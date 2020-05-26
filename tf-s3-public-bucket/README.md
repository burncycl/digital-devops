### 2020/05 Michael Grate 

References:
- https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
- https://www.terraform.io/docs/providers/aws/r/s3_bucket_public_access_block.html

Creates a public S3 bucket  

## Create Bucket
Push button magic with 
```
make bucket 
```

## Destroy Bucket
Destroy requires terraform.tfstate

Destroy
```
make destroy
```

Destroy without prompting. Warning: Very impactful!
```
make destroy_bucket
```

