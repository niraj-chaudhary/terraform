provider "aws" {
  region     = "ap-south-1"
  access_key = "${var.access_key}" 
  secret_key = "${var.secret_key}"
}

#/*module "my_vpc" {
#	source = "../modules/vpc"
#	vpc_cidr = "192.168.0.0/16"
#	tenancy  = "default"
#	vpc_id = "${module.my_vpc.vpc_id}"
#	subnet_cidr = "192.168.1.0/24"
#}

#module "my_ec2" {
#	source = "../modules/ec2"
#	ec2_count = "1"
#	ami_id	= "ami-03dcedc81ea3e7e27"
#	instance_type = "t2.micro"
#	subnet_id = "${module.my_vpc.subnet_id}"
#}*/

module "sec_id" {
  source       = "../modules/sg"
  vpc_id       = "${var.vpc_av}"
  cluster_name = "alb-sg"
}

module "aws_alb" {
  source       = "../modules/alb"
  sg_group     = "${module.sec_id.asg_id}"
  vpc_id       = "${var.vpc_av}"
  cluster_name = "tf-alb"
  subnet_cidr  = "${var.subnet_cidr}"
}


/*module "vpc_name" {
  source = "../modules/vpc"
  vpc_id = "${var.vpc_av}"
  gwname = "tf-gw"
}*/

module "my_asg" {
  source       = "../modules/autoscaling"
  asg_name     = "dev"
  cluster_name = "dev"
  subnet_cidr  = "${var.subnet_cidr}"
  launch_conf  = "${module.my_launch.launch_name}"
  nazs         = "${var.nazs}"
  key_name     = "${module.sec_id.key_name}"
  alb-arn      = "${module.aws_alb.alb_arn}"
}

module "my_launch" {
  source       = "../modules/launch"
  cluster_name = "dev-launch"
  sg_id        = "${module.sec_id.sg_id}"
  key_name     = "${module.sec_id.key_name}"
}

