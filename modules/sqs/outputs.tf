output "queue_arn" {
  description = "Returns the ARN of the main SQS queue for any other module to reference."
  value       = aws_sqs_queue.main_queue.arn
}

output "dead_letter_queue_arn" {
  description = "Returns the ARN of the DLQ for any other module to reference."
  value       = var.create_dlq ? aws_sqs_queue.dead_letter_queue[0].arn : null
}