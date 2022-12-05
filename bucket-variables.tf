variable "s3_bucket" {
  description = "The name of the bucket"
  type        = string
  default     = "aws_s3_bucket.b.id"
}

variable "s3_content" {
  description  = "value"
  type         = string
  default      = "aws_s3_bucket_object.file_upload.id"
}

variable "s3_region" {
  description  = "The AWS region this bucket resides in"
  type         = string
  default      = "aws_s3_bucket.b.region"
}
