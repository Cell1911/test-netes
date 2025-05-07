# variables.tf (updated)
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "key_name" {
  description = "Name of existing EC2 Key Pair"
  type        = string
  default     = "my-key"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.xlarge"
}

variable "ami_id" {
  description = "Kind-server"
  type        = string
  default     = "ami-07b7f66b629de9364"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}

variable "enable_public_ip" {
  description = "Assign public IP to the instance"
  type        = bool
  default     = true
}
