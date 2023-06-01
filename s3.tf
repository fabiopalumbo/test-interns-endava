#BUCKET S3
resource "aws_s3_bucket" "bukDemoDai" {
  bucket = "s3-terraform-bucket-lab_dai"

  tags = {
    Name        = "bucket_demo"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_acl" "bucketDemoACL" {
  bucket = aws_s3_bucket.bukDemoDai.id
  acl    = "private"
}

resource "aws_s3_bucket_object" "TextoPrueba" {
  bucket  = aws_s3_bucket.bukDemoDai.id
  key     = "text.txt"
  content = "Hello World."

}