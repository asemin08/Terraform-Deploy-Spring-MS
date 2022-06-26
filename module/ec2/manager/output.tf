output "ec2_id" {
  value = aws_instance.enable-ec2.id
}

output "name_ec2" {
  value = aws_instance.enable-ec2.tags.Name
}

output "publiv_ip_ec2" {
  value = aws_instance.enable-ec2.public_ip
}