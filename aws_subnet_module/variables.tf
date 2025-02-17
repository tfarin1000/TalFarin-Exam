variable "vpc_name" {
  type = string
  description = "Name of VPC to draw information from"
  default = "jb-aws-vpc-vpc"
}

variable "cidr_block" {
    type = string
    description = "The cidr_block for the subnet"
    default = "192.168.0.0/24"
}

variable "route_cidr_block" {
  type = string
  description = "the cidr block for the route table"
  default = "192.168.0.0/24"
}

variable "route_gateway_id" {
  type = string
  description = "the gateway id of the rout table"
  default = "local"
}