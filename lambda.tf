resource "aws_lambda_function" "HelloWorldLambda" {
    function_name = "mnl-endava-lambda"

    s3_bucket = aws_s3_bucket.b.id
    
    s3_key = aws_s3_bucket_object.file_upload.id

    handler = "py.handler"

    runtime = "python3.8"

    source_path = "${path.module}/py.py"

    role = aws_iam_role.lambda_role.arn

}

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.HelloWorldLambda.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*"
}