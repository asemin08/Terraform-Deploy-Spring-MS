variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

variable "AWS_REGION" {
  type = string
  default = "us-west-1"
}

variable "auteur" {
  type = string
  default = "allan"
}

variable "cidr_block" {
  type = string
  default = "192.168.1.0/28"
}

variable "public_path_ssh_key" {
  type = string
  default = "projet_key_pair.pub"
}

variable "ec2_user" {
  type = string
  default = "ec2-user"
}

variable "type_instance" {
  type = string
  default = "t2.micro"
}

variable "id_amazon_ami" {
  type = string
  default = "ami-0d9858aa3c6322f73"
}

variable "private_path_ssh_key" {
  type = string
  default = "projet_key_pair"
}