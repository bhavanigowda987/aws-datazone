provider "aws" {
  region = "us-east-1"
}

module "s3" {
  source = "./modules/s3"
}

module "iam" {
  source = "./modules/iam"
}

module "datazone" {
  source             = "./modules/datazone"
  s3_bucket_name     = module.s3.bucket_name
  execution_role_arn = module.iam.execution_role_arn
}

module "lakeformation" {
  source             = "./modules/lakeformation"
  bucket_name        = module.s3.bucket_name
  execution_role_arn = module.iam.execution_role_arn
}