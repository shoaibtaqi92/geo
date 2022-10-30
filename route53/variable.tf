# variables.tf

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "create" {
  description = "Whether to create DNS records"
  type        = bool
  default     = true
}

variable "zone_id" {
  description = "ID of DNS zone"
  type        = string
  default     = null
}

variable "zone_name" {
  description = "Name of DNS zone"
  type        = string
  default     = null
}

variable "private_zone" {
  description = "Whether Route53 zone is private or public"
  type        = bool
  default     = false
}

variable "record_name" {
  description = "Name of DNS record"
  type        = string
  default     = null
}

variable "records" {
  description = "List of objects of DNS records"
  type        = any
  default     = []
}