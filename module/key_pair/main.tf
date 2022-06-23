resource "aws_key_pair" "projet_key_pair" {
  key_name = "${var.name}"
  public_key = "${file(var.public_path_ssh_key)}"
}