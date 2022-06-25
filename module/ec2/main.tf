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

  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y docker",
      "sudo systemctl start docker",
    ]
  }

  connection {
    host = "${self.public_ip}"
    type = "ssh"
    user = "${var.ec2_user}"
    private_key = "${file("${var.private_ssh_key}")}"
  }

  tags = {
    Name = "${var.name}"
  }
}