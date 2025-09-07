variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "shilpakks3.sctp-sandbox.com"
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Deployment environment tag"
  type        = string
  default     = "Dev"
}

variable "domain_name" {
  description = "Fully qualified domain name for the static site"
  type        = string
  default     = "shilpakks3.sctp-sandbox.com"
}

variable "zone_name" {
  description = "Route 53 hosted zone name"
  type        = string
  default     = "sctp-sandbox.com"
}