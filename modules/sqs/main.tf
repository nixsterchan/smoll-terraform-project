# Create main SQS queue
resource "aws_sqs_queue" "queue" {
  name = var.queue_name
  max_message_size = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds = var.delay_seconds
  policy = var.sqs_policy_document
}