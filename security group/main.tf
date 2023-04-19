// creating elearning security group
resource "aws_security_group" "alb_sg" {
  name        = "elearning-alb-sg"
  description = "enable port 80/443"
  vpc_id      = var.elearning-vpc.id 

  ingress {
    description      = "access http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

ingress {
    description      = "access https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
   
  }

  tags = {
    Name = "elearning-alb-sg"
  }
}

}

// App server security group
resource "aws_security_group" "app_server_security_group" {
  name        = "elearning-alb-sg"
  description = "enable port 80/443 access via alb sg"
  vpc_id      = var.vpc.elearning-vpc.id

  ingress {
    description      = "access http"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    security_security_groups = [aws_security_group.alb_sg.id]
    
  }

ingress {
    description      = "access https"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    security_security_groups = [aws_security_group.alb_sg.id]  
    
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]

  }

  tags = {
    Name = "elearning-alb-sg"
  }
}

}