# Create your S3 bucket with the specified name
resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
}