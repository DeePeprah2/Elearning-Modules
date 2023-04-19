# terraform import aws_ecs_cluster.stateless stateless-app
  # aws_ecs_cluster.elearning-cluster:
resource "aws_ecs_cluster" "elearning-cluster" {
    name               = "elearning-cluster"
}

# create task definition 
# terraform import aws_ecs_task_definition.example arn:aws:ecs:eu-west-2:269043264593:task-definition/elearning-task:1
# aws_ecs_task_definition.elearning:
resource "aws_ecs_task_definition" "elearning" {
    container_definitions    = jsonencode(
        
    )
    cpu                      = "512"
    family                   = "elearning-task"
    id                       = "elearning-task"
    memory                   = "1024"
    network_mode             = "awsvpc"
    requires_compatibilities = [
        "FARGATE",
    ]
    revision                 = 1
    tags                     = {}
    tags_all                 = {}

    runtime_platform {
        cpu_architecture        = "X86_64"
        operating_system_family = "LINUX"
    }
} 

