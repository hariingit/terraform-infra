variable "ami_for_instance" {
    default = "ami-064519b8c76274859"
}

variable "instance_type" {

    default = "t2.nano"
} 
variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "aws_access_key_id" {
  type        = string
  sensitive   = true
  description = "AWS Access Key ID"
}

variable "aws_secret_access_key" {
  type        = string
  sensitive   = true
  description = "AWS Secret Access Key"
}