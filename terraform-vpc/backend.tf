terraform{
    backend "s3" {
        bucket = "terraform-bucket-common"
        key = "state/terraform.tfstate"
        region = "us-east-1"
        encrypt = true
        dynamodb_table = "terraform-common"
    }
    required_providers {
      aws = {
        source = "hashicorp/aws"
      }
    }
}

