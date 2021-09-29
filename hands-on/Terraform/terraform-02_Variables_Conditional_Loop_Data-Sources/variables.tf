# variable "ec2-name" {
#   default = "benjamin-ec2"
# }

variable "ec2-type" {
  default = "t2.micro"
}

# variable "ec2-ami" {
#   default = "ami-09e67e426f25ce0d7"
# }

variable "num_of_buckets" {
  default = 2
}

variable "s3-bucket-name" {
  default = "benjamin-s3-bucket-variable-28sep-new"
}

variable "users" {
  default = ["spring", "micheal", "oliver"]
}