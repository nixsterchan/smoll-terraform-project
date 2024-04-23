"""
RESIZE-MY-IMAGE
This function serves to help the user resize images.

Triggered By:
    - S3 PUT Event

Dependencies:
    - TBC
"""
import boto3

s3 = boto3.resource('s3')

def lambda_handler(event, context):
   # Read object from S3

   # Resize image

   # Write to S3 endpoint
   return 'success'