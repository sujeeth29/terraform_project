resource "aws_vpc" "demo_project_vpc" {
    cidr_block = var.demo_project_vpc_cidr
    tags = {
        Name = "${var.env}-vpc"
    }
}

resource "aws_subnet" "demo_project_public_subnet" {
    vpc_id = aws_vpc.demo_project_vpc.id
    cidr_block = var.demo_project_public_subnet_cidr
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true
    tags = {
      Name = "${var.env}-public-subnet"
    }
}

resource "aws_subnet" "demo_project_private_subnet" {
    count = var.enable_private_tier ? 1 : 0
    vpc_id = aws_vpc.demo_project_vpc.id
    cidr_block = var.demo_project_private_subnet_cidr
    availability_zone = "us-east-1b"
    tags = {
      Name = "${var.env}-private-subnet"
    }
}

resource "aws_internet_gateway" "demo_project_igw" {
    tags = {
      Name = "${var.env}-igw"
    }
}

resource "aws_internet_gateway_attachment" "demo_project_vpc_igw_attachment" {
    vpc_id = aws_vpc.demo_project_vpc.id
    internet_gateway_id = aws_internet_gateway.demo_project_igw.id
}