variable "tag_name" {
    default = "assignment"
}

variable "vpc_cidr" {
    default = "10.0.0.0/16"
}

# variable "vpc_id" {
# }
variable "securitygroup_cidr" {
    default = "0.0.0.0/0"
}
variable "subnet_cidr" {
    default = "10.0.1.0/24"
}


variable "rt_cidr" {
    default = "0.0.0.0/0"
}

variable "available_zone" {
    default = "ap-southeast-2a"
}