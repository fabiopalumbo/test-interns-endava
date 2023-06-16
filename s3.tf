#BUCKET S3
resource "aws_s3_bucket" "bukdemodai" {
  bucket = "s3-terraform-bucket-labdai"

  tags = {
    Name        = "bucket_demo"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownercontroldemo" {
  bucket = aws_s3_bucket.bukdemodai.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "bucketdemoacl" {
  depends_on = [aws_s3_bucket_ownership_controls.ownercontroldemo]
  bucket     = aws_s3_bucket.bukdemodai.id
  acl        = "private"
}

resource "aws_s3_bucket_object" "textoprueba" {
  bucket = aws_s3_bucket.bukdemodai.id
  key    = "hello-python.zip"
  source = data.archive_file.zip_the_python_code.output_path
  etag   = filemd5(data.archive_file.zip_the_python_code.output_path)

}