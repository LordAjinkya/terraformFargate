resource "aws_ecs_cluster" "app_cluster" {
  name = "aspcorefargatecluster"
}

output "cluster_id" {
  value = aws_ecs_cluster.app_cluster.id
}