provider "aws" {
  region = "us-east-2"
}

data "aws_ami" "amazon_linux" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ssh" {
  name        = "allow_ssh_"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "demo" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  key_name               = aws_key_pair.demo.key_name
  vpc_security_group_ids = [aws_security_group.ssh.id]
  user_data = <<EOF
#!/bin/bash
yum update -y
yum install -y python3 python3-libselinux python3-dnf python3-rpm python3-setuptools python3-pip
EOF
}

resource "aws_key_pair" "demo" {
  key_name   = "demo-key-2"
  public_key = file("demo-key-2.pub")
}

output "public_ip" {
  value = aws_instance.demo.public_ip
}
