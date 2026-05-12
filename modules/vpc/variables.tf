variable "demo_project_vpc_cidr" {
    description = "project vpc cidr"
    type = string
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

