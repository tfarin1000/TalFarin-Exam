# מאפשר להעביר נתונים בין קבצים

output "subnet_cidr_blocks" {
    value = [for s in data.aws_subnet.jb_subnet : s.cidr_block]
}

output "vpc_data" {
  value = data.aws_vpc.jb_vpc#.arn - # print all the vpc data or the specific data (like arn)
}


output "vpc_subnets_data" {
  value = data.aws_subnet.jb_subnet_list 
}