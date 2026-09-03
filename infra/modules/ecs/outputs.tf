output "cluster_id" {
  description = "The ID of the ECS Cluster"
  value       = aws_ecs_cluster.main.id
}

output "cluster_name" {
  description = "The name of the ECS Cluster"
  value       = aws_ecs_cluster.main.name
}

output "service_name" {
  description = "The name of the ECS Service"
  value       = aws_ecs_service.app.name
}

output "task_definition_arn" {
  description = "The ARN of the Task Definition"
  value       = aws_ecs_task_definition.app.arn
}

output "task_definition_family" {
  description = "The family of the Task Definition"
  value       = aws_ecs_task_definition.app.family
}

output "ecs_security_group_id" {
  description = "The Security Group ID of the ECS tasks"
  value       = aws_security_group.ecs_service.id
}

output "execution_role_arn" {
  description = "The ARN of the ECS Task Execution Role"
  value       = aws_iam_role.ecs_execution_role.arn
}

output "task_role_arn" {
  description = "The ARN of the ECS Task Role"
  value       = aws_iam_role.ecs_task_role.arn
}
