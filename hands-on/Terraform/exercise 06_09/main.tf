resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-VPC"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.vpc.id
  count = var.public_subnet_count
  cidr_block = element(var.public_subnet_cidr, count.index )
  availability_zone = element(var.availability_zones, count.index )

  tags = {
    Name = "${var.environment}-public-subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.vpc.id
  count = var.private_subnet_count
  cidr_block = element(var.private_subnet_cidr, count.index )
  availability_zone = element(var.availability_zones, count.index )

  tags = {
    Name = "${var.environment}-private-subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-public-route-table"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-private-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  count = var.public_subnet_count
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index )
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  count = var.private_subnet_count
  subnet_id      = element(aws_subnet.private_subnet.*.id, count.index )
  route_table_id = aws_route_table.private_route_table.id
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.environment}-VPC-IGW"
  }
}

resource "aws_route" "igw_route" {
  route_table_id            = aws_route_table.public_route_table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.internet_gateway.id
}

data "aws_ami" "amazon-linux-2" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "ec2_instance" {
  ami = data.aws_ami.amazon-linux-2.id
  instance_type = var.instancetype
  key_name = var.keypem
  vpc_security_group_ids = [aws_security_group.sec-gr.id]
  subnet_id = aws_subnet.public_subnet[0].id
  associate_public_ip_address = true
  user_data = file("userdata.sh")
  
  tags = {
    Name = "${var.environment}-EC2"
  }
}

resource "aws_security_group" "sec-gr" {
  name = "${var.environment}-VPC-secgr"
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.environment}-VPC-secgr"
  }
    
  dynamic "ingress" {
    for_each = var.secgr-dynamic-ports
    iterator = port
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

data "aws_route53_zone" "cw-us" {
  name = "clarusway.us"
}

resource "aws_route53_record" "www" {

  name = "my.clarusway.us"
  type = "A"
  ttl = "300"
  zone_id = data.aws_route53_zone.cw-us.zone_id
  records = [aws_instance.ec2_instance.public_ip]
}