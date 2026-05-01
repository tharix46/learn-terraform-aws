resource "aws_instance" "demo" {
  ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
  instance_type = "t2.micro"
  count         = var.instance_count

  tags = {
    Name = "${local.name_prefix}-instance"
  }
}