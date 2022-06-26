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

#Instanciation module security group
module "aws_sg" {
  source        = "../module/sg"
  vpc_id        = "${module.aws_vpc.vpc_id}"
}

#Instanciation module key_pair
module "aws_key_pair" {
  source        = "../module/key_pair"
  public_path_ssh_key= "${var.public_path_ssh_key}"
}
module "aws-ec2-workers" {
  count = 3
  source = "../module/ec2/workers"
  ec2_user = "${var.ec2_user}"
  type_instance = "${var.type_instance}"
  ami = "${var.id_amazon_ami}"
  private_ssh_key = "${var.private_path_ssh_key}"
  public_ssh_key = "${module.aws_key_pair.key_pair_id}"
  sg_id = "${module.aws_sg.sg-ssh-http-id}"
  subnet_id = "${module.aws_subnet.subnet_id}"
  ip_ec2 = "192.168.1.${6 + count.index}"
  name = "ms-projet-ec2-worker-${count.index}"
}

module "aws-ec2-manager" {
  source = "../module/ec2/manager"
  ec2_user = "${var.ec2_user}"
  type_instance = "${var.type_instance}"
  ami = "${var.id_amazon_ami}"
  private_ssh_key = "${var.private_path_ssh_key}"
  public_ssh_key = "${module.aws_key_pair.key_pair_id}"
  sg_id = "${module.aws_sg.sg-ssh-http-id}"
  subnet_id = "${module.aws_subnet.subnet_id}"
  ip_ec2 = "192.168.1.5"
  name = "ms-projet-ec2-manager"

}

# route table association for the public subnets
resource "null_resource" "set_public_ip_for_manager" {
    depends_on = [module.aws-ec2-manager]
    provisioner "remote-exec" {
      inline = [
        "sudo apt update -y",
        "sudo apt install software-properties-common",
        "sudo add-apt-repository --yes --update ppa:ansible/ansible",
        "sudo apt install --yes ansible",
        #      "git clone https://github.com/${var.git_proprietaire}/${var.git_projet}.git",
        #      "cd ${var.git_projet}",
        #      "ansible-galaxy install -r requirements.yml --force",
        #      "ansible-playbook -i hosts.yml gestionGlasses.yml"
      ]
      connection {
        type        = "ssh"
        user        = "${var.ec2_user}"
        private_key = "${file("${var.private_ssh_key}")}"
        host        = "${module.aws-ec2-manager.publiv_ip_ec2}"
      }
    }
}

# route table association for the public subnets
resource "aws_route_table_association" "prod-crta-public-subnet-1" {
  subnet_id = "${module.aws_subnet.subnet_id}"
  route_table_id = "${module.aws_route-table.route_table_id}"
}