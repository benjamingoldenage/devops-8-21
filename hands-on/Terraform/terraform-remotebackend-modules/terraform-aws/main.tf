terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.56.0"
    }
  }


  backend "s3" {
    bucket = "tf-remote-s3-bucket-benjamin-changehere"
    key = "env/dev/tf-remote-backend.tfstate"
    region = "us-east-1"
    dynamodb_table = "tf-s3-app-lock"
    encrypt = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

data "aws_ami" "tf_ami" {
  most_recent = true
  owners = ["self"]

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  
}

locals {
  instance-name = "benjamin-local-name"
}
resource "aws_instance" "tf-ec2" {
  ami           = data.aws_ami.tf_ami.id
  instance_type = var.ec2-type
  key_name      = "ben"
 
  tags = {
    "Name" = "${local.instance-name}-come from locals"
  }

}

resource "aws_s3_bucket" "tf-s3" {
  # bucket = "${var.s3-bucket-name}-${count.index + 1}"
  acl    = "private"
  # count = var.num_of_buckets
  # count = var.num_of_buckets != 0 ? var.num_of_buckets : 3
  for_each = toset(var.users)
  bucket = "example-s3-bucket-${each.value}"

}

resource "aws_iam_user" "new_users" {
  for_each = toset(var.users)
  name = each.value
}

output "tf-example-public-ip" {
  value = aws_instance.tf-ec2.public_ip
}

# output "tf-example-s3-meta" {
#   value = aws_s3_bucket.tf-s3.region
# }

output "tf-example-private-ip" {
  value = aws_instance.tf-ec2.private_ip
}

# output "tf-example-s3" {
#   value = aws_s3_bucket.tf-s3[*]
# }

output "upper" {
  value = [for user in var.users : upper(user) if length(user) > 6]
}

output "s3-arn-2" {
  value = aws_s3_bucket.tf-s3["santinoro1"].arn
}

output "s3-arn-1" {
  value = aws_s3_bucket.tf-s3["fredos1"].arn
  }