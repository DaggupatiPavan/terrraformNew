provider "aws" {
  /* region = var.region */
  region = "us-east-1"
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "platformEngineering"
    workspaces = {
      name = "vpc"
    }
  }
}

resource "aws_instance" "priv-instance" {
  root_block_device {
    volume_size = var.storage_size
  }
  ami                         = var.ami-Id
  instance_type               = var.InstanceType
  associate_public_ip_address = false
  count                       = var.instance_count
  /* subnet_id                   = var.subnet_id 
  vpc_security_group_ids      = [var.security_group_id] */
  vpc_security_group_ids = ["sg-0f9651f4874813256"]
  subnet_id              = element(data.terraform_remote_state.vpc.outputs.private_subnet_ids, count.index)
  key_name               = var.key_name
  user_data              = file("./myscript.sh")
  tags = {
    Name   = "instance-${count.index + 1}"
    Owner  = var.Owner
    mailID = var.mailID
  }
}