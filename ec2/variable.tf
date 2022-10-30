# variables.tf

variable "instance_type" {
  type        = string
  description = "The type of instance to start. Updates to this field will trigger a stop/start of the EC2 instance."
}

variable "ami" {
  type        = string
  default     = ""
  description = "The AMI to use for the instance."
}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}


variable "tags" {
  default = {
    created_by = "terraform"
 }
}

variable "security_groups" {
  description = "A list of Security Group IDs to associate with EC2 instance."
  type        = list(string)
  default     = []
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}