resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.Service-Two.zone_id
  name    = "web.rabbit-mq.xyz"
  type    = "A"

  alias {
    name                   = aws_lb.web-app-alb.dns_name
    zone_id                = aws_lb.web-app-alb.zone_id
    evaluate_target_health = false
  }
}
