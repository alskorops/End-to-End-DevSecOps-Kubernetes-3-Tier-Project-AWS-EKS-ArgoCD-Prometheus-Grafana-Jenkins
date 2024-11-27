terraform {
  backend "s3" {
    bucket         = "tf-jenkins-bucket-aleksey-1"
    region         = "us-east-1"
    key            = "End-to-End-DevSecOps-Kubernetes-Three-Tier-Project/Jenkins-Server-TF/terraform.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
  }
  
  required_version = ">=0.13.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source  = "hashicorp/aws"
    }
  }
}

