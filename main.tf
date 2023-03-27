resource "aws_vpc" "developement-vpc" {
  cidr_block = var.cidr_blocks[0]
    tags = {
    Name = "deployment"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.developement-vpc.id
  cidr_block = var.cidr_blocks[1]
  availability_zone = var.avail_zone
  tags = {
    Name = "subnet-1-dev"
  }
}