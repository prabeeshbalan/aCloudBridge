
# Security group public access
resource "aws_security_group" "my-public-sg" {

  name   = "my-public-sg"
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-public-sg"
  }
}

# inbound rules to all ssh to 22 from everywhere
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

# inbound rules to all ssh to 22 from everywhere
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3000" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 3000
}
# inbound rules to all ssh to 22 from everywhere
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3001" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3001
  ip_protocol       = "tcp"
  to_port           = 3001
}
# inbound rules to all ssh to 22 from everywhere
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_5000" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 5000
  ip_protocol       = "tcp"
  to_port           = 5000
}
  resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

