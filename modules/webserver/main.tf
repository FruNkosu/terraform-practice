resource "aws_security_group" "myapp_security_group" {
  name        = "myapp_security_group"
  description = "Allow  inbound traffic"
  vpc_id      = var.vpc_id

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
    cidr_blocks      = [var.my_ip]
  }

  egress {
    description = "Allow outbound traffic such as install/depencies"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.my_ip]
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
    values = [var.image_type]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]

}
}

resource "aws_key_pair" "ssh-key" {
  key_name = var.key_pair
   public_key = file(var.default_public_key_location)
}

resource "aws_instance" "myapp_ec2_instance" {
  ami = data.aws_ami.latest-amazon-linux-image.id
  instance_type = var.instance_type
  
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.myapp_security_group.id]
  availability_zone = var.avail_zone

  associate_public_ip_address = true
  key_name = aws_key_pair.ssh-key.key_name

  user_data = file("entry-script.sh")

  tags = {
    Name = "${var.env_prefix}-myapp_ec2-instance"
  }
}
