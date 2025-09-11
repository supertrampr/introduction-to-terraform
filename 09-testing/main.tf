resource "aws_instance" "this" {
  ami           = "ami-0699c78c4486e5f1e"
  instance_type = "t3.micro"

  tags = {
    "Name" = "${var.prefix}-ec2"
  }
}