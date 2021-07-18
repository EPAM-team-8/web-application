# ALB

resource "aws_lb" "web-app-alb" {
  name               = "web-app-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [
    data.aws_security_group.sg.id
  ]
  subnets = data.aws_subnet_ids.main-subnets.ids
}

# ALB Listener

resource "aws_lb_listener" "forward_web" {
  load_balancer_arn = aws_lb.web-app-alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web-app-tg.arn
  }
}

# ALB Target Group

resource "aws_lb_target_group" "web-app-tg" {
  name     = "web-app-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.my-vpc.id

  health_check {
    path    = "/"
    matcher = "200-399"
  }
}

resource "aws_lb_target_group_attachment" "tg" {
  target_group_arn = aws_lb_target_group.web-app-tg.arn
  target_id        = aws_instance.Web-Application.id
  port             = 4200
}
