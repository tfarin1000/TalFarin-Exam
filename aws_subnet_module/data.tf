data "aws_vpc" "this" {  # getting the data from the vpc that already exists
    filter {
      name = "tag:Name" # filtering through the tag Name
      values = [var.vpc_name] # looking for the value in variables file
    }
}