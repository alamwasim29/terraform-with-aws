module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 8.0"

  name = "${local.owners}-${local.common_tags.environment}-alb"

  load_balancer_type = "application"

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         = data.terraform_remote_state.vpc.outputs.pub_subnet_id
  security_groups = [data.terraform_remote_state.vpc.outputs.pub_security_group]

  target_groups = [
    {
      name_prefix          = "app1-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }
      protocol_version = "HTTP1"
      targets = {
        my_app1_vm1 = {
          target_id = data.terraform_remote_state.compute.outputs.pvt_instance_id[0]
          port      = 80
        }
        my_app1_vm2 = {
          target_id = data.terraform_remote_state.compute.outputs.pvt_instance_id[1]
          port      = 80
        }
      }
      tags = local.common_tags
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0 #app1 tg associated with this listener
    }
  ]

  tags = local.common_tags
}
