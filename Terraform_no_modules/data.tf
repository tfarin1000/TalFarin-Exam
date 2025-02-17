data "aws_vpc" "jb_vpc" {  # getting the data from the vpc that already exists
    filter {
      name = "tag:Name" # filtering through the tag Name
      values = ["jb-aws-vpc-vpc"] # looking for the value in the tag Name
    }
}

data "aws_subnets" "jb_vpc_subnets" {
    filter {
    name   = "vpc-id" #filter by the vpc id
    values = [data.aws_vpc.jb_vpc.id] 
    }
    filter {
        name = "tag:Name" #filter by the Name tag that have jb-vpc-private*
        values = ["jb-vpc-private*"] 
    }
}

data "aws_subnet" "jb_subnet" {
    for_each = toset(data.aws_subnets.jb_vpc_subnets.ids) # create a dictionary with all the subnets propeies and from there you can get the IDs and such
    id = each.value
}

#getting iam policy from my account
data "aws_iam_policy" "AmazonSSMMAnagedInstanceCore" {
  arn = "arn:aws:iam::123456789012:policy/AmazonSSMMAnagedInstanceCore"
}
