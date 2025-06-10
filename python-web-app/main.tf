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
  vpc_id            = aws_vpc.vpc_python_web_app.id
  cidr_block        = var.py_web_app_subnet_1b_Public_cidr_block
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "var.py_web_app_subnet_1b_Public_name"
    CreatedBy = "Terraform"
    app = "var.app_name"
 }
  
}


resource "aws_subnet" "py_web_app_subnet_1a_Private" {
  vpc_id            = aws_vpc.vpc_python_web_app.id
  cidr_block        = var.py_web_app_subnet_1a_private_cidr_block
  availability_zone = "ap-south-1a"
  tags = {
    Name = var.py_web_app_subnet_1a_private_name
    CreatedBy = "Terraform"
    app = var.app_name
 }
}

resource "aws_subnet" "py_web_app_subnet_1b_Private" {
  vpc_id            = aws_vpc.vpc_python_web_app.id
  cidr_block        = var.py_web_app_subnet_1b_private_cidr_block
  availability_zone = "ap-south-1b"
  tags = {
    Name = var.py_web_app_subnet_1b_private_name
    CreatedBy = "Terraform"
    app = var.app_name
 }
}

#create an internet gateway
resource "aws_internet_gateway" "igw_python_web_app" {
  vpc_id = aws_vpc.vpc_python_web_app.id

  tags = {
    Name = "igw-${var.app_name}"
    CreatedBy = "Terraform"
  }
}

# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc_python_web_app.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_python_web_app.id
  }
  tags = {
    Name = "public-route-table-${var.app_name}"
    CreatedBy = "Terraform"
  }
}
# Associate the public route table with the public subnets
resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id      = aws_subnet.py_web_app_subnet_1a_Public.id
  route_table_id = aws_route_table.public_route_table.id
}
resource "aws_route_table_association" "public_subnet_1b" {
  subnet_id      = aws_subnet.py_web_app_subnet_1b_Public.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create a route table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc_python_web_app.id
  tags = {
    Name = "private-route-table-${var.app_name}"
    CreatedBy = "Terraform"
  }
}
# Associate the private route table with the private subnets
resource "aws_route_table_association" "private_subnet_1a" {
  subnet_id      = aws_subnet.py_web_app_subnet_1a_Private.id
  route_table_id = aws_route_table.private_route_table.id
}
resource "aws_route_table_association" "private_subnet_1b" {
  subnet_id      = aws_subnet.py_web_app_subnet_1b_Private.id
  route_table_id = aws_route_table.private_route_table.id
}
