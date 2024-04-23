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

variable "runtime" {
  type        = string
  description = "Runtime environment for the Lambda function (e.g., python3.11 or python3.12)"
}

variable "handler" {
  type        = string
  description = "Lambda function handler. (i.e. a typical one would be lambda_function.lambda_handler)"
}

variable "architectures" {
  type = list(string)
  description = "Specified architecture to be used for the creation of the lambda function. (e.g. ARM or x86)"
}

variable "timeout" {
  type = number
  description = "Specifies the time in seconds, that the Lambda will last before timing out. Max 15 mins"
}

variable "memory_size" {
  type = number
  description = "Specifies the amount of memory in MB that the Lambda function will run on with 10240MB as the maximum"
}

variable "environment_variables" {
  type        = map(string)
  description = "Environment variables for the Lambda function"
  default     = {}
}