output "s3_bucket_id" {
    description = "The name of the bucket"
    value = var.s3_bucket
}

output "s3_bucket_region" {
    description = "The AWS region this bucket resides in."
    value = var.s3_region
}

output "base_url" {
  value = aws_api_gateway_deployment.apideploy.invoke_url
}
