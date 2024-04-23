variable "queue_name" {
  type = string
  description = "The name of the created SQS queue."
}

variable "max_message_size" {
  type = number
  description = "The limit of how many bytes a message can contain before Amazon SQS rejects it. Max is 256KB."
}

variable "message_retention_seconds" {
  type = number
  description = "The retention period of messages placed in this SQS queue. Max is 14 days."
}

variable "visibility_timeout_seconds" {
  type = number
  description = "The visibility timeout for messages in the queue that were consumed, where other consumers of the queue will not be able to see this until this period is over."
}

variable "delay_seconds" {
  type = number
  description = "The time in seconds that the delivery of all messages in the queue will be delayed."
}

variable "sqs_policy_document" {
  type = string
  description = "IAM policy document for the SQS queue"
}

variable "create_dlq" {
  type = bool
  description = "Used to determine if a DLQ should be created and attached to the SQS queue being created."
  default = false
}

variable "dead_letter_queue_name" {
  type = string
  description = "Name of the dead letter queue."
  default = ""
}

variable "max_receive_count" {
  type = number
  description = "The number of retry attempts that the consumer will have to process the message. Once limit is hit, message is sent to the DLQ."
}