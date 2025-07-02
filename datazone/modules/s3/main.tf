resource "aws_s3_bucket" "datazone_data" {
  bucket        = "datazone-lake-${random_id.suffix.hex}"
  force_destroy = true
}

resource "random_id" "suffix" {
  byte_length = 4
}

output "bucket_name" {
  value = aws_s3_bucket.datazone_data.id
}