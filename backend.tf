# Triggering workflow after bucket creation.
# Triggering workflow after bucket creation.
terraform {
  backend "s3" {
    bucket         = "terraform-state-mkprsanna"
    key            = "ec2-demo/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

