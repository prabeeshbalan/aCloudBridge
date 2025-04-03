
# two public subents
resource "aws_subnet" "my-subnet-public-us-east-1a" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet-public-us-east-1a"
  }
}

resource "aws_subnet" "my-subnet-public-us-east-1b" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "my-subnet-public-us-east-1b"
  }
}

# two private subents
resource "aws_subnet" "my-subnet-private-us-east-1a" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"

  availability_zone = "us-east-1a"

  tags = {
    Name = "my-subnet-private-us-east-1a"
  }
}

resource "aws_subnet" "my-subnet-private-us-east-1b" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"

  availability_zone = "us-east-1b"

  tags = {
    Name = "my-subnet-private-us-east-1b"
  }
}