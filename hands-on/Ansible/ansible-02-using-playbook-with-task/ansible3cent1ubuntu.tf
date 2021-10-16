//This Terraform Template creates 4 Ansible Machines on EC2 Instances
//Ansible Machines will run on Amazon Linux 2 and Ubuntu 20.04 with custom security group
//allowing SSH (22) and HTTP (80) connections from anywhere.
//User needs to select appropriate key name when launching the instance.

provider "aws" {
  region = "us-east-1"
  //  access_key = ""
  //  secret_key = ""
  //  If you have entered your credentials in AWS CLI before, you do not need to use these arguments.
}

resource "aws_instance" "ansible-worker-server" {
  ami             = "ami-02e136e904f3da870"
  instance_type   = "t2.micro"
  key_name        = "mk"
  //  Write your pem file name
  security_groups = ["ansible-sec-gr"]
  count = 2
  tags = {
    Name = "node-${count.index + 1}"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              hostnamectl set-hostname "node- ${count.index + 1}"
              bash
              EOF
}

resource "aws_instance" "ansible-control-server" {
  ami             = "ami-02e136e904f3da870"
  instance_type   = "t2.micro"
  key_name        = "mk"
  //  Write your pem file name
  security_groups = ["ansible-sec-gr"]
  tags = {
    Name = "ansible-control-node"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install ansible2
              hostnamectl set-hostname "control-leader-server"
              bash
              EOF
}


resource "aws_instance" "ansible-server-ubuntu" {
  ami             = "ami-09e67e426f25ce0d7"
  instance_type   = "t2.micro"
  key_name        = "mk"
  //  Write your pem file name
  security_groups = ["ansible-sec-gr"]
  tags = {
    Name = "node-3-ubuntu"
  }
  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              hostnamectl set-hostname "worker-ubuntu"
              bash
              EOF
}

resource "aws_security_group" "ansible-sec-gr" {
  name = "ansible-sec-gr"
  tags = {
    Name = "ansible-sec-group"
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}
output "control-public-ip" {
  value = aws_instance.ansible-control-server.public_ip 
}
output "worker-public-ips" {
  value = aws_instance.ansible-worker-server.*.public_ip 
}
output "worker-ubuntu-public-ip" {
  value = aws_instance.ansible-server-ubuntu.public_ip
}
output "control-private-ip" {
  value = aws_instance.ansible-control-server.private_ip 
}
output "worker-private-ips" {
  value = aws_instance.ansible-worker-server.*.private_ip 
}
output "worker-ubuntu-private-ip" {
  value = aws_instance.ansible-server-ubuntu.private_ip
}
