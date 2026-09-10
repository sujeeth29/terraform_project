# output "cognito_client_id" {
#   value = module.cognito_user_pool.cognito_client_id
# }

# output "cognito_client_secret" {
#   value     = module.cognito_user_pool.cognito_client_secret
#   sensitive = true
# }

# output "cognito_domain" {
#   value = module.cognito_user_pool.cognito_domain
# }

output "public_server_ip" {
    value = module.server.demo_project_pub_inst_public_ip
}