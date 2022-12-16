resource "aws_lambda_function" "HelloWorldLambda" {
  filename         = "${data.archive_file.zip.output_path}"
  function_name    = "HelloWorldLambda"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "py.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
}

# resource "aws_lambda_permission" "apigw" {
#   action = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.HelloWorldLambda.arn
#   principal = "apigateway.amazonaws.com"
#   source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
# }