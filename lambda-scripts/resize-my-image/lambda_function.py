"""
RESIZE-MY-IMAGE
This function serves to help the user resize images.

Triggered By:
    - S3 PUT Event

Dependencies:
    - TBC
"""
import boto3
import os

s3 = boto3.resource('s3')

# Retrieve environment variables
IMAGE_RESIZE_FACTOR = float(os.environ['IMAGE_RESIZE_FACTOR'])
DESTINATION_BUCKET_NAME = os.environ['DESTINATION_BUCKET_NAME'] 

def lambda_handler(event, context):
   # Read object from S3

   # Resize image

   # Write to S3 endpoint
   return 'success'