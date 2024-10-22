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

Subnet Allocation Strategy
================================
Subnet Types
=====================
We have three types of subnets:
1. Public
Hosts publicly accessible resources (e.g., web servers, load balancers)
2. Private
Hosts internal resources (e.g., application servers, databases)
3. Database
Hosts database instances

Subnet Allocation
-------------------
Example Subnets
-----------------
<table>
<tr>
<th>Subnet Type</th>
<th>Starting CIDR</th>
<th>Increment</th>
</tr>
<tr>
<td>Public</td>
<td>195.0.0.0/20</td>
<td>+16</td>
</tr>
<tr>
<td>Private</td>
<td>195.0.32.0/20</td>
<td>+16</td>
</tr>
<tr>
<td>Database</td>
<td>195.0.64.0/20</td>
<td>+16</td>
</tr>
</table>

<table>
<tr>
<th>Subnet Name</th>
<th>CIDR Block</th>
<th>Availability Zone</th>
<th>IPs</th>
</tr>
<tr>
<td>Public 1</td>
<td>195.0.0.0/20</td>
<td>AZ1</td>
<td>4096</td>
</tr>
<tr>
<td>Public 2</td>
<td>195.0.16.0/20</td>
<td>AZ2</td>
<td>4096</td>
</tr>
<tr>
<td>Private 1</td>
<td>195.0.32.0/20</td>
<td>AZ1</td>
<td>4096</td>
</tr>
<tr>
<td>Private 2</td>
<td>195.0.48.0/20</td>
<td>AZ2</td>
<td>4096</td>
</tr>
<tr>
<td>Database 1</td>
<td>195.0.64.0/20</td>
<td>AZ1</td>
<td>4096</td>
</tr>
<tr>
<td>Database 2</td>
<td>195.0.80.0/20</td>
<td>AZ2</td>
<td>4096</td>
</tr>
</table>

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


