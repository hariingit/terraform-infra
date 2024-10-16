# Data Sources
data "aws_subnet" "public_subnet_web_az1" {
  filter {
    name   = "tag:Name"
    values = ["common_publicsubnet_web1"]
  }
}

data "aws_security_group" "common_app_sg" {
  filter {
    name   = "tag:Name"
    values = ["Applicationtraffic"]
  }
}

# EC2 Instance
resource "aws_instance" "nginx" {
  ami                  = var.ami_for_instance
  instance_type        = var.instance_type
  subnet_id            = data.aws_subnet.public_subnet_web_az1.id
  vpc_security_group_ids = [data.aws_security_group.common_app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              EOF


  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "EC2 public subnet"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}


