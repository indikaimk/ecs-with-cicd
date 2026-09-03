variable "aws_region" {
  description = "AWS region where resources will be provisioned."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Name of the project, used as a prefix for all resources."
  type        = string
  default     = "ecs-flask"
}

variable "environment" {
  description = "Environment name (e.g. dev, staging, prod)."
  type        = string
  default     = "dev"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_nat_gateway" {
  description = "Whether to provision a NAT Gateway for private subnets. If false, tasks run in public subnets with public IPs to save cost in lab environments."
  type        = bool
  default     = true
}

variable "container_port" {
  description = "Port exposed by the Flask container."
  type        = number
  default     = 5000
}

variable "app_count" {
  description = "Number of ECS Fargate tasks to run."
  type        = number
  default     = 2
}

variable "fargate_cpu" {
  description = "Fargate CPU units (256 = 0.25 vCPU, 512 = 0.5 vCPU, 1024 = 1 vCPU)."
  type        = number
  default     = 256
}

variable "fargate_memory" {
  description = "Fargate Memory in MiB (512, 1024, 2048, etc.)."
  type        = number
  default     = 512
}

variable "github_repo" {
  description = "GitHub repository in the format 'owner/repo-name' for OIDC trust policy (e.g., 'octocat/ecs-with-cicd')."
  type        = string
  default     = "my-org/ecs-with-cicd"
}

variable "github_branch" {
  description = "GitHub branch allowed to assume the OIDC role (e.g., 'main' or '*')."
  type        = string
  default     = "main"
}
