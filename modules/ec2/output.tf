output "base_ec2" {
  value = aws_instance.base_ec2.id
  description = "ID of the BASE ec2"
}