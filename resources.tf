################
#Define SSH Key Pair for your instance
################
resource "aws_key_pair" "default" {
  key_name = "singapore"
  public_key ="your key" 
}

##########################
## Define web server inside the public subnet
##########################
resource "aws_instance" "wb" {
  ami           = "ami-0fca02518e0faeb84"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.default.id} "
  subnet_id = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "${file("userdata.sh")}" 

   tags {
   Name = "Web Server"
      } 
}
##########################
## Define Database instance inside the private subnet
##########################
resource "aws_instance" "db" {
  ami           = "${var.ami}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.default.id} "
  subnet_id = "${aws_subnet.private-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgdb.id}"] 
  source_dest_check = false

  tags {
   Name = "Web Server"
} 
}
