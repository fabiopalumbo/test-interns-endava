resource "aws_api_gateway_rest_api" "ApiGW" {
   name        = "${var.name}-APIGW"
   description = "${var.name} Endpoint"
   tags = local.common_tags
}

resource "aws_api_gateway_resource" "proxy" {
  path_part    = "text"
  parent_id    = aws_api_gateway_rest_api.ApiGW.root_resource_id
  rest_api_id  = aws_api_gateway_rest_api.ApiGW.id
}

resource "aws_api_gateway_method" "proxyMethod" {
   rest_api_id = aws_api_gateway_rest_api.ApiGW.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = "GET"
   authorization = "NONE"
   api_key_required = true
}

resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.ApiGW.id
   resource_id = aws_api_gateway_resource.proxy.id
   http_method = aws_api_gateway_method.proxyMethod.http_method
   integration_http_method = "POST"
   type = "AWS_PROXY"
   uri = aws_lambda_function.HelloWorldLambda.invoke_arn
}

resource "aws_api_gateway_integration_response" "lambdaReponse" {
  rest_api_id = aws_api_gateway_rest_api.ApiGW.id
  resource_id = aws_api_gateway_resource.proxy.id
  http_method = aws_api_gateway_method.proxyMethod.http_method
  status_code = aws_api_gateway_method_response.lambdaReponse.status_code
  depends_on = [ aws_api_gateway_integration.lambda ]
}

resource "aws_api_gateway_deployment" "apiDeploy" {
  rest_api_id = aws_api_gateway_rest_api.ApiGW.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
   aws_api_gateway_method.proxyMethod,
   aws_api_gateway_integration.lambda]

}

resource "aws_api_gateway_stage" "apistage" {
   stage_name = "stream"
   rest_api_id = aws_api_gateway_rest_api.ApiGW.id
   deployment_id = aws_api_gateway_deployment.apiDeploy.id

   lifecycle {
     create_before_destroy = false
   }
}

resource "aws_api_gateway_usage_plan" "apiplan" {
  name = "${local.name}-stream"

  api_stages {
    api_id = aws_api_gateway_rest_api.ApiGW.id
    stage = aws_api_gateway_stage.apistage
  } 
}

resource "aws_api_gateway_api_key" "apikey" {
  name = "${local.name}-stream"
}

resource "aws_api_gateway_usage_plan_key" "apikeyplan" {
   key_id = aws_api_gateway_api_key.apikey.id
   key_key_type = "API_KEY"
   usage_plan_id = aws_api_gateway_usage_plan.apiplan.id   
}