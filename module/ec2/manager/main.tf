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
      "sudo apt update -y",
      "sudo apt install software-properties-common",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install --yes ansible",
#      "git clone https://github.com/${var.git_proprietaire}/${var.git_projet}.git",
#      "cd ${var.git_projet}",
#      "ansible-galaxy install -r requirements.yml --force",
#      "ansible-playbook -i hosts.yml gestionGlasses.yml"
    ]
    connection {
      type        = "ssh"
      user        = "${var.utilisateur_ssh}"
      private_key = file("../.aws/${var.cle_ssh}.pem")
      host        = "${self.public_ip}"
    }
  }


  tags = {
    Name = "${var.name}"
  }
}