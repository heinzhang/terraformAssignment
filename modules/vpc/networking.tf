resource "aws_vpc" "assignment_vpc" {
    cidr_block = "${var.vpc_cidr}"
    tags = {
        name = "${var.tag_name}"
    }
}


resource "aws_subnet" "assignment_subnet_1" {
    vpc_id = aws_vpc.assignment_vpc.id
    cidr_block = "${var.subnet_cidr}"
    #cidr_block = "10.0.1.0/24"
    #availability_zone = "ap-southeast-2a"
    availability_zone = "${var.available_zone}"
}


resource "aws_internet_gateway" "assignment_gw" {
    vpc_id = aws_vpc.assignment_vpc.id
}

resource "aws_route_table" "assignment_route_table" {
    vpc_id = aws_vpc.assignment_vpc.id
    route {
        cidr_block = "${var.rt_cidr}"
        gateway_id = aws_internet_gateway.assignment_gw.id
    }
    tags = {
        name = "${var.tag_name}"
    }
}

resource "aws_route_table_association" "assignment_association" {
    subnet_id =  aws_subnet.assignment_subnet_1.id 
    route_table_id = aws_route_table.assignment_route_table.id
}

resource "aws_network_interface" "assignment_ni" {
    subnet_id = aws_subnet.assignment_subnet_1.id  
    private_ips = ["10.0.1.20"]
    security_groups = [aws_security_group.assignment_allow_web.id]
}


resource "aws_eip" "assignment_eip" {
    vpc = true 
    network_interface = aws_network_interface.assignment_ni.id  
    associate_with_private_ip = "10.0.1.20"
    depends_on = [aws_internet_gateway.assignment_gw]
}


resource "aws_security_group" "assignment_allow_web" {
  name        = "allow_web_traffics"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.assignment_vpc.id 

  ingress  {
      description      = "https traffic from vpc"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      =  ["${var.securitygroup_cidr}"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

  ingress {
      description      = "http traffic from vpc"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      =  ["${var.securitygroup_cidr}"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

   ingress {
      description      = "ssh from vpc"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      =  ["${var.securitygroup_cidr}"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

    ingress {
      description      = "ngix default 8080"
      from_port        = 8080
      to_port          = 8080
      protocol         = "tcp"
      cidr_blocks      =  ["${var.securitygroup_cidr}"]
      #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
    }

  egress {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["${var.securitygroup_cidr}"]
      #ipv6_cidr_blocks = ["::/0"]
    }

  tags = {
     name = "${var.tag_name}"
  }
}