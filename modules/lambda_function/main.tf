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