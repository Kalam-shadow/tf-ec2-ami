resource "aws_ami_from_instance" "abyss_ami" {
    name               = "abyss-ami-${formatdate("YYYYMMDD-HHmmss", timestamp())}"
    source_instance_id = var.base_ec2
    snapshot_without_reboot = true

    tags = {
        Name = "AbyssBaseAMI"
    }       
  
}

