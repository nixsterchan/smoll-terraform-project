# Welcome to a smoll little Terraform project
The following mini project is one that I decided to start just to test out some of the basics I learnt from Terraform thus far. There are definitely lots of templates out there but I just wanted to try building a simple project based on stuff I learnt from a recent course I took! 

Be warned that this project is made by an absolute beginner and might invoke unpleasant symptoms such as the vomiting of bl**d. Viewer discretion is advised.




# Image Resize Pipeline with AWS and Terraform

## Overview
This project aims to set up a simple serverless image resizing pipeline using AWS services and Terraform. The pipelines involves the uploading of images to an ingestion S3 bucket, which in turn writes S3 PUT event notifications to an SQS queue. Said SQS will have an event mapping set up with the lambda used for processing, wherein this lambda will poll from the SQS queue for messages to get information on the S3 object to process on and write to an output bucket. Essentially, SQS will serve as a means to trigger the lambda function and also helps with decoupling the rate of S3 PUT events firing off lambdas.

Note that lambda can directly be triggered by S3, and that lambda itself has a means to throttle should the number of messages being triggered exceeed the limit (1000 concurrent lambdas for the region I am using). However, I do like this method of having an SQS queue to act as a buffer, especially in a pipeline where there are many other lambda functions working concurrently. This gives me an easy means to control the concurrencies of each core lambda feature, and with the usage of DLQs, an easy way to refire all failed messages at one go. There are most definitely other methods out there, this is perhaps just one of them!
