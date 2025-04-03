
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
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3005" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3005
  ip_protocol       = "tcp"
  to_port           = 3005
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my-public-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

