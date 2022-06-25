output "ec2_id" {
  value = aws_instance.enable-ec2.id
}

output "name_ec2" {
  value = aws_instance.enable-ec2.tags.Name
}