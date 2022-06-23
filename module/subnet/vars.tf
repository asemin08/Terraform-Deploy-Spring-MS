variable "name_subnet" {
  type = string
  default = "prod-subnet-public-1"
}

variable "availability_zone" {
  type = string
  default = null
}

variable "cidr_block" {
  type = string
  default = null
}

variable "vpc_id" {
  type = string
  default = null
}