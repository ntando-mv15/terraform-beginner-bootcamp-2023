terraform {
  # cloud {
  #     organization = "AWS-Terraform-Bootcamp"

  #     workspaces {
  #       name = "terra-house-1"
  #     }
  #   }
  # }
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

