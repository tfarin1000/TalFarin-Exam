resource "aws_security_group" "tal_sg" { # we take the descriptions and name as variables from the variables.tf
    name        = var.sg_name # "tal_sg"
    description = var.sg_description # "Tal Security Group"
    vpc_id      = data.aws_vpc.jb_vpc.id    # can be hardcoded vpc-0b1f251cfb67cd0b6 or can be get from the data in the output file .id to get the id of the vpc
    tags = var.sg_tags
}

# a way to work with parameters and create a tavnit
locals {
    subnet_cidr_blocks = [
        for subnet_id in data.aws.subnets.data.aws_subnets.jb_vpc_subnets.ids :  #loop with all the subnets i got from the data aws.subnets
        data.aws_subnet.jb.subnet[subnet_id].cidr_block  #get the cidr block in the each subnet id in each itiration of the for loop
    ]
    #select from the first id the CIDR block - i write this line in the resource itself
    # selected_cidr_block = local.subnet_cidr_blocks[0] 
    subnet_ids = [
        for subnet_id in data.aws.subnets.data.aws_subnets.jb_vpc_subnets.ids :  #loop with all the subnets i got from the data aws.subnets
        data.aws_subnet.jb.subnet[subnet_id].id  #get the id in each subnet id in each itiration of the for loop
    ]
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.tal_sg.id
  cidr_ipv4         =  local.subnet_cidr_blocks[0] #data.aws_subnet.jb_subnet["subnet-09f5a409b099e57cf"].cidr_block #can be hard coded "10.100.0.0/24"  or get it from the data file, but the data file print alot of stuff that we dont need and as a dictonary so we cant get th specific id that we want thats why we use the locals 
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tal_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# creating ec2!  first we need to get data (like ami - the image to create the ec2)
# even tought its optional we want to add security group and subnet because they are default, but we dont use default
resource "aws_instance" "tal_ec2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "tal-tf-keypair"
  vpc_security_group_ids = [aws_security_group.tal_sg.id]  #this is an array because its ids and not id and i use the sg i already created at the beginning of the file
  subnet_id = local.subnet_ids # i use the subnet i got from the local
  root_block_device { # another set of options - a dictonary
    volume_size = 50 # give the size of the disk
    volume_type = "gp3" #give he type of the disk
  }  # run terraform fmt to format all the text nice
  tags = {
    Name = "Tal-ec2"
  }
}

# creating a role that allow others to assume it
resource "aws_iam_role" "tal_ec2_role" {
  name = "tal_ec2_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# attaching the policy to the role
resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role       = aws_iam_role.tal_ec2_role.name
}

# Attach the Role to an Instance Profile
resource "aws_iam_instance_profile" "tal_ec2_role_instance_profile" {
  name = "tal_ec2_role_instance_profile"
  role = aws_iam_role.tal_ec2_role.name
}




#creating machine
resource "aws_instance" "tal_ec2-number2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  key_name = "tal-tf-keypair"
  vpc_security_group_ids = [aws_security_group.tal_sg.id]
  subnet_id = local.subnet_ids

  root_block_device { 
    volume_size = 50 
    volume_type = "gp3"
  }  
  tags = {
    Name = "Tal-ec2"
  }
}


resource "aws_instance" "tal_ec2_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "c7i-flex.large"
  key_name = "tal-tf-keypair"
  vpc_security_group_ids = [aws_security_group.tal_sg.id]  #this is an array because its ids and not id and i use the sg i already created at the beginning of the file
  iam_instance_profile = aws_iam_instance_profile.tal_ec2_role_instance_profile.name
  subnet_id = local.subnet_ids # i use the subnet i got from the local
  root_block_device { # another set of options - a dictonary
    volume_size = 50 # give the size of the disk
    volume_type = "gp3" #give he type of the disk
  }  # run terraform fmt to format all the text nice
  tags = {
    Name = "Tal-ec2-2"
  }
}