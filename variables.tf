variable "env" {}
variable "component" {}
variable "tags" {
  default = {}
}
variable "subnet_id" {}
variable "vpc_id" {}
variable "sg_subnets_cidr" {}
variable "app_port" {}
variable "kms_key_id" {}
variable "instance_type" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
