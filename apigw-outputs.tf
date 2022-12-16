output "api_id" {
  description = "Rest API ID"
  value       = aws_api_gateway_rest_api.myAPI.id
}

output "root_resource_id" {
  description = "Root Resource ID"
  value = aws_api_gateway_rest_api.myAPI.root_resource_id
}

output "apigw_invoke_url" {
  description = "invoke URL"
  value = aws_api_gateway_stage.my_stage.invoke_url
}

# output "apigw_api_key" {
#   description = "API GW key value"
#   value = aws_api_gateway_api_key.my_api.value
# }

output "base_url" {
  description = "Deployment invoke url"
  value = aws_api_gateway_deployment.my_deployment.invoke_url
}