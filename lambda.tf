resource "aws_lambda_function" "LambdaHW" {
  filename         = "${data.archive_file.zip.output_path}"
  function_name    = "LambaHelloWorldFunc"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "script.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
}

  resource "aws_lambda_permission" "apigw-invoke" {
  depends_on = [
    "aws_lambda_function.LambdaHW",
    "aws_api_gateway_rest_api.miAPI",
    "aws_api_gateway_method.mi_metodo"
  ]
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.LambdaHW.function_name}"
  principal     = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.miAPI.execution_arn}/*/*"
}

resource "aws_lambda_permission" "SeoWebsiteApiGateway" {
  depends_on = [
    "aws_lambda_function.LambdaHW",
    "aws_api_gateway_rest_api.miAPI",
    "aws_api_gateway_method.mi_metodo"
  ]
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.LambdaHW.function_name}"
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_api_gateway_rest_api.miAPI.execution_arn}/*/*"
}

output "lambda" {
  value = "${aws_lambda_function.LambdaHW.qualified_arn}"
}