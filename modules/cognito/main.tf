resource "aws_cognito_user_pool" "cognito_user_pool" {
    name = var.cognito_user_pool_name
    auto_verified_attributes = [ "email" ]
    mfa_configuration = "OFF"
    user_pool_tier = "LITE"
    admin_create_user_config {
      allow_admin_create_user_only = true
    }
    schema {
      name = "email"
      attribute_data_type = "String"
      mutable = true
      required = true
    }
    account_recovery_setting {
      recovery_mechanism {
        name = "verified_email"
        priority = 1
      }
    }
    password_policy {
      minimum_length = 8
      require_lowercase = true
      require_numbers = true
      require_uppercase = true
      require_symbols = true
      temporary_password_validity_days = 7
    }
    user_attribute_update_settings {
      attributes_require_verification_before_update = [ "email" ]
    }
    sign_in_policy {
      allowed_first_auth_factors = [ "PASSWORD" ]
    }
}

resource "aws_cognito_user_pool_domain" "cognito_user_pool_domain" {
    domain = var.cognito_user_pool_domain
    user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
}

resource "aws_cognito_user_pool_client" "cognito_user_pool_client" {
    user_pool_id = aws_cognito_user_pool.cognito_user_pool.id
    name = var.cognito_user_pool_client_name
    generate_secret = true
    allowed_oauth_flows_user_pool_client = true
    access_token_validity = 30
    refresh_token_validity = 30
    id_token_validity = 60
    token_validity_units {
      access_token = "minutes"
      refresh_token = "days"
      id_token = "minutes"
    }
    prevent_user_existence_errors = "ENABLED"
    enable_token_revocation = true
    auth_session_validity = 3
    supported_identity_providers = [ "COGNITO" ]
    allowed_oauth_scopes = [ "aws.cognito.signin.user.admin" ]
    explicit_auth_flows = [ "ALLOW_USER_PASSWORD_AUTH", "ALLOW_USER_SRP_AUTH", "ALLOW_CUSTOM_AUTH", "ALLOW_REFRESH_TOKEN_AUTH" ]
    allowed_oauth_flows = [ "code", "implicit" ]
    callback_urls = [ "http://localhost:3000", "http://localhost:4000" ]
    logout_urls = [ "http://localhost:3000", "http://localhost:4000" ]
}