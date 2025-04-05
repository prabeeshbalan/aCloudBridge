provider "aws" {
  region = "us-east-1"
}

module "aws-rds-mysql-free-tier" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 6.11.0"

  identifier = "minimal-mysql-db"

  engine            = "mysql"
  engine_version    = "8.0"
  instance_class    = "db.t4g.micro"
  allocated_storage = 10
  major_engine_version             = "8.0"
  family                           = "mysql8.0"

  db_name  = "app_database"
  username = "root"
  password = "Password25!"  
  port     = 3306

  iam_database_authentication_enabled = true

  vpc_security_group_ids = [var.aws-public-sg_id]  # Replace with your security group ID
  subnet_ids             = [var.aws-subnet-public-us-east-1a_id, var.aws-subnet-public-us-east-1b_id, var.aws-subnet-private-us-east-1a_id, var.aws-subnet-private-us-east-1b_id]
  create_db_subnet_group = true

  publicly_accessible = false  # Set to true if you want to access it over the internet

  deletion_protection = false  # Set to true for production
  skip_final_snapshot = true   # Set to false if you want a final snapshot before deletion

  tags = {
    Name        = "MinimalRDS"
    Environment = "dev"
  }
}