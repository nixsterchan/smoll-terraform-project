output "lambda_function_arn" {
  value = aws_lambda_function.lambda_function.arn
  description = "For other modules to reference this created lambda function's arn."
}