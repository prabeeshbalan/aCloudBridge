# vpc 
resource "aws_vpc" "my-vpc" {

  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }

  enable_dns_support   = true
  enable_dns_hostnames = true

}