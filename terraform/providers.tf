
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  backend "s3" {
    bucket = "project-ecs-tf-state"
    key    = "terraform.tfstate"
    region = "eu-west-2"
  }

  required_version = ">= 1.0"
}

provider "aws" {
  region = "eu-west-2"
}

