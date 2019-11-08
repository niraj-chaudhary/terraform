#resource "aws_vpc" "main" {
#  cidr_block       = "${var.vpc_cidr}"
#  instance_tenancy = "${var.tenancy}"

#  tags = {
#    Name = "main"
#  }
#}

#resource "aws_subnet" "main" {
#  vpc_id     = "${var.vpc_id}"
#  cidr_block = "${var.subnet_cidr}"
#
#  tags = {
#    Name = "Main"
#  }
#}
/*
resource "aws_internet_gateway" "tf-gw" {
  vpc_id = "${data.aws_vpc.selected.id}"
  tags = {
    Name = "${var.gwname}"
  }
}
*/


#output "vpc_id" {
#  value = "${aws_vpc.main.id}"
#}

#output "subnet_id" {
#  value = "${aws_subnet.main.id}"
#}


data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

data "aws_availability_zones" "aza" {
  state = "available"
}


resource "aws_subnet" "example" {
  vpc_id            = "${data.aws_vpc.selected.state}"
  availability_zone = "${data.aws_availability_zones.aza.id}"
  cidr_block        = "${cidrsubnet(data.aws_vpc.selected.cidr_block, 4, 1)}"
}

