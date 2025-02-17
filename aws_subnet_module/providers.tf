terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
  backend "s3" {
    bucket = "tfstate-tal-jb-us-east-1"
    key    = "tal/tfstate"
    region = "us-east-1"
    encrypt = true
  }
}


provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAXLEKZJVVZY7TJRWF"
  secret_key = "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"
}

