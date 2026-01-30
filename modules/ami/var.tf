variable "base_ec2" {
  description = "ID of the base EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet"
  type        = string
}
variable "abyss_wizard" {
  description = "sg of the vpc"
  type = string
}