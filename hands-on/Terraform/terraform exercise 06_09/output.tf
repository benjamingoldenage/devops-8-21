output "vpc_id" {
  value       = aws_vpc.vpc.id
}

output "vpc_arn" {
  value       = aws_vpc.vpc.arn
}

output "vpc_cidr_block" {
  value       = aws_vpc.vpc.cidr_block
}

output "public-subnet" {
  value = aws_subnet.public_subnet[*].cidr_block
}

output "private-subnet" {
  value = aws_subnet.private_subnet[*].cidr_block
}

output "ip" {
  value = aws_instance.ec2_instance.public_ip
}

output "www" {
  value = "http://my.clarusway.us:8080"
}