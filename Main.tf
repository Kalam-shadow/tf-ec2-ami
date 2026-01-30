module "VPC" {
  source = "./modules/vpc"
}

module "EC2" {
    source = "./modules/ec2"
    ami_id = "ami-0ff5003538b60d5ec"  # Replaced with a valid AMI ID 😴
    instance_type = "t2.micro"
#   abyss_vpc = module.VPC.abyss_vpc.id
    public_subnet_id = module.VPC.public_subnet_id
    abyss_wizard = module.VPC.abyss_wizard
    private_key_path = "${path.root}/abyss.pem"

}

module "AMI" {
  source = "./modules/ami"
  base_ec2 = module.EC2.base_ec2
    instance_type = "t2.micro"
    public_subnet_id = module.VPC.public_subnet_id
    abyss_wizard = module.VPC.abyss_wizard
}