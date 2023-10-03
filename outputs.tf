output "bucket_name" {
    description = "Bucket name for our static website"
    value = module.terrahouse_aws.bucket_name
}

output "website endpoint" {
    description = "S3 Static Website Hosting Endpoint"
  value = aws_s3_bucket_website_configuration.website_configuration.website_endpoint
}