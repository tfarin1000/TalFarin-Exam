# מאפשר להעביר נתונים בין קבצים

output "vpc_data" {
  value = data.aws_vpc.this.id#.arn - # print all the vpc data or the specific data (like arn)
}

output "subnet_id" {
  value =  aws_subnet.this.id
}

output "subnet_cidr_block" {
  value = aws_subnet.this.cidr_block
}