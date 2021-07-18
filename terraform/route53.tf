resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.web-zone.zone_id
  name    = "web"
  type    = "A"

  alias {
    name                   = aws_lb.web-app-alb.dns_name
    zone_id                = aws_lb.web-app-alb.zone_id
    evaluate_target_health = false
  }
}
