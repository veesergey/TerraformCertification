terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }   
  }
}

data "aws_vpc" "defaultvpc" {
  filter {
    name   = "tag:Name"
    values = ["default-vpc"]
  }
}

resource "aws_security_group" "terraform-firewall" {
  name        = "Terraform-firewall"
  description = "Managed from Terraform"
  vpc_id      = data.aws_vpc.defaultvpc.id

  tags = {
    Name = "TerraformFirewall"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = resource.aws_security_group.terraform-firewall.id
  cidr_ipv4         = data.aws_vpc.defaultvpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  tags = {
    Name = "Allow443"
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = resource.aws_security_group.terraform-firewall.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
  tags = {
    Name = "AlowAllOutbound"
  }
}