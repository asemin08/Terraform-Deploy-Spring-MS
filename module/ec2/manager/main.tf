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
    source      = "projet_key_pair"
    destination = "./projet_key_pair"

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
      "sudo yum install -y git",
      "sudo amazon-linux-extras install -y docker ansible2",
      "sudo service docker start",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ${var.ec2_user}",
      "git clone -b ansible https://github.com/asemin08/Terraform-Deploy-Spring-MS.git",
      "chmod 600 projet_key_pair",
      "cp projet_key_pair Terraform-Deploy-Spring-MS",
      "chmod 755 Terraform-Deploy-Spring-MS",
      "cd Terraform-Deploy-Spring-MS",
#       "ansible-playbook -i hosts.yaml playgroud.yaml --private-key=projet_key_pair",
#       "ansible-playbook -i hosts.yaml deploy-config.yaml --private-key=projet_key_pair"
    ]
    connection {
      type        = "ssh"
      user        = "${var.ec2_user}"
      private_key = file("${var.private_ssh_key}")
      host        = "${self.public_ip}"
    }
  }
}
