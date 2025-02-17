# when i run terraform plan i need to specify the file name
# terraform plan -var-file .\my_vars.tfvars

sg_tags = {
    name = "Tal-SG"
    managed-By = "Terraform"
}