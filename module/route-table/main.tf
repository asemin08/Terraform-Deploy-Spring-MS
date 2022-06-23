# create a custom route table for public subnets
# public subnets can reach to the internet buy using this
resource "aws_route_table" "prod-public-crt" {
  vpc_id = "${var.vpc_id}"
  route {
    cidr_block = "0.0.0.0/0" //associated subnet can reach everywhere
    gateway_id = "${var.prod-igw}" //CRT uses this IGW to reach internet
  }

  tags = {
    Name = "${var.name_route_table}"
  }
}