variable "aws_region" {
    description = "Region in which AWS Resources to be created"
    type = string
    default = "us-east-1"
}

variable "keypair" {
  description = "Keypair using to give access to resource"
  type = string
  default = "terraform-key"
}

variable "prefix" {
    description = "Name variable used as a prefix"
    type = string
    default = "mnl"
}

variable "environment" {
    description = "Environment Variable used as a prefix"
    type = string
    default = "dev"
}

variable "business" {
    description = "Organization"
    type = string
    default = "endava"
}