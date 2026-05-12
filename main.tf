module "cognito_user_pool" {
  source                        = "./modules/cognito"
  cognito_user_pool_name        = var.cognito_user_pool_name
  cognito_user_pool_domain      = var.cognito_user_pool_domain
  cognito_user_pool_client_name = var.cognito_user_pool_client_name
}
