# output "website_url" {
#   value = aws_s3_bucket_website_configuration.site_config.website_endpoint
# }

output "bucket_name" {
  value = aws_s3_bucket.shilpakks3_site.id
}

output "website_endpoint" {
  value = aws_s3_bucket_website_configuration.site_config.website_endpoint
}

output "route53_record" {
  value = aws_route53_record.shilpakks3.name
}