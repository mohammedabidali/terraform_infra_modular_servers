provider "aws" {
    region = var.var_region
}

module "vpc" {
  source = "./modules/vpc"
}

module "web_subnet" {
  source = "./modules/web_subnet"

  var_aws_vpc_id = module.vpc.output_aws_vpc_id

  var_internet_route_table = module.vpc.output_internet_route_table
}

module "webserver" {
  source = "./modules/webserver"

  var_web_subnet_id = module.web_subnet.output_web_subnet_id
  var_ssh_key_name = var.var_ssh_key_name
  var_dns_zone_id = module.vpc.output_dns_zone_id
  var_aws_vpc_id = module.vpc.output_aws_vpc_id
}

terraform {
  backend "s3" {
    bucket = "cyber94-mali-bucket"
    key = "tfstate/calculator2/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "cyber94_calculator2_mohammed_dynamodb_table_lock"
    encrypt = true
  }
}

module "s3_bucket" {
  source = "./modules/terraform-backend"

  bucket = "cyber94-mali-bucket"
  acl = "private"
}
