# For retrieving a zipped lambda function module
data "archive_file" "lambda_function_zip" {
  type        = "zip"
  source_dir  = var.lambda_function_code_path
  output_path = "${path.module}/${var.function_name}_lambda_function.zip"
}

# Creates the base IAM role for the given lambda function name
resource "aws_iam_role" "lambda_role" {
  name               = "${var.function_name}_lambda_role"
  description        = "IAM role creation for the ${var.function_name} lambda function." 
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# For the addition of policies to the lambda IAM role
resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.function_name}-policy"
  description = "IAM policy for the ${var.function_name} lambda function"
  policy      = var.lambda_policy_document
}

# Does the attachment of a specified policy to a specific lambda IAM role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.lambda_policy.arn
}

# Creation of the lambda function and specifies the configs required
resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.lambda_function_zip.output_path
  source_code_hash = filebase64sha256(data.archive_file.lambda_function_zip.output_path)
  role             = aws_iam_role.lambda_role.arn
  function_name    = var.function_name
  runtime          = var.runtime
  handler          = var.handler
  architectures    = var.architectures
  memory_size      = var.memory_size
  timeout          = var.timeout
  environment {
    variables = var.environment_variables
  }
}

# Creates a log group for this lambda to write out its logs to for use with CloudWatch Insights if necessary for debugging purposes
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name = "/aws/lambda/${aws_lambda_function.lambda_function.function_name}"
}