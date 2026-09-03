# =============================================================================
# OpenTofu Root Configuration
# =============================================================================

# 1. VPC & Networking
module "vpc" {
  source             = "./modules/vpc"
  project_name       = var.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  enable_nat_gateway = var.enable_nat_gateway
}

# 2. Container Registry (ECR)
module "ecr" {
  source       = "./modules/ecr"
  project_name = var.project_name
  environment  = var.environment
}

# 3. Application Load Balancer (ALB)
module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  environment       = var.environment
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  container_port    = var.container_port
  health_check_path = "/health"
}

# 4. Elastic Container Service (ECS Fargate)
module "ecs" {
  source                = "./modules/ecs"
  project_name          = var.project_name
  environment           = var.environment
  aws_region            = var.aws_region
  vpc_id                = module.vpc.vpc_id
  task_subnet_ids       = module.vpc.task_subnet_ids
  assign_public_ip      = module.vpc.assign_public_ip
  alb_security_group_id = module.alb.alb_security_group_id
  target_group_arn      = module.alb.target_group_arn
  ecr_repository_url    = module.ecr.repository_url
  container_port        = var.container_port
  app_count             = var.app_count
  fargate_cpu           = var.fargate_cpu
  fargate_memory        = var.fargate_memory
}

# 5. GitHub Actions OIDC Authentication & IAM Role
module "oidc" {
  source                 = "./modules/oidc"
  project_name           = var.project_name
  environment            = var.environment
  github_repo            = var.github_repo
  github_branch          = var.github_branch
  ecr_repository_arn     = module.ecr.repository_arn
  ecs_cluster_arn        = module.ecs.cluster_id
  ecs_service_name       = module.ecs.service_name
  ecs_execution_role_arn = module.ecs.execution_role_arn
  ecs_task_role_arn      = module.ecs.task_role_arn
}
