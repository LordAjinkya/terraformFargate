module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source              = "./subnets"
  vpc_id              = module.vpc.vpc_id
  public_route_table_id = module.vpc.public_route_table_id
  aws_region          = "us-east-1"
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source              = "./alb"
  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.subnets.public_subnet_1_id
  public_subnet_2_id  = module.subnets.public_subnet_2_id
  alb_sg_id           = module.security_groups.alb_sg_id
}

module "ecs_cluster" {
  source = "./ecs_cluster"
}

module "ecs_task_definition" {
  source = "./ecs_task_definition"
}

module "ecs_service" {
  source                = "./ecs_service"
  cluster_id            = module.ecs_cluster.cluster_id
  task_definition_arn   = module.ecs_task_definition.task_definition_arn
  public_subnet_1_id    = module.subnets.public_subnet_1_id
  public_subnet_2_id    = module.subnets.public_subnet_2_id
  ecs_task_sg_id        = module.security_groups.ecs_task_sg_id
  target_group_arn      = module.alb.target_group_arn
}