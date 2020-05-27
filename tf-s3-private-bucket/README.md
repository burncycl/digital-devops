### 2020/05 Michael Grate 

References:
- https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
- https://www.terraform.io/docs/providers/aws/r/s3_bucket_public_access_block.html

Creates an S3 bucket with encryption at rest enabled utilizing KMS. 

## Create Bucket

Push button magic with 
```
make bucket 
```

## Test bucket permissions and encryption
```
make test
```

I was originally going to use TerraTest by Gruntworks. But, my golang is immature. I noticed they were using the AWS SDK, so I pivoted to use Python. I also probably could have used something like pytest as a wrapper. But, ended up writing plain script.

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


