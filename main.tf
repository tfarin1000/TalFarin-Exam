# this is the main tf only to call modules - for the old main tf go to terraform_mo_module folder

# here i use the real variables i want to pass (i can see what i want from the variables.tf in my module)

module "subnet" {
  source = "./aws_subnet_module"
  cidr_block = "10.0.201.0/24"
  route_cidr_block = "10.0.0.0/24"
}

module "sg" {
  source = "./Security_Gruop_module" # need to specify where the module file is
  # here i give all the module variables i want to pass (from variables.tf in the module)
  sg_name = "tal-sg"  # this is my own variables - if i give the module and a new main file, the other person just need to change here and not inside the module
  ingress_ipv4_cider = module.subnet.subnet_cidr_block #"10.100.0.0/24" # i dont need to write here anything if i use the subnet first, i need to create in the data a call for the cider from the module
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  for_each = toset(["one", "two", "three"])

  name = "instance-${each.key}"

  instance_type          = "t2.micro"
  key_name               = "tal-tf-keypair"
  monitoring             = true
  vpc_security_group_ids = [module.sg.sg_information] # get the id from the previous module
  subnet_id              = module.subnet.subnet_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# git pull origin main --allow-unrelated-histories

# this is a little change for git hub

# git branch - get all the branches