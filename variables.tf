variable "cognito_user_pool_name" {
  description = "provide the user pool name"
  type        = string
}

variable "cognito_user_pool_domain" {
  description = "provide the user pool domain"
  type        = string
}

variable "cognito_user_pool_client_name" {
  description = "provide the user pool client name"
  type        = string
}

variable "demo_project_vpc_cidr" {
  description = "project vpc cidr"
  type        = string
}
variable "env" {
  type = string
}

variable "demo_project_public_subnet_cidr" {
  type = string
}

variable "enable_private_tier" {
  type = bool
}

variable "demo_project_private_subnet_cidr" {
  type = string
}
