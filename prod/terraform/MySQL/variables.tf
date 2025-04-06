variable "aws-subnet-public-us-east-1a_id" {
  description = "aws-subnet-public-us-east-1a_id"
}
variable "aws-subnet-public-us-east-1b_id" {
  description = "aws-subnet-public-us-east-1b_id"
}
variable "aws-subnet-private-us-east-1a_id" {
  description = "aws-subnet-private-us-east-1a_id"
}
variable "aws-subnet-private-us-east-1b_id" {
  description = "aws-subnet-private-us-east-1b_id"
}
variable "aws-public-sg_id" {
  description = "aws_security_group.aws-public-sg.id"
}
variable "db_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}
variable "db_username" {
  description = "The master user for the RDS instance"
  type        = string
  sensitive   = true
}
variable "db_name" {
  description = "The master user for the RDS instance"
  type        = string
  sensitive   = true
}