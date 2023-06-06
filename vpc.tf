resource "aws_vpc" "vpc4096ip" {
  cidr_block = "10.0.0.0/20"
}

resource "aws_subnet" "subnet256ip1" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "subnet256ip2" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "subnet256ip3" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet256ip4" {
  vpc_id = aws_vpc.vpc4096ip.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = true
}



resource "aws_api_gateway_rest_api" "miAPI" {
    name = "Marcelo-api-gw"
}

resource "aws_api_gateway_resource" "mi_recurso" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    parent_id = aws_api_gateway_rest_api.miAPI.root_resource_id
    path_part = "mi_recurso"
}

resource "aws_api_gateway_method" "mi_metodo" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    resource_id = aws_api_gateway_resource.mi_recurso.id
    http_method = "GET"
    authorization = "NONE"
}

resource "aws_api_gateway_integration" "mi_integracion" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    resource_id = aws_api_gateway_resource.mi_recurso.id
    http_method = aws_api_gateway_method.mi_metodo.http_method
    integration_http_method = "POST"
    type = "AWS_PROXY"
    uri = aws_lambda_function.LambdaHW.invoke_arn
}

resource "aws_api_gateway_method_response" "respuesta_metodo" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    resource_id = aws_api_gateway_resource.mi_recurso.id
    http_method = aws_api_gateway_method.mi_metodo.http_method
    status_code = "200"
}

resource "aws_api_gateway_integration_response" "my_integration_response" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    resource_id = aws_api_gateway_resource.mi_recurso.id
    http_method = aws_api_gateway_method.mi_metodo.http_method
    status_code = aws_api_gateway_method_response.respuesta_metodo.status_code
    depends_on = [ aws_api_gateway_integration.mi_integracion ]
}

resource "aws_api_gateway_deployment" "mi_deployment" {
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    lifecycle {
      create_before_destroy = true
    }
    depends_on = [aws_api_gateway_method.mi_metodo, aws_api_gateway_integration.mi_integracion]
}

resource "aws_api_gateway_stage" "mi_escenario" {
    stage_name = "production"
    rest_api_id = aws_api_gateway_rest_api.miAPI.id
    deployment_id = aws_api_gateway_deployment.mi_deployment.id

    lifecycle {
      create_before_destroy = false
    }
}

resource "aws_api_gateway_usage_plan" "plan_uso" {
    name = "my-usage-plan"
    description = "description"
    product_code = "MYCODE"

    api_stages {
      api_id = aws_api_gateway_rest_api.miAPI.id
      stage = aws_api_gateway_stage.mi_escenario.stage_name
    }
}

resource "aws_api_gateway_api_key" "my_api" {
    name = "my-stream"
}

resource "aws_api_gateway_usage_plan_key" "mi_llave_plan" {
    key_id = aws_api_gateway_api_key.my_api.id
    key_type = "API_KEY"
    usage_plan_id = aws_api_gateway_usage_plan.plan_uso.id
}

output "apigw_deployment" {
  description = "My deployment ARN"
  value = aws_api_gateway_deployment.mi_deployment.execution_arn
}
