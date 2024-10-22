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

Subnet Types
We have three types of subnets:
Public: Hosts publicly accessible resources (e.g., web servers, load balancers)
Private: Hosts internal resources (e.g., application servers, databases)
Database: Hosts database instances
Subnet Allocation
The following table summarizes the subnet allocation:
Subnet Type	Starting CIDR	Increment
Public	195.0.0.0/20	+16
Private	195.0.32.0/20	+16
Database	195.0.64.0/20	+16
Example Subnets
Here are some example subnets:
Subnet Name	CIDR Block	Availability Zone	IPs
Public 1	195.0.0.0/20	AZ1	4096
Public 2	195.0.16.0/20	AZ2	4096
Private 1	195.0.32.0/20	AZ1	4096
Private 2	195.0.48.0/20	AZ2	4096
Database 1	195.0.64.0/20	AZ1	4096
Database 2	195.0.80.0/20	AZ2	4096
Benefits
This subnet allocation strategy provides:
Clear separation of public, private, and database resources
Easy scalability and expansion
Simplified network management and troubleshooting


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
* Submit pull request.![Publicsubnet drawio (2)](https://github.com/user-attachments/assets/595d036d-7cc7-41ad-bb70-c5a74e0e8421)

