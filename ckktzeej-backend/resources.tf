provider "aws" {
    region = "eu-west-1"
    profile = "default"
}

resource "aws_s3_bucket" "tf_state" {
    bucket = "ckktzeej-tf-state"
    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "tf_state_versioning" {
    bucket = aws_s3_bucket.tf_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "tf_state_encryption" {
    bucket = aws_s3_bucket.tf_state.id
    rule {
        apply_server_side_encryption_by_default {
            sse_algorithm = "AES256"
        }
    }
}

resource "aws_s3_bucket_public_access_block" "tf_state_public_access" {
    bucket = aws_s3_bucket.tf_state.id
    block_public_acls = true
    block_public_policy = true
    ignore_public_acls = true
    restrict_public_buckets = true
}

resource "aws_dynamodb_table" "tf_state_lock" {
    name     = "tf-state-lock"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
    billing_mode = "PAY_PER_REQUEST"
}

