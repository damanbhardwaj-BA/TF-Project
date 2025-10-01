variable "AWS_Access_Key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}
variable "Aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
variable "aws_session_token" {
  description = "AWS Session Token"
  type        = string
  sensitive   = true

}
variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "eu-west-1"

}

variable "aws_vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "192.168.0.0/16"

}

variable "aws_subnet_cidr" {
  description = "CIDR block for the Subnet"
  type        = string
  default     = "192.168.1.0/24"

}

variable "aws_availability_zone" {
  description = "Availability Zone for the Subnet"
  type        = string
  default     = "eu-west-1a"

}
variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  default     = "t2.micro"
}
variable "ami_id" {
  description = "AMI ID for the EC2 Instance"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI (HVM), SSD Volume Type in eu-west-1
}
variable "key_name" {
  description = "Key Pair Name for SSH access"
  type        = string
  default     = "my-key-pair" # Replace with your actual key pair name
}

variable "common_tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
  default = {
    Project     = "TF-Project"
    Environment = "Development"
    Owner       = "n517104"
  }
}