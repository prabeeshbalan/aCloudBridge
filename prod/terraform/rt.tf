# Public route table for internet access
resource "aws_route_table" "my-rtb-public" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }
  tags = {
    Name = "my-rtb-public"
  }
}

# two local route table for access within vpc to attach to private subnet
resource "aws_route_table" "my-rtb-private-us-east-1a" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-rtb-private-us-east-1a"
  }
}
resource "aws_route_table" "my-rtb-private-us-east-1b" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-rtb-private-us-east-1b"
  }
}

# Route table-subnet associations
resource "aws_route_table_association" "a1-my-rtb-public" {
  subnet_id      = aws_subnet.my-subnet-public-us-east-1a.id
  route_table_id = aws_route_table.my-rtb-public.id
}
resource "aws_route_table_association" "a2-my-rtb-public" {
  subnet_id      = aws_subnet.my-subnet-public-us-east-1b.id
  route_table_id = aws_route_table.my-rtb-public.id
}
resource "aws_route_table_association" "my-rtb-private-us-east-1a" {
  subnet_id      = aws_subnet.my-subnet-private-us-east-1a.id
  route_table_id = aws_route_table.my-rtb-private-us-east-1a.id
}
resource "aws_route_table_association" "my-rtb-private-us-east-1b" {
  subnet_id      = aws_subnet.my-subnet-private-us-east-1b.id
  route_table_id = aws_route_table.my-rtb-private-us-east-1b.id
}