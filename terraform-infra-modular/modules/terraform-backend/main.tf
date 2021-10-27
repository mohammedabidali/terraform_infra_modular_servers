terraform {
  backend "s3" {
    bucket = "cyber94-mali-bucket"
    key = "tfstate/calculator2/terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "cyber94_calculator2_mohammed_dynamodb_table_lock"
    encrypt = true
  }
}
