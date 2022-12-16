resource "aws_api_gateway_rest_api" "myAPI" {
    name = "${local.name}-api-gw"
}

resource "aws_api_gateway_resource" "my_resource" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    parent_id = aws_api_gateway_rest_api.myAPI.root_resource_id
    path_part = "my_resource"
}

resource "aws_api_gateway_method" "my_method" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    resource_id = aws_api_gateway_resource.my_resource.id
    http_method = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "my_integration" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    resource_id = aws_api_gateway_resource.my_resource.id
    http_method = aws_api_gateway_method.my_method.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.HelloWorldLambda.invoke_arn
}

resource "aws_api_gateway_method_response" "my_method_response" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    resource_id = aws_api_gateway_resource.my_resource.id
    http_method = aws_api_gateway_method.my_method.http_method
    status_code = "200"
}

resource "aws_api_gateway_integration_response" "my_integration_response" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    resource_id = aws_api_gateway_resource.my_resource.id
    http_method = aws_api_gateway_method.my_method.http_method
    status_code = aws_api_gateway_method_response.my_method_response.status_code
    depends_on = [ aws_api_gateway_integration.my_integration ]
}

resource "aws_api_gateway_deployment" "my_deployment" {
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    lifecycle {
      create_before_destroy = true
    }
    depends_on = [aws_api_gateway_method.my_method, aws_api_gateway_integration.my_integration]
}

resource "aws_api_gateway_stage" "my_stage" {
    stage_name = "production"
    rest_api_id = aws_api_gateway_rest_api.myAPI.id
    deployment_id = aws_api_gateway_deployment.my_deployment.id

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_api_gateway_usage_plan" "my_usageplan" {
    name = "my-usage-plan"
    description = "description"
    product_code = "MYCODE"

    api_stages {
      api_id = aws_api_gateway_rest_api.myAPI.id
      stage = aws_api_gateway_stage.my_stage.stage_name
    }
}

resource "aws_api_gateway_api_key" "my_api" {
    name = "my-stream"
}

resource "aws_api_gateway_usage_plan_key" "my_plan_key" {
    key_id = aws_api_gateway_api_key.my_api.id
    key_type = "API_KEY"
    usage_plan_id = aws_api_gateway_usage_plan.my_usageplan.id
}

# resource "aws_apigatewayv2_api" "api_gateway" {
#     name = "example_api"
#     protocol_type = "HTTP"
#     #target = aws_lambda_function.HelloWorldLambda.arn
#     #target_lambda_arn = aws_lambda_function.HelloWorldLambda.arn
# }

# resource "aws_apigatewayv2_stage" "production" {
#     api_id = aws_apigatewayv2_api.api_gateway.id
#     name = "production"
#     auto_deploy = true
# }

# resource "aws_apigatewayv2_integration" "lambda_hello" {
#     api_id = aws_apigatewayv2_api.api_gateway.id
#     integration_uri = aws_lambda_function.HelloWorldLambda.invoke_arn
#     integration_type = "AWS_PROXY"
#     integration_method = "POST"
# }

# resource "aws_apigatewayv2_route" "get_hello" {
#     api_id = aws_apigatewayv2_api.api_gateway.id
#     route_key = "GET /my_resource"
#     target = aws_apigatewayv2_integration.lambda_hello.id
# }

