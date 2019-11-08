/*variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "tenancy" {
  default = "dedicated"
}

variable "vpc_id" {}

variable "subnet_cidr" {
  default = "10.0.1.0/24"
}
*/
variable "vpc_id" {}

variable "avg_zone" {
}

variable "gwname" {
  description = "describe your variable"
  default     = ""
}
