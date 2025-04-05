terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.92.0"
    }
  }

  backend "local" {
    path = "state/terraform.tfstate"
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

module "aws-vpc-free-tier" {
  source = "./vpc"
}

module "aws-igw-free-tier" {
  source               = "./Gateway"
  aws-vpc-free-tier_id = module.aws-vpc-free-tier.aws-vpc-free-tier_id
}

module "aws-nacl-free-tier" {
  source                           = "./NACL"
  aws-vpc-free-tier_id             = module.aws-vpc-free-tier.aws-vpc-free-tier_id
  aws-subnet-public-us-east-1a_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1a_id
  aws-subnet-public-us-east-1b_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1b_id
  aws-subnet-private-us-east-1a_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1a_id
  aws-subnet-private-us-east-1b_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1b_id
}

module "aws-subnet-free-tier" {
  source               = "./Subnet"
  aws-vpc-free-tier_id = module.aws-vpc-free-tier.aws-vpc-free-tier_id
}

module "aws-rtb-free-tier" {
  source                           = "./RouteTable"
  aws-vpc-free-tier_id             = module.aws-vpc-free-tier.aws-vpc-free-tier_id
  aws-subnet-public-us-east-1a_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1a_id
  aws-subnet-public-us-east-1b_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1b_id
  aws-subnet-private-us-east-1a_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1a_id
  aws-subnet-private-us-east-1b_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1b_id
  aws-igw-free-tier_id             = module.aws-igw-free-tier.aws-igw-free-tier_id
}

module "aws-sg-free-tier" {
  source               = "./SecurityGroup"
  aws-vpc-free-tier_id = module.aws-vpc-free-tier.aws-vpc-free-tier_id
}

module "aws-ec2-free-tier" {
  source                          = "./ec2"
  aws-public-sg_id                = module.aws-sg-free-tier.aws-public-sg_id
  aws-subnet-public-us-east-1a_id = module.aws-subnet-free-tier.aws-subnet-public-us-east-1a_id
}

module "aws-rds-mysql-free-tier" {
  source                          = "./MySQL"
  aws-public-sg_id                = module.aws-sg-free-tier.aws-public-sg_id
  aws-subnet-public-us-east-1a_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1a_id
  aws-subnet-public-us-east-1b_id  = module.aws-subnet-free-tier.aws-subnet-public-us-east-1b_id
  aws-subnet-private-us-east-1a_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1a_id
  aws-subnet-private-us-east-1b_id = module.aws-subnet-free-tier.aws-subnet-private-us-east-1b_id
}