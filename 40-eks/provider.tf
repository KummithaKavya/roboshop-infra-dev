terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.95.0, < 6.0.0"
    }
  }


  backend "s3" {
    bucket       = "divya-82s"
    key          = "chaitan-ekss-eks-roboshop"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true


  }
}

provider "aws" {
  region = "us-east-1"
}