output "mypublicips" {
    value = aws_instance.apache-server[*].public_ip
  
}


# * tüm instanceların public IP.sı