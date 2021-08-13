output "vpc_id" {
    value = "${aws_vpc.assignment_vpc.id}"
}

output "gateway_id" {
    value = "${aws_internet_gateway.assignment_gw.id}"
}

output "subnet_id" {
    value = "${aws_subnet.assignment_subnet_1.id}"
}
output "routetable_id" {
    value = "${aws_route_table.assignment_route_table.id}"
}


output "securitygroup_id" {
    value = "${aws_security_group.assignment_allow_web.id}"
}

output "networkinterface_id" {
    value = "${aws_network_interface.assignment_ni.id}"
}