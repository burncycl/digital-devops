provider "aws" {
  version = ">= 2.38.0"
  region  = var.region
  profile = var.account
  assume_role {
    role_arn     = var.deploy_role
    session_name = "Deploy_tf"
  }
}

# Create KMS Encryption key for use with S3 bucket
resource "aws_kms_key" "kms-key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# Create S3 Bucket
resource "aws_s3_bucket" "default" {
  bucket = var.bucket_name
  acl    = "private"

  tags = {
    Name = var.bucket_name
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.kms-key.arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

# Block public access using ALCs, Policy, etc.
resource "aws_s3_bucket_public_access_block" "default" {
  bucket = aws_s3_bucket.default.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
