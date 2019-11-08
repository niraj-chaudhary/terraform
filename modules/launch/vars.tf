variable "region" {
  default = "ap-south-1"
}

variable "nazs" {
  type    = "list"
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "ec2_ami" {
  type = "map"

  default = {
    ap-south-1 = "ami-03dcedc81ea3e7e27"
  }
}

variable "key_name" {}

variable "ins_type" {
  default = "t2.micro"
}

variable "sg_id" {}

variable "cluster_name" {
  description = "describe your variable"

}
# Declare the data source
data "aws_availability_zones" "azs" {}
