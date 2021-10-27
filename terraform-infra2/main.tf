provider "aws" {
  region = "eu-west-1"
}

# @component CalcApp:VPC (#vpc)
# 1. virtual private cloud (vpc):
resource "aws_vpc" "cyber94_calculator2_mohammed_vpc_tf" {
  cidr_block       = "10.111.0.0/16"

  tags = {
    Name = "cyber94_calculator2_mohammed_vpc"
  }
}

# 2. internet gateway (ig):
resource "aws_internet_gateway" "cyber94_calculator2_mohammed_internet_gateway_tf" {
  vpc_id = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id

  tags = {
    Name = "cyber94_calculator2_mohammed_internet_gateway"
  }
}

# 3. route table:
resource "aws_route_table" "cyber94_calculator2_mohammed_route_table_tf" {
  vpc_id = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.cyber94_calculator2_mohammed_internet_gateway_tf.id
    }


  tags = {
    Name = "cyber94_calculator2_mohammed_route_table"
  }
}

# @component CalcApp:VPC:Subnet (#subnet)
#4.1 subnet (proxy server):
resource "aws_subnet" "cyber94_calculator2_mohammed_subnet_proxy_tf" {
  vpc_id     = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id
  cidr_block = "10.111.1.0/24"

  tags = {
    Name = "cyber94_calculator2_mohammed_subnet_proxy"
  }
}

#4.2 subnet (server1):
resource "aws_subnet" "cyber94_calculator2_mohammed_subnet_server1_tf" {
  vpc_id     = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id
  cidr_block = "10.111.2.0/24"

  tags = {
    Name = "cyber94_calculator2_mohammed_subnet_server1"
  }
}

#4.3 subnet (server2):
resource "aws_subnet" "cyber94_calculator2_mohammed_subnet_server2_tf" {
  vpc_id     = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id
  cidr_block = "10.111.3.0/24"

  tags = {
    Name = "cyber94_calculator2_mohammed_subnet_server2"
  }
}

# 5.1 route table associations (proxy server):
resource "aws_route_table_association" "cyber94_calculator2_mohammed_route_table_association_proxy_tf" {
  subnet_id      = aws_subnet.cyber94_calculator2_mohammed_subnet_proxy_tf.id
  route_table_id = aws_route_table.cyber94_calculator2_mohammed_route_table_tf.id
}

# 5.2 route table associations (server1):
resource "aws_route_table_association" "cyber94_calculator2_mohammed_route_table_association_server1_tf" {
  subnet_id      = aws_subnet.cyber94_calculator2_mohammed_subnet_server1_tf.id
  route_table_id = aws_route_table.cyber94_calculator2_mohammed_route_table_tf.id
}

# 5.3 route table associations (server2):
resource "aws_route_table_association" "cyber94_calculator2_mohammed_route_table_association_server2_tf" {
  subnet_id      = aws_subnet.cyber94_calculator2_mohammed_subnet_server2_tf.id
  route_table_id = aws_route_table.cyber94_calculator2_mohammed_route_table_tf.id
}

# 7.1 security group (proxy server):
resource "aws_security_group" "cyber94_calculator2_mohammed_sg_proxy_tf" {
  name = "cyber94_calculator2_mohammed_sg_proxy_server" #defining security group name
  vpc_id = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id

  #inbound rules:

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["86.21.170.53/32"]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
  }

  #outbound rules:
  egress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.2.0/24"]
    from_port  = 8001
    to_port    = 8001
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.3.0/24"]
    from_port  = 8002
    to_port    = 8002
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "cyber94_calculator2_mohammed_sg_proxy"
  }
}

# 7.2 security group (server1):
resource "aws_security_group" "cyber94_calculator2_mohammed_sg_server1_tf" {
  name = "cyber94_calculator2_mohammed_sg_server1" #defining security group name
  vpc_id = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id

  #inbound rules:
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.1.0/24"]
    from_port  = 8001
    to_port    = 8001
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.1.0/24"]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["86.21.170.53/32"]
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "cyber94_calculator2_mohammed_sg_server1"
  }
}

# 7.3 security group (server2):
resource "aws_security_group" "cyber94_calculator2_mohammed_sg_server2_tf" {
  name = "cyber94_calculator2_mohammed_sg_server2" #defining security group name
  vpc_id = aws_vpc.cyber94_calculator2_mohammed_vpc_tf.id

  #inbound rules:
  ingress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.1.0/24"]
    from_port  = 5000
    to_port    = 8002
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["10.111.1.0/24"]
    from_port  = 22
    to_port    = 22
  }

  ingress {
    protocol   = "tcp"
    cidr_blocks = ["86.21.170.53/32"]
    from_port  = 22
    to_port    = 22
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 443
    to_port    = 443
  }

  egress {
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "cyber94_calculator2_mohammed_sg_server2"
  }
}

# @component CalcApp:Web:Server (#web_server)
# @connects #subnet to #web_server with Network
# # 8.1 aws instance (app server):
# resource "aws_instance" "cyber94_calculator2_mohammed_app_server_tf" {
#   ami = "ami-0943382e114f188e8"
#   instance_type = "t2.micro"
#   key_name = "cyber94-mali"
#
#   associate_public_ip_address = true # can add this to the subnet itself if you dont want to apply a public address to all of them
#
#   subnet_id = aws_subnet.cyber94_calculator2_mohammed_subnet_app_tf.id
#   vpc_security_group_ids = [aws_security_group.cyber94_calculator2_mohammed_sg_app_tf.id] # [name of the resource.the name of the resources.id]
#
#   count = 1 # define the number of servers you want to create
#
#   tags = {
#     Name = "cyber94_calculator2_mohammed_app_server"
#   }
#
#   # lifecycle {
#   #   create_before_destroy = true
#   # }
#
#   # Just to make sure that terraform will not continue to local-exec before the server is up
#   connection {
#     type = "ssh"
#     user = "ubuntu"
#     host = self.public_ip
#     private_key = file("/home/kali/.ssh/cyber94-mali.pem")
#   }
#
#   # Just to make sure that terraform will not continue to local-exec before the server is up
#   provisioner "remote-exec" {
#     inline = [
#       "pwd"
#     ]
#   }
#
#   provisioner "local-exec" {
#     working_dir = "../ansible"
#     command = "ansible-playbook -i ${self.public_ip}, -u ubuntu playbook.yml"
#   }
# }

resource "aws_instance" "cyber94_calculator2_mohammed_proxy_server_tf" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-mali"

  associate_public_ip_address = true # can add this to the subnet itself if you dont want to apply a public address to all of them

  subnet_id = aws_subnet.cyber94_calculator2_mohammed_subnet_proxy_tf.id
  vpc_security_group_ids = [aws_security_group.cyber94_calculator2_mohammed_sg_proxy_tf.id] # [name of the resource.the name of the resources.id]

  count = 1

  tags = {
    Name = "cyber94_calculator2_mohammed_proxy_server"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "aws_instance" "cyber94_calculator2_mohammed_server1_tf" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-mali"

  associate_public_ip_address = true # can add this to the subnet itself if you dont want to apply a public address to all of them

  subnet_id = aws_subnet.cyber94_calculator2_mohammed_subnet_server1_tf.id
  vpc_security_group_ids = [aws_security_group.cyber94_calculator2_mohammed_sg_server1_tf.id] # [name of the resource.the name of the resources.id]

  count = 1

  tags = {
    Name = "cyber94_calculator2_mohammed_server1"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}

resource "aws_instance" "cyber94_calculator2_mohammed_server2_tf" {
  ami = "ami-0943382e114f188e8"
  instance_type = "t2.micro"
  key_name = "cyber94-mali"

  associate_public_ip_address = true # can add this to the subnet itself if you dont want to apply a public address to all of them

  subnet_id = aws_subnet.cyber94_calculator2_mohammed_subnet_server2_tf.id
  vpc_security_group_ids = [aws_security_group.cyber94_calculator2_mohammed_sg_server2_tf.id] # [name of the resource.the name of the resources.id]

  count = 1

  tags = {
    Name = "cyber94_calculator2_mohammed_server2"
  }

  # lifecycle {
  #   create_before_destroy = true
  # }
}
