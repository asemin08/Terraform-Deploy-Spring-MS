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

  provisioner "file" {
    source      = file("${var.private_ssh_key}")
    destination = "./private_ssh_key"

    connection {
      type     = "ssh"
      user     = "${var.ec2_user}"
      private_key = file("${var.private_ssh_key}")
      host     = "${self.public_ip}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras list | grep ansible2",
      "sudo amazon-linux-extras enable ansible2",
      "sudo yum install -y ansible git",
      "git clone -b ansible https://github.com/asemin08/Terraform-Deploy-Spring-MS.git",
      "cd Terraform-Deploy-Spring-MS",
      "ansible-playbook -i hosts.yaml playgroud.yaml --private-key=file(\"${var.private_ssh_key}\")"
    ]
    connection {
      type        = "ssh"
      user        = "${var.ec2_user}"
      private_key = file("${var.private_ssh_key}")
      host        = "${self.public_ip}"
    }
  }
}