output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets"
  value       = aws_subnet.private[*].id
}

output "task_subnet_ids" {
  description = "Subnets to use for ECS tasks (private if NAT enabled, otherwise public)"
  value       = var.enable_nat_gateway ? aws_subnet.private[*].id : aws_subnet.public[*].id
}

output "assign_public_ip" {
  description = "Whether to assign a public IP to tasks (true when NAT is disabled)"
  value       = !var.enable_nat_gateway
}
