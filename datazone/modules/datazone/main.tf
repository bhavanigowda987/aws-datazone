variable "s3_bucket_name" {}
variable "execution_role_arn" {}

data "aws_caller_identity" "current" {}

resource "aws_datazone_domain" "main" {
  name        = "healthcare-domain"
  description = "Healthcare DataZone domain"
  kms_key_identifier = "alias/aws/datazone"
}

resource "aws_datazone_environment_profile" "glue_profile" {
  name                        = "glue-env-profile"
  domain_identifier           = aws_datazone_domain.main.id
  aws_account_id              = data.aws_caller_identity.current.account_id
  aws_region                  = "us-east-1"
  environment_blueprint_identifier = "glue-dataview-blueprint"
}

resource "aws_datazone_environment" "glue_env" {
  name                              = "glue-env"
  description                       = "S3 + Glue Environment"
  domain_identifier                 = aws_datazone_domain.main.id
  environment_profile_identifier    = aws_datazone_environment_profile.glue_profile.id
  project_identifier                = aws_datazone_domain.main.id
  aws_account_id                    = data.aws_caller_identity.current.account_id
  aws_region                        = "us-east-1"

  provisioned_resources {
    name         = "s3-bucket"
    type         = "S3"
    resource_arn = "arn:aws:s3:::${var.s3_bucket_name}"
  }
}

output "domain_id" {
  value = aws_datazone_domain.main.id
}