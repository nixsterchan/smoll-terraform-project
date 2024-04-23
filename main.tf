# Create the ingestion images and resized images buckets 
module "ingestion_images_bucket" {
  source = "./modules/s3"
  bucket_name = var.ingestion_images_bucket_name
}

module "resized_images_bucket" {
  source = "./modules/s3"
  bucket_name = var.resized_images_bucket_name
}
