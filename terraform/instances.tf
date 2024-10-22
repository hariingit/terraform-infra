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


data "aws_subnet" "datasubnet_db1" {
  filter {
      name = "tag:Name"
      values = ["common_datasubnet_db1"]
    }
}

data "aws_subnet" "data_subnet_db_2" {
  filter {
      name = "tag:Name"
      values = ["common_datasubnet_db2"]
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

data "aws_security_group" "rds_database" {
    filter {
    name   = "tag:Name"
    values = ["rds_Security_group"]
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
  associate_public_ip_address  = true
  key_name               = "whizlabs"
  tags = {
    Name        = "Bastionhost"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
}


// Create RDS subnet group
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    data.aws_subnet.datasubnet_db1.id,
    data.aws_subnet.data_subnet_db_2.id

  ]

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "rds_instance_flask" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "mysql"
  engine_version = "5.7"
  instance_class = "db.t3.medium"
  identifier = "mydb"
  username = "dbuser"
  password = "dbpassword"

  #parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  vpc_security_group_ids = [data.aws_security_group.rds_database.id]
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  tags = {
    Name        = "mysqlflask"
    Terraform   = "true"
    ManagedBy   = "Terraform"
  }
  depends_on = [aws_db_subnet_group.rds_subnet_group]
}