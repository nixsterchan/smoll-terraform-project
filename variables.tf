variable "image_resize_lambda_name" {
  type = string
  description = "Name of the lambda function to be used for the image resizing."
}

variable "lambda_scripts_folder_name" {
  type = string
  description = "The folder path name where lambda functions exist in."
}

variable "region_name" {
  type = string
  description = "Specifies the AWS region where these resources will be spun up in."
}

variable "ingestion_images_bucket_name" {
  type = string
  description = "Name of the bucket used for ingestion of images (and triggers the lambda to perform processing). In this case, this is our bnha-images bucket."
}

variable "resized_images_bucket_name" {
  type = string
  description = "Name of the bucket that contains the output resized image from the image resizing lambda. In this case, this is our resized-bnha-images bucket."
}