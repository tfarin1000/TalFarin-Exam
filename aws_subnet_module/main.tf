resource "aws_subnet" "this" {
  vpc_id     = data.aws_vpc.this.id
  cidr_block = var.cidr_block
}

# creating route table https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table - Adopting an existing local route
resource "aws_route_table" "this" {
  vpc_id = data.aws_vpc.this.id

  # since this is exactly the route AWS will create, the route will be adopted
  route {
    cidr_block = var.route_cidr_block #the route table cidr block is the first 2 cidr block ip, if my subnet is 10.0.201.0/24 so my route table is 10.0.0.0/24
    gateway_id = var.route_gateway_id # = "local" , takes it from the var files no need in main main
  }
}