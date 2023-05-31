What is Terraform?

Terraform is a Infrastructure as a code(Iaac) used to automate and manage the infrastructure,platform and services that run on that patform developed by hashicrop wirtten in golang

--> It is open source

--> uses declarative language

Terraform Architecturre: 
2 important components

first component:

2 important sources  
                                                                    
**1-->terraform config file      

2-->terraform statefile **  [Current state vs desired state]  [Core(plan: what needs to be created/updated/deleted?) ]

Second component:

Providers(AWS, gcp, azure)[IAAS]

kubernetes[PAAS]

fastly[SAAS]
                              
                              
Terraform Commands:

terraform refresh - query infra proverder to get the current state

terraform plan - create an execution plan (simulation/blueprint/preview)

terraform apply -  execute the plan

terraform destroy - destroy the resources/infra



Download terraform:

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

create an account in AWS:

console.aws.amazon.com 

Now connect to aws account using terraform providers

Providers: How to talk with cloud providers
https://registry.terraform.io/providers/hashicorp/aws/latest/docs 

provider "aws" {

    region = "ap-south-1"

    access_key = ""
    
    secret_key = ""  

}

--> We are telling to terraform to use these credentials and connect to the aws account 

do terraform init --> terraform looks into the folder with main.tf congiuration file contains a provider and using  those atrributes terraform will install all the required plugins according to that provider (.terraform folder will be created basically its a hidden file)

After installing the provider we can use the n number of aws services and its resources

syntax:

resource "<provider>_<resourceType>" "codeblock name" {
  <parameters or atrributes>
}

ex: resource "aws_vpc" "dev-vpc"{
      cidr_block = "10.0.0.0/16"   
    }

After vpc subnet should be created subnet is inside the vpc so, 
    
    resource "aws_subnet" "dev-subnet" {
       vpc_id = "aws_vpc.dev-vpc.id"
       cidr_block = "10.0.10.0/24"
    }
    
   
Data resources: Allow data to be fetched for use in tf configuration (used to query the exixting resources)

    data "aws_vpc" "existing_vpc"{
        default = true
    }
 
     resource "aws_subnet" "dev-subnet-2"{
     vpc_id = data.aws_vpc.existing_vpc.id
     cidr_block = "172.31.48.0/20"
     availability_zone = "ap-south-1a"
     }
    

Environment variables: we can set environment variables in 2 types 
1. set an env variables in terminal by aws_secret_access_key then terraform will pickup

export AWS_SECRET_ACCESS_KEY=
export AWS_ACCESS_KEY_ID=

2. default storage for aws location env | grep aws
ls ~/.aws/credentials
by doing aws configure  then type access and secret keys 

Set variables using TF custom environment variables
export TF_var_avail_zone="ap-south-1a" 
basically TF_var prefix tells the terraform that this is a global variable and  takes from the locally defined variable

Setup ssh keys: insted of generating every time from console using resource we can automate 

resource "ssh-key_pair" "ssh-key" {
    key_name = "ssh-keys"
    public_key = "ssh-rsa ..." 
    or
    public_key = var.my_public_key (we can refer value in variable file)
    or 
    public_key = $(file(var.public_key
    )) (we can reference file location) 
}
