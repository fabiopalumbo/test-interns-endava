# resource "aws_lambda_function" "HelloWorldLambda" {
#     function_name = "mnl-endava-lambda"
#     s3_bucket = aws_s3_bucket.b.id
#     s3_key = aws_s3_bucket_object.file_upload.id
#     handler = "py.handler"
#     runtime = "python3.8"
#     # source_path = "${path.module}/py.zip"
#     # source_path = "./py.py"
#     role = aws_iam_role.lambda_role.arn
# }

# Set up the Lambda function
resource "aws_lambda_function" "HelloWorldLambda" {
  filename         = "py.zip"
  function_name    = "HelloWorldLambda"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "py.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = "${base64sha256(file("py.zip"))}"
}
