provider "aws" {
  region  = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "703443639063-tfstate"
    key            = "iam"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}