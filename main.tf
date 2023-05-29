provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAZAYPWPVHQFCJOIPJ"
    secret_key = "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"  
}

variable "subnet_variable" {
  description = "assigning a variable"
}

variable "vpc_variable" {
  description = "vpc variable"
  default = "10.0.0.0/16"
  type = "string"
}

variable "environments" {
    description = "environment variable"

}


# creting a new vpc and its subnet using resource component
# resource is used to create a new resource on cloud platform using cloud provider
resource "aws_vpc" "development-vpc" {
  cidr_block = var.vpc_variable
  tags = {
    Name = "var.environments"
  }
}

resource "aws_subnet" "dev-subnet-1" {
   vpc_id = aws_vpc.development-vpc.id
   cidr_block = var.subnet_variable
   availability_zone = "ap-south-1a"
   tags = {
    Name = "subnet-1-dev"
   }
}
 
# creating a new subnet with existing default vpc using data resource component
# data resoruce is used to qurey the existing resources
/*data "aws_vpc" "existing_vpc" {
    default = true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "ap-south-1a"
       tags = {
    Name = "mysubnet2"
   }
}
output "dev-vpc" {
  value = aws_vpc.development-vpc.id
}

output "subnet-id" {
  value = aws_subnet.dev-subnet-1.id
}*/

