module "network" {
  source = "./network"
}

module "alb" {
  source = "./alb"
}

module "ecs" {
  source = "./ecs"
}

module "ecs_task_definition" {
  source = "./ecs_task_definition"
}