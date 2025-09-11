variables {
  prefix = "test"
}

run "check_ec2_name" {
  command = plan

  assert {
    condition     = aws_instance.this.tags_all["Name"] == "test-ec2"
    error_message = "EC2 Instance name didn't match what expected."
  }
}