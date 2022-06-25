resource "aws_instance" "enable-ec2" {
  ami = "${var.ami}"
  instance_type = "${var.type_instance}"

  # VPC
  subnet_id = "${var.subnet_id}"

  # Security Group
  vpc_security_group_ids = ["${var.sg_id}"]

  # the Public SSH key
  key_name = "${var.public_ssh_key}"
  private_ip = "${var.ip_ec2}"

  provisioner "local-exec" {

    inline = [
      "echo ${self.public_ip}",
    ]
  }


  tags = {
    Name = "${var.name}"
  }
}