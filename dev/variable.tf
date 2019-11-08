variable "vpc_av" {
  description = "Vpc ID"
  default     = "vpc-**************"
}

variable "access_key" {
  description = "describe your variable"
  default     = "******************"
}

variable "secret_key" {
  description = "describe your variable"
  default     = "**********************"
}

variable "alb_type" {
  description = "Load Balancer Type"
  default     = "application"
}

variable "nazs" {
  description = "select region"
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "subnet_cidr" {
  description = "describe your variable"
  type        = "list"
  default     = ["subnet-1", "subnet-2", "subnet-3"]
}

variable "region" {
  description = "describe your variable"
  default     = "ap-south-1"
}
