variable "vpc_id" {
  type = string
  default = null
}

variable "prod-igw" {
  type = string
  default = null
}

variable "name_route_table" {
  type = string
  default = "prod-public-crt"
}