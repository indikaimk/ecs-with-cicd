variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "aws_region" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "task_subnet_ids" {
  type = list(string)
}

variable "assign_public_ip" {
  type    = bool
  default = false
}

variable "alb_security_group_id" {
  type = string
}

variable "target_group_arn" {
  type = string
}

variable "ecr_repository_url" {
  type = string
}

variable "container_port" {
  type    = number
  default = 5000
}

variable "app_count" {
  type    = number
  default = 2
}

variable "fargate_cpu" {
  type    = number
  default = 256
}

variable "fargate_memory" {
  type    = number
  default = 512
}

variable "image_tag" {
  type        = string
  default     = "latest"
  description = "Initial Docker image tag"
}
