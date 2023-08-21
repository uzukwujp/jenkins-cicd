
# generating a key material
resource "tls_private_key" "jenkins_lab" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# creating an aws key pair
resource "aws_key_pair" "jenkins_key" {
  key_name   = var.key_name
  public_key = tls_private_key.jenkins_lab.public_key_openssh
}


# stores the private key of the aws key pair to computers filesysyem.
resource "local_file" "jenkins_file" {
  content  = tls_private_key.jenkins_lab.private_key_pem
  filename = "${path.module}/jenkins.pem"
}


# get the AMI from AWS
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Creates an EC2 instance.
resource "aws_instance" "ubuntu_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = aws_key_pair.jenkins_key.key_name
}