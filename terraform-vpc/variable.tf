variable "cidr" {
    default = "195.0.0.0/16"
    description = "Cidr block for the VPC"
}

variable "public_subnet_web_az1" {
    default = "195.0.0.0/20"
    description = "Dividing the subnets"
}


variable "public_subnet_web_az2" {
    default = "195.0.16.0/20"
    description = "Dividing the subnets"
}

variable "availability_zone_web_subnet1" {
    default = "us-east-1a"
  
}

variable "availability_zone_web_subnet2" {
    default = "us-east-1b"
  
}

variable "private_subnet_app_az1" {
    default = "195.0.32.0/20"
}

variable "private_subnet_app_az2" {
    default = "195.0.48.0/20"
}

variable "availability_zone_app_subnet1" {
    default = "us-east-1c"
  
}

variable "availability_zone_app_subnet2" {
    default = "us-east-1d"
  
}

variable "data_subnet_db_1" {
    default = "195.0.64.0/24"
  
}
variable "data_subnet_db_2" {
    default = "195.0.80.0/24"
  
}

variable "availability_zone_db_subnet1" {
    default = "us-east-1e"
}

variable "availability_zone_db_subnet2" {
    default = "us-east-1f"
}


