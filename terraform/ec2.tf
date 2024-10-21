# Data Sources
data "aws_subnet" "public_subnet_web_az1" {
  filter {
    name   = "tag:Name"
    values = ["common_publicsubnet_web1"]
  }
}

data "aws_subnet" "privatesubnet_app1"{
    filter {
      name = "tag:Name"
      values = ["common_privatesubnet_app1"]
    }
}

data "aws_security_group" "common_app_sg" {
  filter {
    name   = "tag:Name"
    values = ["Applicationtraffic"]
  }
}

data "aws_security_group" "bastion_host" {
    filter {
    name   = "tag:Name"
    values = ["bastion_securitygroup"]
  }
  
}

# EC2 Instance
resource "aws_instance" "nginx" {
  ami                  = var.ami_for_instance
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnet.public_subnet_web_az1.id
  vpc_security_group_ids = [data.aws_security_group.common_app_sg.id]
  key_name               = "whizlabs"
  associate_public_ip_address  = true

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "Nginx"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}

# EC2 Instance (Application Server)
resource "aws_instance" "python" {
  ami                  = var.ami_for_instance
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnet.privatesubnet_app1.id
  vpc_security_group_ids = [data.aws_security_group.common_app_sg.id]
  key_name               = "whizlabs"

  user_data = <<-EOF
              #!/bin/bash
              sudo apt-get update -y
              sudo apt-get install -y python3
              sudo apt-get install -y python3-pip
              pip3 install flask
              EOF

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "Python"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}

resource "aws_instance" "bastion_instances" {
  ami                  = var.ami_for_instance
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnet.public_subnet_web_az1.id
  vpc_security_group_ids = [data.aws_security_group.bastion_host.id]
  key_name               = "whizlabs"
  tags = {
    Name        = "Bastionhost"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}
