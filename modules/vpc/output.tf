# output "abyss_vpc" {
#   value = data.aws_vpc.abyss_vpc.id
#   description = "ID of VPC"
# }

output "public_subnet_id" {
  value = data.aws_subnet.abyss_public.id
  description = "ID of Public Subnet"
}

output "abyss_wizard" {
  value = data.aws_security_group.abyss_sg.id
  description = "Id of the security group"
}