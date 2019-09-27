provider "aws" {
  region     = var.region
  access_key = "${var.scalr_aws_access_key}"
  secret_key = "${var.scalr_aws_secret_key}"
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "test_instance1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet
  associate_public_ip_address = var.associate_public_ip
  tags = merge({ "Name" = format("olga-tf-test -> %s -> %s", data.aws_ami.ubuntu.name, timestamp()) }, var.tags)
}
output "instance_id" {
 value = aws_instance.test_instance1.id
 sensitive = true
}
output "public_ip" {
 value = aws_instance.test_instance1.public_ip
 description = "srftsfrtrtdrt"
}
