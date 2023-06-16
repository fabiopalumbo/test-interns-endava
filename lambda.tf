//LAMBDA
resource "aws_lambda_function" "lambda_demo" {
  filename = "${path.module}/python/hello-python.zip"

  //s3_bucket = aws_s3_bucket.bukdemodai.id 
  //s3_key = aws_s3_object.textoprueba.key
  function_name = "lambda_demo"
  role          = aws_iam_role.lambda_role.arn
  handler       = "hello-python.lambda_handler" //?
  runtime       = "python3.8"
  //source_code_hash = filebase64sha256("lambda_demo-lambda.zip") # Hash of your Lambda function code
  depends_on = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role]
}

