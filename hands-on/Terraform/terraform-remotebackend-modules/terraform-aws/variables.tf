# variable "ec2-name" {
#   default = "oliver-ec2"
# }

variable "ec2-type" {
  default = "t2.micro"
}

# variable "ec2-ami" {
#   default = "ami-0c2b8ca1dad447f8a"
# }

variable "s3-bucket-name" {
  default = "oliver-s3-bucket-variable-addwhateveryouwant-newest"
}

variable "num_of_buckets" {
  default = 2
}

variable "users" {
  default = ["santinoro1", "michealxe1", "fredos1"]
}