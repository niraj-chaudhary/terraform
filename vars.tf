variable "region" {
  default = "us-west-2"
#  default = "ap-south-1"
}

#variable "vpc_cidr" {
#  default = "190.160.0.0/16"
#}

#variable "subnet_cidr" {
#  type = "list"
#  default = ["190.160.1.0/24","190.160.2.0/24","190.160.3.0/24"]
#}

variable "nazs" {
  type = "list"
  default = ["us-west-2a","us-west-2b","us-west-2c"]
}

variable "ec2_ami" {
  type = "map"

  default = {
  us-west-2 = "ami-ID"
  ap-south-1 = "ami-ID"
  }
}

variable "key_name" {
  default = "kafka_staging"
} 

#variable "nazs" {
#  type = "list"
#  default = ["ap-south-1a","ap-south-1b","ap-south-1c"]
#}

variable "subnet_cidr" {
  type = "list"
  default = ["subnet-1", "subnet-2", "subnet-3"]
}

variable "vpc_id" {
  default = "vpc-ID"
}

variable "ins_type" {
  default = "t2.medium"
}

# Declare the data source
data "aws_availability_zones" "azs" {}
