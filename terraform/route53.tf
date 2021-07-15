data "aws_route53_zone" "Web-Application" {
  name    = "rabbit-mq.xyz"
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.Web-Application.zone_id
  name    = "web.rabbit-mq.xyz"
  type    = "A"
  ttl     = "300"
  records = [aws_instance.Web-Application.public_ip]
}
