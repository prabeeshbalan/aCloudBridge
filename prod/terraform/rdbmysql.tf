resource "aws_db_instance" "mysql_instance" {
  allocated_storage    = 20
  storage_type         = "gp3"
  engine               = "mysql"
  engine_version       = "8.0" # Choose your desired version
  instance_class       = "db.t4g.micro"
  name                 = "app_database"
  username             = "root"
  password             = "Password25!" # Use a secret management tool in production!
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  publicly_accessible = false
  vpc_security_group_ids = [aws_security_group.mysql_sg.id]
}

resource "aws_security_group" "mysql_sg" {
  name        = "mysql-sg"
  description = "Allow MySQL traffic from application servers"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24"] #Replace with your application server IP.
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}