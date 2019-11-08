variable "sg_group" {
  default = ""
}

variable "subnet_cidr" {}

variable "front_port" {
  description = "listner port for alb"
  default     = "80"
}

variable "back_method" {
  description = "Backend Method for alb"
  default     = "forward"
}

variable "vpc_id" {}

variable "cluster_name" {}

variable "alb_type" {
  default = "application"
}
