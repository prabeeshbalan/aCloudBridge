# Create network acl
resource "aws_network_acl" "my-nacl" {
  vpc_id = aws_vpc.my-vpc.id

  egress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  ingress {
    protocol   = "-1"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  tags = {
    Name = "my-nacl"
  }
}

# nacl-subnet association
resource "aws_network_acl_association" "a1-nacl-subnet" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.my-subnet-public-us-east-1a.id
}
resource "aws_network_acl_association" "a2-nacl-subnet" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.my-subnet-public-us-east-1b.id
}
resource "aws_network_acl_association" "a3-nacl-subnet" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.my-subnet-private-us-east-1a.id
}
resource "aws_network_acl_association" "a4-nacl-subnet" {
  network_acl_id = aws_network_acl.my-nacl.id
  subnet_id      = aws_subnet.my-subnet-private-us-east-1b.id
}