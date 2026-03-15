provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "demo" {
  ami           = "ami-02f3416038bdb17fb"
  instance_type = "t2.micro"

  tags = {
    Name = "demo-ansible"
  }
}

output "public_ip" {
  value = aws_instance.demo.public_ip
}
