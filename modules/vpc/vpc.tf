data "aws_vpc" "abyss_vpc"{
    filter {
       name = "tag:Name"
       values = [ "abyss" ]
    }
}

# data "aws_subnet_ids" "abyss_subnet_ids" {
#     vpc_id = data.aws_vpc.abyss_vpc.id
# }

data "aws_security_group" "abyss_sg" {
    filter {
        name = "tag:Name"
        values = ["abyss-wizard"]
    }
    vpc_id = data.aws_vpc.abyss_vpc.id
}

data "aws_subnet" "abyss_public" {
    filter {
        name = "tag:Name"
        values = ["abyss-pub"]
    }
    vpc_id = data.aws_vpc.abyss_vpc.id
}