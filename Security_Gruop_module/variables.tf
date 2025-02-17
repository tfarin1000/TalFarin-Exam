#
# to be able to use the names i want and not the default, i can run manually-  terraform plan -var sg_name="tal_sg"
# to be able to use my own vars i will fill them in the my_vars file according to this file's variables
variable "sg_name" { # i use them in main.tf at the security group resource
    type = string
    description = "The name of created security group"
    default = "demo-sg" # if i dont specify any name in the resource the deafualt name will be taken from here
}

variable "sg_description" {
    type = string
    description = "The description of thid security group" 
    default = "demo security group" 
}

variable "sg_tags" {
  type = map(string)  #tags = { Name = "tal_sg"} this is a dictionary of tags with strings in it so the type will be a map with strings
  description = " The Security Group tags"
  default = {
    "name" = "Demo-SG"
    "managed-By" = "Terraform"
  }
}

variable "ingress_ipv4_cider" {
  type = string
  description = "Ingress Cidr for SG Rule"
  default = "192.168.0.0" # we put a default that we wont use so we will know its not updated propary and need to set it
}

variable "ingress_from_port" {
  type = number
  description = "Default From Port"
  default = 80
}

variable "ingress_to_port" {
  type = number
  description = "Default To Port"
  default = 80
}

variable "ingress_ip_protocol" {
  type = string
  description = "Default IP Protocol"
  default = "tcp"
}

variable "egress_ipv4_cider" {
  type = string
  description = "egress Cidr for SG Rule"
  default = "0.0.0.0/0" 
}

variable "egress_ip_protocol" {
  type = string
  description = "Defaul Egress SG rule"
  default = "-1"
}

variable "vpc_name" {
  type = string
  description = "Name of VPC to draw information from"
  default = "jb-aws-vpc-vpc"
}