locals {
  name_prefix = "${var.project_name}-${var.environment}"
}

# VPC Module
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  project_name        = var.project_name
  environment         = var.environment
  
  tags = merge(
    var.default_tags,
    {
      Module = "vpc"
    }
  )
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  project_name      = var.project_name
  environment       = var.environment
  aws_region        = var.aws_region
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  
  container_image  = var.container_image
  container_port   = var.container_port
  container_cpu    = var.container_cpu
  container_memory = var.container_memory
  desired_count    = var.desired_count
  min_capacity     = var.desired_count
  max_capacity     = var.desired_count * 3
  
  tags = merge(
    var.default_tags,
    {
      Module = "ecs"
    }
  )
  
  depends_on = [module.vpc]
}