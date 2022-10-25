# variables.tf

variable "create_vpc" {
  description = "Controls if VPC should be created (it affects almost all resources)"
  type        = bool
  default     = true
}

variable "name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "192.168.0.0/16"
}  
 

variable "public_subnets_cidr" {
        description = "A list of public subnets inside the VPC"
        type = list(string)
        default = ["192.168.0.0/26", "192.168.0.64/26"]
}

variable "private_subnets_cidr" {
        description = "A list of private subnets inside the VPC"
        type = list(string)
        default = ["192.168.0.128/26", "192.168.0.192/26"]
}

variable "azs" {
        type = list(string)
        default = ["ap-southeast-1a", "ap-southeast-1b"]
}

variable "tags" {
        type = list(string)
        default = ["A", "B"]
}

variable "nat-azs" {
        type = list(string)
        default = ["ap-southeast-2a"]
}
