variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "github_repo" {
  description = "The GitHub repository in 'owner/repo' format."
  type        = string
}

variable "github_branch" {
  description = "Branch that can assume the deployment role."
  type        = string
  default     = "main"
}

variable "ecr_repository_arn" {
  type = string
}

variable "ecs_cluster_arn" {
  type = string
}

variable "ecs_service_name" {
  type = string
}

variable "ecs_execution_role_arn" {
  type = string
}

variable "ecs_task_role_arn" {
  type = string
}
