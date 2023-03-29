resource "aws_vpc" "myapp-vpc" {
  cidr_block = var.vpc_cidr_block
    tags = {
    Name = "${var.env_prefix}-vpc"
  }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name = "${var.env_prefix}-subnet-1"
  }
}

resource "aws_route_table" "myapp-route-table" {
   vpc_id = aws_vpc.myapp-vpc.id
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myapp-internet_gateway.id
   }

    tags = {
      Name = "${var.env_prefix}-route-table"
    } 
   }


resource "aws_internet_gateway" "myapp-internet_gateway" {
  vpc_id = aws_vpc.myapp-vpc.id
  tags = {
    Name = "${var.env_prefix}-internet-gateway"
  }
}

resource "aws_route_table_association" "a-route-table-subnet" {
  subnet_id = aws_subnet.myapp-subnet-1.id
  route_table_id = aws_route_table.myapp-route-table.id
}

resource "aws_security_group" "myapp_security_group" {
  name        = "myapp_security_group"
  description = "Allow  inbound traffic"
  vpc_id      = aws_vpc.myapp-vpc.id

  ingress {
    description = "Allow inbound traffic"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.my_ip]
  }

  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outbound traffic such as install/depencies"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.env_prefix}-security-group"
  }
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]

}
}

output "ec2_public_ip" {
  value = aws_instance.myapp_ec2_instance.public_ip
}
output "aws_ami_id" {
  value = data.aws_ami.latest-amazon-linux-image
}

resource "aws_key_pair" "ssh-key" {
  key_name = var.key_pair
   public_key = file(var.default_public_key_location)
}

resource "aws_instance" "myapp_ec2_instance" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  
  subnet_id = aws_subnet.myapp-subnet-1.id
  vpc_security_group_ids = [aws_security_group.myapp_security_group.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.env_prefix}-myapp_ec2-instance"
  }
}
