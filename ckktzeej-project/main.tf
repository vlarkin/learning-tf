provider "aws" {
    region  = "eu-west-1"
    profile = "default"
}

terraform {
    backend "s3" {
        region = "eu-west-1"
        bucket = "ckktzeej-tf-state"
        key = "ckktzeej-project/terraform.tfstate"
        encrypt = true
        dynamodb_table = "tf-state-lock"
    }
}

