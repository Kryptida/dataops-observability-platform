variable "region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name used for naming and tags"
  type        = string
  default     = "dataops"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the subnet"
  type        = string
  default     = "us-east-1a"
}

variable "monitoring_instance_type" {
  description = "Instance type for the monitoring server"
  type        = string
  default     = "t3.medium"
}

variable "worker_instance_type" {
  description = "Instance type for the two worker servers"
  type        = string
  default     = "t3.small"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key that gets installed on the servers"
  type        = string
  default     = "~/.ssh/dataops-key.pub"
}
