variable "env" {
    type = string
}

variable "vpc_id" {
    type = string
}

variable "public_subnet_id" {
  type = string
}

variable "public_subnet_ip_cidr" {
    type = string
}

variable "private_subnet_id" {
    type = string
}

variable "enable_private_server" {
  type = bool
}