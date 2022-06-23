#Instanciation module vpc
module "aws_vpc" {
  source        = "../module/vpc"
  cidr_block    = "${var.cidr_block}"
}

#Instanciation module subnet
module "aws_subnet" {
  source        = "../module/subnet"
  vpc_id        = "${module.aws_vpc.vpc_id}"
  cidr_block    = "${var.cidr_block}"
  availability_zone = "${var.AWS_REGION}a"
}

#Instanciation module ig
module "aws_ig" {
  source        = "../module/ig"
  vpc_id        = "${module.aws_vpc.vpc_id}"
}

#Instanciation module route table
module "aws_route-table" {
  source        = "../module/route-table"
  vpc_id        = "${module.aws_vpc.vpc_id}"
  prod-igw      = "${module.aws_ig.subnet_id}"
}

# route table association for the public subnets
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id = "${module.aws_subnet.subnet_id}"
  route_table_id = "${module.aws_route-table.route_table_id}"
}