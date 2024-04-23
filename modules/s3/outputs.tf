output "s3_bucket_arn" {
  description = "Returns the arn of the created S3 bucket."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_id" {
  description = "Returns the id of the created S3 bucket."
  value       = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_name" {
  description = "Returns the bucket name of the created S3 bucket."
  value = aws_s3_bucket.s3_bucket.bucket
}