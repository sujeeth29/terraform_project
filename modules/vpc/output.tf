output "demo_vpc_id" {
    value = aws_vpc.demo_project_vpc.id
}

output "demo_public_subnet_id" {
    value = aws_subnet.demo_project_public_subnet.id
}