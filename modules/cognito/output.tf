output "cognito_client_id" {
  value = aws_cognito_user_pool_client.cognito_user_pool_client.id
}

output "cognito_client_secret" {
  value = aws_cognito_user_pool_client.cognito_user_pool_client.client_secret
}

output "cognito_domain" {
  value = aws_cognito_user_pool_domain.cognito_user_pool_domain.domain
}