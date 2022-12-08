resource "aws_s3_bucket" "b" {
  bucket    = "${local.name}-bucket"
  acl       = "private"
  force_destroy = true
  versioning {
    enabled = false
  }

  tags = local.common_tags

}

resource "aws_s3_bucket_object" "file_upload" {
    bucket  = aws_s3_bucket.b.id
    source  = "${path.module}/text.txt"
    key     = "text.txt"
}



# resource "aws_s3_access_point" "example" {
#   bucket = aws_s3_bucket.example.id
#   name   = "example"
# }

# resource "aws_s3control_object_lambda_access_point" "example" {
#   name = "example"

#   configuration {
#     supporting_access_point = aws_s3_access_point.example.arn

#     transformation_configuration {
#       actions = ["GetObject"]

#       content_transformation {
#         aws_lambda {
#           function_arn = aws_lambda_function.example.arn
#         }
#       }
#     }
#   }
# }