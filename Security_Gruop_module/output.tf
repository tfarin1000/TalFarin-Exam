# just print what i want

output "sg_information" { # to make sure all the vars are correct we will just print the 
    value = aws_security_group.this.id  # i added id for the id, if not it will print everything
}
