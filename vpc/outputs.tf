output "vpc_id" {
  description = "The ID of the VPC"
  value       = try(aws_vpc.prod-vpc.id, "")
}

output "vpc_arn" {
  description = "The ARN of the VPC"
  value       = try(aws_vpc.prod-vpc.arn, "")
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = try(aws_vpc.prod-vpc.cidr_block, "")
}

output "default_security_group_id" {
  description = "The ID of the security group created by default on VPC creation"
  value       = try(aws_vpc.prod-vpc.default_security_group_id, "")
}

output "default_network_acl_id" {
  description = "The ID of the default network ACL"
  value       = try(aws_vpc.prod-vpc.default_network_acl_id, "")
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = try(aws_vpc.prod-vpc.default_route_table_id, "")
}

output "vpc_instance_tenancy" {
  description = "Tenancy of instances spin up within VPC"
  value       = try(aws_vpc.prod-vpc.instance_tenancy, "")
}

output "vpc_enable_dns_support" {
  description = "Whether or not the VPC has DNS support"
  value       = try(aws_vpc.prod-vpc.enable_dns_support, "")
}

output "vpc_enable_dns_hostnames" {
  description = "Whether or not the VPC has DNS hostname support"
  value       = try(aws_vpc.prod-vpc.enable_dns_hostnames, "")
}

output "vpc_main_route_table_id" {
  description = "The ID of the main route table associated with this VPC"
  value       = try(aws_vpc.prod-vpc.main_route_table_id, "")
}

output "vpc_ipv6_association_id" {
  description = "The association ID for the IPv6 CIDR block"
  value       = try(aws_vpc.prod-vpc.ipv6_association_id, "")
}

output "vpc_ipv6_cidr_block" {
  description = "The IPv6 CIDR block"
  value       = try(aws_vpc.prod-vpc.ipv6_cidr_block, "")
}


output "vpc_owner_id" {
  description = "The ID of the AWS account that owns the VPC"
  value       = try(aws_vpc.prod-vpc.owner_id, "")
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = aws_subnet.private[*].id
}

output "private_subnet_arns" {
  description = "List of ARNs of private subnets"
  value       = aws_subnet.private[*].arn
}

output "private_subnets_cidr_blocks" {
  description = "List of cidr_blocks of private subnets"
  value       = compact(aws_subnet.private[*].cidr_block)
}

output "private_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of private subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.private[*].ipv6_cidr_block)
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = aws_subnet.public[*].id
}

output "public_subnet_arns" {
  description = "List of ARNs of public subnets"
  value       = aws_subnet.public[*].arn
}

output "public_subnets_cidr_blocks" {
  description = "List of cidr_blocks of public subnets"
  value       = compact(aws_subnet.public[*].cidr_block)
}

output "public_subnets_ipv6_cidr_blocks" {
  description = "List of IPv6 cidr_blocks of public subnets in an IPv6 enabled VPC"
  value       = compact(aws_subnet.public[*].ipv6_cidr_block)
}


output "public_route_table_ids" {
  description = "List of IDs of public route tables"
  value       = aws_route_table.public_rt[*].id
}

output "private_route_table_ids" {
  description = "List of IDs of private route tables"
  value       = aws_route_table.private_rt[*].id
}


output "private_route_table_association_ids" {
  description = "List of IDs of the private route table association"
  value       = aws_route_table_association.private[*].id
}


output "public_route_table_association_ids" {
  description = "List of IDs of the public route table association"
  value       = aws_route_table_association.public[*].id
}

output "nat_ids" {
  description = "List of allocation ID of Elastic IPs created for AWS NAT Gateway"
  value       = aws_eip.nat[*].id
}


output "natgw_ids" {
  description = "List of NAT Gateway IDs"
  value       = aws_nat_gateway.prod_ngw[*].id
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = try(aws_internet_gateway.prod_igw.id, "")
}

output "igw_arn" {
  description = "The ARN of the Internet Gateway"
  value       = try(aws_internet_gateway.prod_igw.arn, "")
}

# Static values (arguments)
output "azs" {
  description = "A list of availability zones specified as argument to this module"
  value       = var.azs
}

output "name" {
  description = "The name of the VPC specified as argument to this module"
  value       = var.name
}