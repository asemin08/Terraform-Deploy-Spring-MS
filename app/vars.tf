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

