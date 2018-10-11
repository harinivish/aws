# Define our VPC
resource "aws_vpc" "default" {
    cidr_block                       = "${var.vpc_cidr}"
    enable_dns_hostnames             = true
   tags {
    Name = "test-vpc"
}
}

################
# Public subnet
################
resource "aws_subnet" "public-subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.public_subnet_cidr}"
  availability_zone       = "ap-sotheast-1"
   
  tags {
  Name = "Web Public Subnet"
}
}
################
# Private subnet
################
resource "aws_subnet" "private-subnet" {
  vpc_id                  = "${aws_vpc.default.id}"
  cidr_block              = "${var.private_subnet_cidr}"
  availability_zone       = "us-east-1b"
   
  tags {
  Name = "Database Private Subnet"
}
}
##############
# Internet Gateway
##############
resource "aws_internet_gateway" "gw" {
  vpc_id                  = "${aws_vpc.default.id}"

   tags {
  Name = "VPC IGW"
}
}
#########################
# Route table 
##########################
resource "aws_route_table" "web-public-rt" {
   vpc_id                  = "${aws_vpc.default.id}"
   route {
   cidr_block = "0.0.0.0/0"
   gateway_id             = "${aws_internet_gateway.gw.id}"
}
  tags {
   Name ="Public Subnet RT"
}
}
##########################
# Assign the Route table to Public Subnet
##########################
resource "aws_route_table_association" "web-public-rt" {
  subnet_id      = "${aws_subnet.public-subnet.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

##########################
# Security group for public subnet
##########################
resource "aws_security_group" "sgweb" {
  name        = "vpc_test_web"
  description = "Aloow incoming HTTP Connection and SSH Access"

   ingress {
    from_port = 80
    to_port   = 80
    protocol  ="tcp"
    cidr_block = ["0.0.0.0/0"]
}

ingress {
    from_port = 443
    to_port   = 443
    protocol  ="tcp"
    cidr_block = ["0.0.0.0/0"]
}
  ingress {
    from_port = -1
    to_port   = -1
    protocol  ="icmp"
    cidr_block = ["0.0.0.0/0"]
}
  ingress {
    from_port = 22
    to_port   = 22
    protocol  ="tcp"
    cidr_block = ["0.0.0.0/0"]
}
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_block = ["0.0.0.0/0"]
}
  vpc_id                  = "${aws_vpc.default.id}"
   tags {
    Name = "Web Server SG"
}
}
##########################
# Security group for private subnet
##########################
resource "aws_security_group" "sgdb" {
  name        = "sg_test_web"
  description = "Allow traffic from Public Subnet"
   ingress {
    from_port = 3306
    to_port   = 3306
    protocol  ="tcp"
    cidr_block = ["0.0.0.0/0"]
 }
   ingress {
    from_port = -1
    to_port   = -1
    protocol  ="icmp"
    cidr_block = ["0.0.0.0/0"]
}
  ingress {
    from_port = 22
    to_port   = 22
    protocol  ="tcp"
    cidr_block = ["0.0.0.0/0"]
}
 vpc_id                  = "${aws_vpc.default.id}"
   tags {
    Name = "DB Server SG"
}
}

