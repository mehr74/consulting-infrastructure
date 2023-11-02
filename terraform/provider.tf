terraform {
  required_version = ">=0.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }

  backend "s3" {
    bucket         = "consulting-terraform-state"
    key            = "web/tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "consulting-terraform-lock"
  }
}

provider "aws" {
  region = "eu-central-1"
}
