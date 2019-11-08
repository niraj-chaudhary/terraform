variable "region" {
  default = "ap-south-1"
}

variable "launch_conf" {}

variable "nazs" {}

variable "ec2_ami" {
  type = "map"

  default = {
    ap-south-1 = "ami-02913db388613c3e1"
  }
}

variable "key_name" {}

variable "subnet_cidr" {}

variable "vpc_id" {
  default = "vpc-"
}

variable "ins_type" {
  default = "t2.micro"
}

variable "alb-arn" {}

variable "asg_name" {}

variable "cluster_name" {
  description = "describe your variable"

}

# Declare the data source
data "aws_availability_zones" "azs" {}
