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

resource "aws_route_table" "demo_project_public_rt" {
    vpc_id = aws_vpc.demo_project_vpc.id
    tags = {
      Name = "${var.env}-public_rt"
    }
}

resource "aws_route" "demo_project_pu_r" {
    route_table_id = aws_route_table.demo_project_public_rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_project_igw.id
}

resource "aws_route_table_association" "demo_project_pu_s_a" {
    route_table_id = aws_route_table.demo_project_public_rt.id
    subnet_id = aws_subnet.demo_project_public_subnet.id
}

resource "aws_eip" "demo_project_eip" {
    count = var.enable_private_tier ? 1 : 0
    domain = "vpc"
}

resource "aws_nat_gateway" "demo_project_nat" {
    count = var.enable_private_tier ? 1 : 0
    allocation_id = aws_eip.demo_project_eip[count.index].allocation_id
    subnet_id = aws_subnet.demo_project_public_subnet.id
    tags = {
      Name = "${var.env}-nat"
    }
}

resource "aws_route_table" "demo_project_pri_rt" {
    count = var.enable_private_tier ? 1 : 0
    vpc_id = aws_vpc.demo_project_vpc.id
    tags = {
      Name = "${var.env}-pri-rt"
    }
}

resource "aws_route" "demo_project_pri_r" {
    count = var.enable_private_tier ? 1 : 0
    route_table_id = aws_route_table.demo_project_pri_rt[count.index].id
    nat_gateway_id = aws_nat_gateway.demo_project_nat[count.index].id
    destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "demo_project_pri_r" {
    count = var.enable_private_tier ? 1 : 0
    route_table_id = aws_route_table.demo_project_pri_rt[count.index].id
    subnet_id = aws_subnet.demo_project_private_subnet[count.index].id
}