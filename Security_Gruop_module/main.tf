resource "aws_security_group" "this" {#in the moudle file instead of a name i will call everything this # we take the descriptions and name as variables from the variables.tf
    name        = var.sg_name # "tal_sg" , we take it from the my_variables
    description = var.sg_description # "Tal Security Group"
    vpc_id      = data.aws_vpc.this.id    # can be hardcoded vpc-0b1f251cfb67cd0b6 or can be get from the data in the output file .id to get the id of the vpc

    tags = var.sg_tags
}

resource "aws_vpc_security_group_ingress_rule" "this" {
  security_group_id = aws_security_group.this.id # because in the module we changed the name to this instead of aws_security_group.tal_sg.id
  cidr_ipv4         =  var.ingress_ipv4_cider #we take it from the module #data.aws_subnet.jb_subnet["subnet-09f5a409b099e57cf"].cidr_block #can be hard coded "10.100.0.0/24"  or get it from the data file, but the data file print alot of stuff that we dont need and as a dictonary so we cant get th specific id that we want thats why we use the locals 
  from_port         = var.ingress_from_port
  ip_protocol       = var.ingress_ip_protocol
  to_port           = var.ingress_to_port
}

resource "aws_vpc_security_group_egress_rule" "this" {
  security_group_id = aws_security_group.this.id
  cidr_ipv4         = var.egress_ipv4_cider
  ip_protocol       = var.egress_ip_protocol
}