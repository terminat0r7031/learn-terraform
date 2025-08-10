terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region  = "ap-southeast-1"
  profile = "lab-phuocpham"
}

resource "aws_instance" "myec2" {
  ami           = "ami-0061376a80017c383"
  instance_type = "t3.nano"
}
