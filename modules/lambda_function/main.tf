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

