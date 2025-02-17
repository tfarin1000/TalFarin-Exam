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