resource "aws_instance" "my-public-ec2" {

  ami             = "ami-0453ec754f44f9a4a"
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.my-subnet-public-us-east-1a.id
  vpc_security_group_ids = [ aws_security_group.my-public-sg.id ]
  associate_public_ip_address = true

  key_name = "my_tf_key"

  tags = {
    Name = "my-public-ec2"
  }

}

resource "aws_key_pair" "my_tf_key" {

  key_name   = "my_tf_key"
  public_key = tls_private_key.rsa.public_key_openssh

}

resource "tls_private_key" "rsa" {

  algorithm = "RSA"
  rsa_bits  = 4096

}

resource "local_file" "my_tf_key" {

  content  = tls_private_key.rsa.private_key_pem
  filename = "my_tf_key.pem"

}

output "instance_public_ip" {

  value = aws_instance.my-public-ec2.public_ip

}