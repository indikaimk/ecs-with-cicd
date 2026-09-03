output "vpc_id" {
  description = "The ID of the VPC."
  value       = module.vpc.vpc_id
}

output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = module.ecr.repository_url
}

output "ecr_repository_name" {
  description = "The name of the ECR repository."
  value       = module.ecr.repository_name
}

output "alb_dns_name" {
  description = "The public DNS name of the Application Load Balancer."
  value       = module.alb.alb_dns_name
}

output "alb_endpoint" {
  description = "The HTTP endpoint for the Flask application."
  value       = "http://${module.alb.alb_dns_name}"
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster."
  value       = module.ecs.cluster_name
}

output "ecs_service_name" {
  description = "The name of the ECS service."
  value       = module.ecs.service_name
}

output "github_actions_role_arn" {
  description = "The ARN of the IAM Role for GitHub Actions OIDC."
  value       = module.oidc.github_actions_role_arn
}
