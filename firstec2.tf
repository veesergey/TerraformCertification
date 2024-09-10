terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region     = "us-east-1"
  //Im logged into the cli so I dont need to specify the access and secret key
  //access_key = "my-access-key"
  //secret_key = "my-secret-key"
}

resource "aws_instance" "myec2" {
    ami = "ami-0182f373e66f89c85"
    instance_type = "t2.micro"
    tags = {
        Name = "MyFirstEC2"
    }
}