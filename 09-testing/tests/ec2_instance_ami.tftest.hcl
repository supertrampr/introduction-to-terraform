run "check_ec2_ami" {
  command = plan

  assert {
    condition     = aws_instance.this.ami == "ami-0699c78c4486e5f1e"
    error_message = "The ami specified did not match the required value."
  }
}