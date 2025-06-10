terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}


# Create a VPC
resource "aws_vpc" "vpc_python_web_app" {
  cidr_block       = var.vpc_cidr_block_python_web_app
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.VPC_name
    CreatedBy = "Terraform"
    app = "var.app_name"

  }
}

# Create Subnets

resource "aws_subnet" "py_web_app_subnet_1a_Public" {
  vpc_id            = aws_vpc.vpc_python_web_app.id
  cidr_block        = var.py_web_app_subnet_1a_Public_cidr_block
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "var.py_web_app_subnet_1a_Public_name"
    CreatedBy = "Terraform"
    app = "var.app_name"
 }
}


resource "aws_subnet" "py_web_app_subnet_1b_Public" {
  vpc_id            = aws_vpc.var.vpc_name.id
  cidr_block        = var.py_web_app_subnet_1b_Public_cidr_block
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "var.py_web_app_subnet_1b_Public_name"
    CreatedBy = "Terraform"
    app = "var.app_name"
 }
  
}