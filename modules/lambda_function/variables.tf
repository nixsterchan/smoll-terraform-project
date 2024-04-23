variable "function_name" {
  type        = string
  description = "Name of the lambda function to be created."
}

variable "lambda_policy_document" {
  type = string
  description = "IAM policy document for the created lambda function."
}