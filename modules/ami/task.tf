resource "aws_instance" "task_instance" {
  ami           = aws_ami_from_instance.abyss_ami.id
  instance_type = var.instance_type
  key_name = "abyss"

  subnet_id         = var.public_subnet_id
  vpc_security_group_ids = [var.abyss_wizard]
  associate_public_ip_address = true
  tags = {
    Name = "TaskInstance"
  }
}