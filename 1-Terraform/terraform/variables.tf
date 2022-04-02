variable "ami_id" {
    description = "Value of the for the ami instance"
    type = string
}
variable "environment" {
    description = "Value of the environment"
    type = string
}
variable "instance_type" {
    description = "Value"
    type = string
}
variable "ssh_cidr" {
    description = "Value"
    type = string
}
variable "cidr_block_p" {
    description = "Value of Network Prefix Block"
    type = string
}
variable "tags" {
    description = "Value"
    type = map(string)
}
variable "vpc_id" {
    description = "Value"
    type = string
}