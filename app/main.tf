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
