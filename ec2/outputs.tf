output "id" {
  description = "The ID of the instance"
  value       = try(aws_instance.prod-ec2.id, "")
}

output "arn" {
  description = "The ARN of the instance"
  value       = try(aws_instance.prod-ec2.arn, "")
}

output "capacity_reservation_specification" {
  description = "Capacity reservation specification of the instance"
  value       = try(aws_instance.prod-ec2.capacity_reservation_specification, "")
}

output "instance_state" {
  description = "The state of the instance. One of: `pending`, `running`, `shutting-down`, `terminated`, `stopping`, `stopped`"
  value       = try(aws_instance.prod-ec2.instance_state, "")
}


output "primary_network_interface_id" {
  description = "The ID of the instance's primary network interface"
  value       = try(aws_instance.prod-ec2.primary_network_interface_id, "")
}

output "private_dns" {
  description = "The private DNS name assigned to the instance. Can only be used inside the Amazon EC2, and only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.prod-ec2.private_dns, "")
}

output "public_dns" {
  description = "The public DNS name assigned to the instance. For EC2-VPC, this is only available if you've enabled DNS hostnames for your VPC"
  value       = try(aws_instance.prod-ec2.public_dns, "")
}

output "public_ip" {
  description = "The public IP address assigned to the instance, if applicable. NOTE: If you are using an aws_eip with your instance, you should refer to the EIP's address directly and not use `public_ip` as this field will change after the EIP is attached"
  value       = try(aws_instance.prod-ec2.public_ip, "")
}

output "private_ip" {
  description = "The private IP address assigned to the instance."
  value       = try(aws_instance.prod-ec2.private_ip, "")
}

output "ipv6_addresses" {
  description = "The IPv6 address assigned to the instance, if applicable."
  value       = try(aws_instance.prod-ec2.ipv6_addresses, [])
}

output "tags_all" {
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block"
  value       = try(aws_instance.prod-ec2.tags_all, {})
}
