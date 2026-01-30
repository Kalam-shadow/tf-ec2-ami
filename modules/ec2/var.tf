variable "ami_id" {
    description = "AMI ID of Base Image"
    type = string
}
variable "instance_type" {
    description = "Type of EC2 Instance"
    type = string
}

# variable "abyss_vpc" {
#   description = "The VPC ID for the Abyss VPC"
#   type        = string
# }
variable "public_subnet_id" {
  description = "ID of Public Subnet in the Abyss VPC"
  type        = string
}

variable "abyss_wizard" {
  description = "Id of the security group"
  type = string
}

variable "private_key_path" {
  description = ".pem"
  type = string
}