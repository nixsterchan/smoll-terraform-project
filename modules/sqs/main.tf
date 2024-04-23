# Create main SQS queue
resource "aws_sqs_queue" "queue" {
  name = var.queue_name
  max_message_size = var.max_message_size
  message_retention_seconds = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  delay_seconds = var.delay_seconds
  policy = var.sqs_policy_document
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dead_letter_queue[0].arn
    maxReceiveCount     = var.max_receive_count
  })
}

# Create a dead letter queue to link to the main queue if it is enabled for creation
resource "aws_sqs_queue" "dead_letter_queue" {
  count = var.create_dlq ? 1 : 0
  name  = var.dead_letter_queue_name
}

# Defines the policy for allowing the main queue to send messages to the dead letter queue and for the use of DLQ redrive to return messages to the main queue
resource "aws_sqs_queue_redrive_allow_policy" "main_queue_policy" {
  count = var.create_dlq ? 1 : 0
  queue_url = aws_sqs_queue.main_queue[0].id
  
  redrive_allow_policy = jsondecode({
    redrivePermission = "byQueue"
    sourceQueueArns = [aws_sqs_queue.main_queue.arn]
  })
}