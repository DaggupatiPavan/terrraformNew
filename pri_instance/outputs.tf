output "instance_private_ip" {
   value = aws_instance.priv_instance[*].private_ip
}