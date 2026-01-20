
variable "aws_region" {
  description = "Region to deploy resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for frontend and backend"
  type        = string
  default     = "t2.micro"
}

variable "frontend_ami" {
  description = "AMI for frontend EC2"
  type        = string
}

variable "backend_ami" {
  description = "AMI for backend EC2"
  type        = string
}

variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database username"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID to deploy resources"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "Availability zone for public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "Availability zone for private subnet"
  type        = string
}
