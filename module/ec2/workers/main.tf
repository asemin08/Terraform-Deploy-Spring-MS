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

  tags = {
    Name = "${var.name}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y docker",
      "sudo systemctl start docker",
      "sudo usermod -aG docker ${var.ec2_user}"

    ]
    connection {
      type        = "ssh"
      user        = "${var.ec2_user}"
      private_key = file("${var.private_ssh_key}")
      host        = "${self.public_ip}"
    }
  }
}