# $ terraform import aws_lb.elearning-lb arn:aws:elasticloadbalancing:eu-west-2:269043264593:loadbalancer/app/elearning-lb/4cb0f4cfe50e7732
resource "aws_lb" "elearning-lb" {
  # (resource arguments)
}
resource "aws_lb" "elearning_alb" {
  name               = "elearning_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.app_server_security_group.id]
  subnets            = [aws_subnet.public_subnet_az1.id, aws_subnet.public_subnet_az2.id]

  enable_deletion_protection = true


  tags = {
    Environment = "dev"
  }
}


# create target group
resource "aws_lb_target_group" "elearning_tg" {
  name     = "ip"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.elearning-vpc.id
}
# health check?

# create alb listiner on port 80
resource "aws_lb_listener" "elearning_80_listiner" {
  load_balancer_arn = aws_lb.elearning_alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "redirect"
    target_group_arn = aws_lb_target_group.elearning_tg
  }
}

     redirect{
      port           = 443
      protocol       = HTTP
      status_code    = HTTP_301
     }

# create listiner on port 443
resource "aws_lb_listener" "elearning_443_listiner" {
  load_balancer_arn = aws_lb.elearning_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}


