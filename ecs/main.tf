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

# ecs Auto scaling group
resource "aws_autoscaling_group" "elearning_asg" {
  name                      = "foobar3-terraform-test"
  max_size                  = 4
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  
  launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier       = [aws_subnet.example1.id, aws_subnet.example2.id]

  initial_lifecycle_hook {
    name                 = "elearning"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = jsonencode({
      foo = "bar"
    })

    notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "elearning"
    value               = "elearning"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}

# create capacity provider
resource "aws_ecs_capacity_provider" "elearning_CP" {
  name = "elearning_CP"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.test.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      maximum_scaling_step_size = 1000
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 10
    }
  }
}


# create task definition 

# create es services 

# create task execution role

#