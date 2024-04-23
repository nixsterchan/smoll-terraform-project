variable "function_name" {
  type        = string
  description = "Name of the lambda function to be created."
}

variable "lambda_policy_document" {
  type = string
  description = "IAM policy document for the created lambda function."
}

variable "lambda_function_code_path" {
  type        = string
  description = "Local path to the created lambda function's code directory"
}