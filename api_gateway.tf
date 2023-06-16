//API GATEWAY
resource "aws_api_gateway_rest_api" "api_demo" {
  name        = "api_demo"
  description = "API Gateway for accessing texto.txt"
}

// ==============================
resource "aws_api_gateway_authorizer" "demo_autorizacion" {
  name                   = "demo_autorizacion"
  rest_api_id            = aws_api_gateway_rest_api.api_demo.id
  authorizer_uri         = aws_lambda_function.lambda_demo.invoke_arn
  authorizer_credentials = aws_iam_role.lambda_role.arn
}
// ==============================

//Create a resource and method in the API Gateway 
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = aws_api_gateway_rest_api.api_demo.id
  parent_id   = aws_api_gateway_rest_api.api_demo.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy_method" {
  rest_api_id   = aws_api_gateway_rest_api.api_demo.id
  resource_id   = aws_api_gateway_resource.proxy.id
  http_method   = "GET"
  authorization = "NONE"
}

//Add an integration to the method
resource "aws_api_gateway_integration" "lambda_proxy" {
  rest_api_id             = aws_api_gateway_rest_api.api_demo.id
  resource_id             = aws_api_gateway_resource.proxy.id
  http_method             = aws_api_gateway_method.proxy_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.lambda_demo.invoke_arn
}

//permisos sobre la lambda para que pueda ser llamada desde el API gateway
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_demo.function_name
  principal     = "events.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${"us-east-1"}:${"258076216385"}:${aws_api_gateway_rest_api.api_demo.id}/*/${aws_api_gateway_method.proxy_method.http_method}${aws_api_gateway_resource.proxy.path}"
  //"arn:aws:events:eu-west-1:111122223333:rule/RunDaily"
  //qualifier     = aws_lambda_alias.test_alias.name

}

resource "aws_api_gateway_deployment" "api_dev" { 
  rest_api_id = aws_api_gateway_rest_api.api_demo.id

  
   depends_on = [aws_api_gateway_method.proxy_method, aws_api_gateway_integration.lambda_proxy]

  stage_name = "test"
}

//https://registry.terraform.io/providers/hashicorp/aws/2.34.0/docs/guides/serverless-with-aws-lambda-and-api-gateway
