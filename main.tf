module "cognito_user_pool" {
  source                        = "./modules/cognito"
  cognito_user_pool_name        = var.cognito_user_pool_name
  cognito_user_pool_domain      = var.cognito_user_pool_domain
  cognito_user_pool_client_name = var.cognito_user_pool_client_name
}


module "project_vpc" {
  source                           = "./modules/vpc"
  demo_project_vpc_cidr            = var.demo_project_vpc_cidr
  demo_project_public_subnet_cidr  = var.demo_project_public_subnet_cidr
  demo_project_private_subnet_cidr = var.demo_project_private_subnet_cidr
  enable_private_tier              = var.enable_private_tier
  env                              = var.env
}

module "public_server"{
  source = "./modules/ec2"
  env = var.env
}

 