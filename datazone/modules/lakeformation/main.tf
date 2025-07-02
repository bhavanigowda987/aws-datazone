variable "bucket_name" {}
variable "execution_role_arn" {}

resource "aws_lakeformation_resource" "s3" {
  arn         = "arn:aws:s3:::${var.bucket_name}"
  role_arn    = var.execution_role_arn
  use_service_linked_role = true
}

resource "aws_lakeformation_permissions" "grant" {
  principal                       = var.execution_role_arn
  permissions                     = ["ALL"]
  permissions_with_grant_option  = ["ALL"]
  data_location {
    arn = aws_lakeformation_resource.s3.arn
  }
}