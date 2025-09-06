provider "aws" {
  region = "us-east-1" # Singapore region
}

resource "aws_s3_bucket" "shilpakks3_site" {
  bucket = "shilpakks3.sctp-sandbox.com"
  #acl    = "public-read"
  force_destroy = true #from c9 -s3 hosting
  tags = {
    Name        = "ShilpakkS3Site"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_website_configuration" "site_config" {
  bucket = aws_s3_bucket.shilpakks3_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Ownership control

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.shilpakks3_site.id

  rule {
    object_ownership = "BucketOwnerEnforced" #"BucketOwnerPreferred"
  }
}

# Public access block
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket                  = aws_s3_bucket.shilpakks3_site.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "shilpakks3_policy" {
  bucket = aws_s3_bucket.shilpakks3_site.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.shilpakks3_site.arn}/*"
      }
    ]
  })
}
# Upload Website files
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.shilpakks3_site.id
  key          = "index.html"
  source       = "site/index.html"
  #acl          = "public-read"
  content_type = "text/html"
}

resource "aws_s3_object" "error" {
  bucket       = aws_s3_bucket.shilpakks3_site.id
  key          = "error.html"
  source       = "site/error/index.html" #"site/error.html"
  #acl          = "public-read"
  content_type = "text/html"
}

# Route 53 DNS record

data "aws_route53_zone" "sandbox" {
  name         = "sctp-sandbox.com"
  private_zone = false
}

resource "aws_route53_record" "shilpakks3" {
  zone_id = data.aws_route53_zone.sandbox.zone_id
  name    = "shilpakks3.sctp-sandbox.com"
  type    = "A"

  alias {
    name                   = aws_s3_bucket_website_configuration.site_config.website_domain
    zone_id                = aws_s3_bucket.shilpakks3_site.hosted_zone_id
    evaluate_target_health = false #false as per c9
  }
}

