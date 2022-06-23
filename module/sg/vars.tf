variable "vpc_id" {
  type = string
  default = null
}

variable "name_security-group" {
  type = string
  default = "sg-ssh-http-allowed"
}