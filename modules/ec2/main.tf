data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
    filter {
      name = "architecture"
      values = [ "x86_64" ]
    }
}

resource "aws_security_group" "demo_project_pub_sg" {
    vpc_id = var.vpc_id
    description = "demo project public security group"
}

resource "aws_vpc_security_group_egress_rule" "demo_project_pub_egress" {
    security_group_id = aws_security_group.demo_project_pub_sg.id
    ip_protocol = "-1"
    from_port = 0
    to_port = 0
}

resource "aws_vpc_security_group_ingress_rule" "demo_project_pub_ingress" {
    security_group_id = aws_security_group.demo_project_pub_sg.id
    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_ipv4 = "0.0.0.0/0"
}


resource "aws_instance" "demo_project_pub_inst" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = "t3.micro"
    key_name = "${var.env}_key"
    security_groups = [ aws_security_group.demo_project_pub_sg.id ]
    subnet_id = var.public_subnet_id
    associate_public_ip_address = true
    tags = {
      Name = "${var.env}-pub_server"
    }
}



