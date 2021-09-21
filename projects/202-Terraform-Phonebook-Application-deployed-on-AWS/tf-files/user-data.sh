#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
pip3 install flask_mysql
yum install git -y
TOKEN="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"
cd /home/ec2-user && git clone https://$TOKEN@github.com/benjamingoldenage/phonebook-terraform.git