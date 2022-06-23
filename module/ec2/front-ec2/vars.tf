variable "ami" {
  type = string
  default = null
}

variable "type_instance" {
  type = string
  default = null
}

variable "subnet_id" {
  type = string
  default = null
}

variable "sg_id" {
  type = string
  default = null
}

variable "public_ssh_key" {
  type = string
  default = null
}

variable "ec2_user" {
  type = string
  default = null
}

variable "private_ssh_key" {
  type = string
  default = null
}

variable "ip_ec2" {
  type = string
  default = null
}

variable "name" {
  type = string
  default = "front-ec2"
}

