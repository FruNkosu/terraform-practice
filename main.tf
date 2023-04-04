provider "aws" {
    region = "us-east-1"
}


resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
    tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

module "myapp-subnet" {
  source = "./modules/subnet"
  subnet_cidr_block = var.subnet_cidr_block
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  vpc_id = aws_vpc.myapp-vpc.id
  default_route_table_id = aws_vpc.myapp-vpc.default_route_table_id
}

module "myapp-server" {
  source = "./modules/webserver"
  vpc_id = aws_vpc.myapp-vpc.id
  avail_zone = var.avail_zone
  env_prefix = var.env_prefix
  my_ip = var.my_ip
  key_pair = var.key_pair
  instance_type = var.instance_type
  default_public_key_location = var.default_public_key_location
  image_type = var.image_type
  subnet_id = module.myapp-subnet.subnet.id
  }
