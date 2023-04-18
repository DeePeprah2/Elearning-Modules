# terraform import aws_ecs_cluster.stateless stateless-app
  # aws_ecs_cluster.elearning-cluster:
resource "aws_ecs_cluster" "elearning-cluster" {
    name               = "elearning-cluster"
}
