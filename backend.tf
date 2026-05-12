terraform {
  backend "s3" {
    bucket         = "sujeeth-cloud-storage"
    key            = "project_demo/state_files/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "lock-terraform-state"
    encrypt        = true
  }
}
