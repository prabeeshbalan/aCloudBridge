output "terraform_db_endpoint" {
  value = module.aws-rds-mysql-free-tier.db_instance_address
}

output "terraform_db_username" {
  value = module.aws-rds-mysql-free-tier.db_instance_username
}

output "terraform_db_password" {
  value = module.aws-rds-mysql-free-tier.db_instance_password
  sensitive = true
}

output "terraform_db_name" {
  value = module.aws-rds-mysql-free-tier.db_name
}