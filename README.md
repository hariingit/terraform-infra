# Terraform Infrastructure Setup
============================

## Table of Contents
- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [Terraform Commands](#terraform-commands)
- [Infrastructure Components](#infrastructure-components)

## Overview

This Terraform configuration sets up a basic AWS infrastructure, including:

* Virtual Private Cloud (VPC)
* EC2 instance

## Prerequisites

* AWS account
* AWS CLI configured
* Terraform installed (version 1.3+)

## Setup

1. Clone this repository.
2. Navigate to the repository directory.
3. Initialize Terraform: `terraform init`
4. Review the infrastructure plan: `terraform plan`
5. Apply the infrastructure configuration: `terraform apply`

## Terraform Commands

| Command | Description |
| --- | --- |
| `terraform init` | Initialize Terraform working directory |
| `terraform plan` | Generate and show execution plan |
| `terraform apply` | Apply changes to infrastructure |
| `terraform destroy` | Destroy infrastructure |

## Infrastructure Components

* VPC: `terraform-vpc`
	+ CIDR block: `10.0.0.0/16`
	+ Region: `us-west-2`
* EC2 instance: `terraform-ec2-instance`
	+ AMI: `ami-xxxxxxxxxxxxxxxxx`
	+ Instance type: `t2.micro`
	+ Subnet: `public-subnet`

## Troubleshooting

* Check Terraform logs for errors.
* Verify AWS credentials.
* Consult Terraform documentation.


## Contributing

* Fork this repository.
* Make changes.
* Submit pull request.
