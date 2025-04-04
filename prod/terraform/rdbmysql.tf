# Subnet Group for RDS
resource "aws_db_subnet_group" "mysql_subnet_group" {
  name       = "mysql-subnet-group"
  subnet_ids = [
    aws_subnet.my-subnet-private-us-east-1a.id,
    aws_subnet.my-subnet-private-us-east-1b.id,
  ]
}

# RDS Instance
resource "aws_db_instance" "mysql_instance" {
  allocated_storage    = 20
  storage_type         = "gp3"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t4g.micro"
  db_name              = "app_database"
  username             = "admin"
  password             = "yoursecurepassword" # Use a secret management tool!
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = false # Very Important!
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
  db_subnet_group_name = aws_db_subnet_group.mysql_subnet_group.name
}

# RDS Security Group
resource "aws_security_group" "mysql_sg" {
  name        = "acloudbridge-mysql-sg"
  vpc_id      = aws_vpc.my-vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_group_id = aws_security_group.my-public-sg.id # Allow from EC2 SG
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_ipv4   = "0.0.0.0/0"
  }

  tags = {
    Name = "acloudbridge-mysql-sg"
  }
}