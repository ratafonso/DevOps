## Uncoment for use Terraform State File
#terraform {
#  backend "s3" {
#      bucket = "terraform-state-test"
#      key = "global/s3/terraform.tfstate"
#      region = "us-east-1"
#      dynamodb_table = "terraform-state-locking"
#      encrypt = true
#  }
#}

# Creating an VPC
resource "aws_vpc" "vpc-12345678" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags                 = var.tags
}

# Creating the Private Subnet A for Dev App Server
resource "aws_subnet" "PrivateSubnetA" {
  vpc_id            = aws_vpc.vpc-12345678.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags              = var.tags
}

# For running database instance on AWS, is necessary two subnets in different Available Zone inside Available Region;
# Creating the Private Subnet B for Database Instance
resource "aws_subnet" "PrivateSubnetB" {
  vpc_id            = aws_vpc.vpc-12345678.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags              = var.tags
}

# Creating the Private Subnet C for Database Instance
resource "aws_subnet" "PrivateSubnetC" {
  vpc_id            = aws_vpc.vpc-12345678.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags              = var.tags
}

#Creating a virtual instance
resource "aws_instance" "test_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.PrivateSubnetA.id
  tags          = var.tags
}

# Creating an Security Group for Internal\External access
resource "aws_security_group" "test_instance_sg" {
  name          = "Test-Instance"
  description   = "Allow SSH traffic"
  vpc_id        = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.ssh_cidr]
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  tags          = var.tags
}

# Creating an S3 Bucket for store Terraform State
resource "aws_s3_bucket" "terraform_state" {
  bucket = "terraform-state-test"

  lifecycle {
    prevent_destroy = true
  }

}

# Creating an DynamoDB table for store Terraform Locks
resource "aws_dynamodb_table" "terraform_locks" {
  name = "terraform-state-locking"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}

# Creating an Database MySQL Instance
resource "aws_db_instance" "DBServer" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name                 = "testdb"
  username             = "admin"
  password             = "Kiw23DScvbA1*"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db-net-group.id
}

# Creating an Database NetGroup foor High Availablity
resource "aws_db_subnet_group" "db-net-group" {
  name       = "dbsubnet"
  subnet_ids = [aws_subnet.PrivateSubnetB.id, aws_subnet.PrivateSubnetC.id]
  tags       = var.tags
}