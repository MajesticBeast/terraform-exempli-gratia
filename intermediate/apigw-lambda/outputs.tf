output "api_gateway_invoke_url" {
  description = "The URL to invoke the API Gateway"
  value       = "https://${aws_api_gateway_rest_api.api.id}.execute-api.${var.region}.amazonaws.com/${aws_api_gateway_deployment.api.stage_name}"
}