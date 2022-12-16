resource "aws_lambda_function" "HelloWorldLambda" {
  filename         = "${data.archive_file.zip.output_path}"
  function_name    = "HelloWorldLambda"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "py.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
}

  resource "aws_lambda_permission" "apigw-invoke" {
  depends_on = [
    "aws_lambda_function.HelloWorldLambda",
    "aws_api_gateway_rest_api.myAPI",
    "aws_api_gateway_method.my_method"
  ]
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.HelloWorldLambda.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.myAPI.execution_arn}/*/*"
}

resource "aws_lambda_permission" "SeoWebsiteApiGateway" {
  depends_on = [
    "aws_lambda_function.HelloWorldLambda",
    "aws_api_gateway_rest_api.myAPI",
    "aws_api_gateway_method.my_method"
  ]
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.HelloWorldLambda.function_name}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.myAPI.execution_arn}/*/*"
}