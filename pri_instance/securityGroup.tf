/* data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../vpc/terraform.tfstate"
  }
} */

/* resource "aws_security_group" "security_sg" {
    name        = var.security_sg_pri_name
    description = "Allow HTTPS to web server"  #data.terraform_remote_state.vpc.outputs.default_security_group_id
    vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

    ingress {
        description = "HTTPS ingress"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [
            data.terraform_remote_state.vpc.outputs.vpc_cidr_block
        ]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
   }
} */

resource "aws_security_group" "security_sg" {
    description = "Allow HTTPS to web server"  # Replace with your description
    vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
  
    ingress {
      description = "Kubernetes inbound ports"
      from_port   = [6443, 2379, 10250, 10259, 10257, 30000]
      to_port     = [6443, 2380, 10250, 10259, 10257, 32767]
      protocol    = "tcp"
      cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
    }
  
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
