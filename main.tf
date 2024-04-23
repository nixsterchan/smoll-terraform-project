# Create the ingestion images and resized images buckets 
module "ingestion_images_bucket" {
  source = "./modules/s3"
  bucket_name = var.ingestion_images_bucket_name
}

module "resized_images_bucket" {
  source = "./modules/s3"
  bucket_name = var.resized_images_bucket_name
}

# Create the SQS queue alongside a DLQ
module "queue_for_resize_my_image_lambda" {
  source = "./modules/sqs"
  queue_name = var.img_res_lambda_sqs_name
  max_message_size = 1024
  message_retention_seconds = 600
  visibility_timeout_seconds = 60
  delay_seconds = 2
  max_receive_count = 2
  sqs_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Id": "SQSPolicy",
  "Statement": [
    {
      "Sid": "AllowReceiveMessageFromS3Bucket",
      "Effect": "Allow",
      "Principal": {
        "AWS": "*"
      },
      "Action": "sqs:SendMessage",
      "Resource": "arn:aws:sqs:${var.region_name}:*:${var.img_res_lambda_sqs_name}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${module.ingestion_images_bucket.s3_bucket_arn}"
        }
      }
    }
  ]
}
EOF
  create_dlq = true
  dead_letter_queue_name = var.img_res_lambda_dlq_name
}

# Setup S3 PUT event notifications to be sent to the created SQS queue
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = module.ingestion_images_bucket.s3_bucket_id

  queue {
    queue_arn = module.queue_for_resize_my_image_lambda.queue_arn
    events = ["s3:ObjectCreated:*"]
    filter_prefix = ""
    filter_suffix = ""
  }
}

# Create the resize-my-images lambda function
module "resize_my_image_lambda" {
  source = "./modules/lambda_function"

  function_name = var.image_resize_lambda_name
  lambda_function_code_path = "${var.lambda_scripts_folder_name}/${var.image_resize_lambda_name}"
  runtime = "python3.11"
  handler = "lambda_function.lambda_handler"
  architectures = ["x86_64"]
  timeout = 180
  memory_size = 2048
  lambda_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowLogEvents",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Sid": "AllowGetObject",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${module.ingestion_images_bucket.s3_bucket_arn}",
        "${module.ingestion_images_bucket.s3_bucket_arn}/*"
      ]
    },
    {
      "Sid": "AllowPutObject",
      "Effect": "Allow",
      "Action": "s3:PutObject",
      "Resource": [
        "${module.resized_images_bucket.s3_bucket_arn}",
        "${module.resized_images_bucket.s3_bucket_arn}/*"
      ]
    }
  ]
}
EOF
  environment_variables = {
    "IMAGE_RESIZE_FACTOR" = "0.6"
    "DESTINATION_BUCKET_NAME" = "${module.resized_images_bucket.s3_bucket_name}"
  }
}