resource "aws_route53_record" "app_dns" {
  count   = 3
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = "${var.headers[count.index]}.husna.cloud"
  type    = "A"
  alias {
    name                   = module.alb.lb_dns_name
    zone_id                = module.alb.lb_zone_id
    evaluate_target_health = true
  }

}
# resource "aws_route53_record" "app_dns" {
#   zone_id = data.aws_route53_zone.mydomain.zone_id
#   name    = "apps.husna.cloud"
#   type    = "A"
#   alias {
#     name                   = module.alb.lb_dns_name
#     zone_id                = module.alb.lb_zone_id
#     evaluate_target_health = true
#   }

# }
# resource "aws_route53_record" "app1_dns" {
#   zone_id = data.aws_route53_zone.mydomain.zone_id
#   name    = "app1.husna.cloud"
#   type    = "A"
#   alias {
#     name                   = module.alb.lb_dns_name
#     zone_id                = module.alb.lb_zone_id
#     evaluate_target_health = true
#   }

# }
# resource "aws_route53_record" "app2_dns" {
#   zone_id = data.aws_route53_zone.mydomain.zone_id
#   name    = "app2.husna.cloud"
#   type    = "A"
#   alias {
#     name                   = module.alb.lb_dns_name
#     zone_id                = module.alb.lb_zone_id
#     evaluate_target_health = true
#   }

# }
