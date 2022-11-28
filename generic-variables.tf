variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "us-east-1"
}

variable "prefix" {
    description = "Name variable used as a prefix"
    type = string
    default = "mnl"
}

variable "environment" {
    description = "Environment Variable used as a prefix"
    type = string
    default = "endava"
}