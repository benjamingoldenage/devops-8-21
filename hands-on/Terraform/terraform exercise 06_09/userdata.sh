#! /bin/bash
yum update -y
amazon-linux-extras install docker -y
systemctl start docker
systemctl enable docker
usermod -a -G docker ec2-user
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" \
-o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
mkdir /home/ec2-user/nginxpage
cd /home/ec2-user/nginxpage && echo "<h1>Welcome to Clarusway</h1>" > index.html
docker run -d --name nginx-server -p 8080:80 -v /home/ec2-user/nginxpage:/usr/share/nginx/html nginx