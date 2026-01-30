resource "aws_instance" "base_ec2" {
    ami           = var.ami_id
    instance_type = var.instance_type
    key_name = "abyss"

    subnet_id         = var.public_subnet_id
    vpc_security_group_ids = [var.abyss_wizard]
    associate_public_ip_address = true
    # user_data = templatefile("${path.module}/user_data.sh.tpl", {
    #     hostname = "abyss-base"
    #     env = "development"
    # })

    provisioner "remote-exec" {
        inline = [
            "sudo yum update -y",
            "sudo yum install docker -y",
            "sudo systemctl enable docker",
            "sudo systemctl start docker"
        ]
        connection {
            type        = "ssh"
            user        = "ec2-user"
            private_key = file(var.private_key_path)   # path to your .pem file
            host        = self.public_ip
        }
    }

    tags = {
        Name = "BaseEC2Instance"
    }
}

