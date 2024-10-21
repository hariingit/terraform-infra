#create a VPC
resource "aws_vpc" "common_account" {
    cidr_block = var.cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = {
      Name = "vpc_commons"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

#creating a public subnet
resource "aws_subnet" "publicsubnet_web1" {
    vpc_id = aws_vpc.common_account.id
    cidr_block = var.public_subnet_web_az1
    availability_zone = var.availability_zone_web_subnet1
    map_public_ip_on_launch = true
    tags = {
      Name = "common_publicsubnet_web1"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_subnet" "publicsubnet_web2" {
    vpc_id = aws_vpc.common_account.id
    cidr_block = var.public_subnet_web_az2
    availability_zone = var.availability_zone_web_subnet2
    map_public_ip_on_launch = true
    tags = {
      Name = "common_publicsubnet_web2"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}



#creating a private subnet
resource "aws_subnet" "privatesubnet_app1" {
    vpc_id = aws_vpc.common_account.id
    cidr_block = var.private_subnet_app_az1
    availability_zone = var.availability_zone_app_subnet1
    tags = {
      Name = "common_privatesubnet_app1"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_subnet" "privatesubnet_app2" {
    vpc_id = aws_vpc.common_account.id
    cidr_block = var.private_subnet_app_az2
    availability_zone = var.availability_zone_app_subnet2
    tags = {
      Name = "common_privatesubnet_app2"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

#creating a database subnet
resource "aws_subnet" "datasubnet_db1" {
    vpc_id = aws_vpc.common_account.id
    cidr_block =   var.data_subnet_db_1
    availability_zone = var.availability_zone_db_subnet1
    tags = {
      Name = "common_datasubnet_db1"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_subnet" "data_subnet_db_2" {
    vpc_id = aws_vpc.common_account.id
    cidr_block =   var.data_subnet_db_2
    availability_zone = var.availability_zone_db_subnet2
    tags = {
      Name = "common_datasubnet_db2"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_network_interface" "common-network-interface" {
    subnet_id = aws_subnet.publicsubnet_web1.id
    security_groups = [aws_security_group.common_app_sg.id]
    tags = {
      Name = "Publicnetworkinterface"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_network_interface" "common-private-nw-interface" {
    subnet_id = aws_subnet.privatesubnet_app1.id
    security_groups = [aws_security_group.common_app_sg.id]
    tags = {
      Name = "private_networkinterface"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_network_interface" "common-data-nw-interface" {
    subnet_id = aws_subnet.datasubnet_db1.id
    security_groups = [aws_security_group.common_app_sg.id]
    tags = {
      Name = "data_networkinterface"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    } 
}

resource "aws_route_table" "public-routetable" {
    vpc_id = aws_vpc.common_account.id
    tags = {
        Name = "public-route-table"
        Terraform   = "true"
        ManagedBy   = "Terraform"
    }
}

resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.common_account.id
    tags = {
      Name = "private-route-table"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_route_table" "data-route-table" {
    vpc_id = aws_vpc.common_account.id
    tags = {
      Name = "data-route-table"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}
resource "aws_internet_gateway" "common-gateway" {
    vpc_id = aws_vpc.common_account.id
    tags = {
      Name = "Internetgateway"
      Terraform   = "true"
      ManagedBy   = "Terraform"
    }
}

resource "aws_nat_gateway" "common-nat-gateway" {
    allocation_id = aws_eip.public_eip.id
    subnet_id = aws_subnet.publicsubnet_web1.id
    depends_on = [aws_internet_gateway.common-gateway]
    lifecycle {
    create_before_destroy = true
  }
    tags = {
        Name = "common-nat-gateway"
        Terraform   = "true"
        ManagedBy   = "Terraform"
    }
}

resource "aws_route" "common-internet-route" {
    route_table_id = aws_route_table.public-routetable.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.common-gateway.id
}

resource "aws_route" "private-net-route" {
    route_table_id = aws_route_table.private-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.common-nat-gateway.id
}

resource "aws_route" "db-net-route" {
    route_table_id = aws_route_table.data-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.common-nat-gateway.id
}

resource "aws_route_table_association" "common-route-table-public" {
    subnet_id = aws_subnet.publicsubnet_web1.id
    route_table_id = aws_route_table.public-routetable.id
}

resource "aws_route_table_association" "common-route-table-private" {
    subnet_id = aws_subnet.privatesubnet_app1.id
    route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "common-route-table-data" {
    subnet_id = aws_subnet.datasubnet_db1.id
    route_table_id = aws_route_table.data-route-table.id
}

resource "aws_eip" "public_eip" {
    network_interface = aws_network_interface.common-network-interface.id
    
}

resource "aws_eip" "private_eip" {
    network_interface = aws_network_interface.common-private-nw-interface.id
}

