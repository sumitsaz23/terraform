variable "aws_region" {
  description = "The AWS region to deploy the resources"
  type        = string
  default     = "ap-south-1"
  
}



variable "app_name" {
  description = "The name of the web application"
  type        = string
  default     = "python_web_app" 
}

variable "vpc_cidr_block_python_web_app" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
  
}

variable "VPC_name" {
  description = "The name of the VPC"
  type        = string
  default     = "py_web_app_vpc"
  
}

variable "py_web_app_subnet_1a_Public_name" {
  description = "The name of the first public subnet in availability zone 1a"
  type        = string
  default     = "py_web_app_subnet_1a_Public"
  
}
variable "py_web_app_subnet_1a_Public_cidr_block" {
  description = "The CIDR block for the first subnet in availability zone 1a"
  type        = string
  default     = "10.0.0.0/25"
  
}

variable "py_web_app_subnet_1b_Public_name" {
  description = "The name of the first public subnet in availability zone 1b"
  type        = string
  default     = "py_web_app_subnet_1b_Public"

}

variable "py_web_app_subnet_1b_Public_cidr_block" {
  description = "The CIDR block for the first subnet in availability zone 1b"
  type        = string
  default     = "10.0.0.128/25"
  
}

variable "py_web_app_subnet_1a_private_name" {
  description = "The name of the first private subnet in availability zone 1a"
  type        = string
  default     = "py_web_app_subnet_1a_Private"
  
}

variable "py_web_app_subnet_1a_private_cidr_block" {
  description = "The CIDR block for the first subnet in availability zone 1a"
  type        = string
  default     = "10.0.1.0/24"
  
}

variable "py_web_app_subnet_1b_private_name" {
  description = "The name of the first private subnet in availability zone 1b"
  type        = string
  default     = "py_web_app_subnet_1b_Private"
  
}

variable "py_web_app_subnet_1b_private_cidr_block" {
  description = "The CIDR block for the first subnet in availability zone 1b"
  type        = string
  default     = "10.0.2.0/24"
  
}