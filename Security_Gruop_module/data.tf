data "aws_vpc" "this" {  # getting the data from the vpc that already exists
    filter {
      name = "tag:Name" # filtering through the tag Name
      values = [var.vpc_name] # jb-aws-vpc-vpc # looking for the value in the tag Name of the vpc name that we take from variables.tf
    }
}


