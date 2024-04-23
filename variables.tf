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