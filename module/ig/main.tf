# create an IGW (Internet Gateway)
# It enables your vpc to connect to the internet
resource "aws_internet_gateway" "prod-igw" {
  vpc_id = "${var.vpc_id}"

  tags = {
    Name = "${var.name_ig}"
  }
}