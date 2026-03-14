provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "demo" {
  ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name = "demo-ansible"
  }
}

output "public_ip" {
  value = aws_instance.demo.public_ip
}
