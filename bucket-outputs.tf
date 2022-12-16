output "s3_bucket_id" {
    description = "The name of the bucket"
    value = aws_s3_bucket.b.id
}

output "s3_bucket_region" {
    description = "The AWS region this bucket resides in."
    value = aws_s3_bucket.b.region
}



