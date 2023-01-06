resource "aws_route53_record" "app_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "apps.husna.cloud"
  type    = "A"
  alias {
    name                   = data.aws_route53_zone.mydomain.arn
    zone_id                = data.aws_route53_zone.mydomain.id
    evaluate_target_health = true
  }

}
