variable "env" {}
variable "component" {}
variable "tags" {
  default = {}
}
variable "subnets" {}
variable "vpc_id" {}
variable "sg_subnets_cidr" {}
variable "app_port" {}
variable "kms_key_id" {}
variable "instance_type" {}
variable "desired_capacity" {}
variable "max_size" {}
variable "min_size" {}
variable "allow_ssh_cidr" {}
variable "lb_dns_name" {}
variable "listener_arn" {}
variable "lb_rule_priority" {}
