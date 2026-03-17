# Triggering workflow after bucket creation.
terraform {
  backend "s3" {
    bucket         = "terraform-state-mkprasanna"
    key            = "ec2-demo/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

