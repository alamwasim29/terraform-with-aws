module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.0"

  name = "${local.owners}-${local.common_tags.environment}-alb"

  load_balancer_type = "application"

  vpc_id          = data.terraform_remote_state.vpc.outputs.vpc_id
  subnets         = data.terraform_remote_state.vpc.outputs.pub_subnet_id
  security_groups = [data.terraform_remote_state.vpc.outputs.pub_security_group]

  target_groups = [
    # TG_index=0 hosting app1 in two diff subnets.
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
    },
    #TG_index=1 hosting app2 in two diff subnets.
    {
      name_prefix          = "app2-"
      backend_protocol     = "HTTP"
      backend_port         = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app2/index.html"
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
          target_id = data.terraform_remote_state.compute.outputs.pvt_instance_id[2]
          port      = 80
        }
        my_app1_vm2 = {
          target_id = data.terraform_remote_state.compute.outputs.pvt_instance_id[3]
          port      = 80
        }
      }
      tags = local.common_tags
    },
  ]


  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]
  https_listeners = [
    {
      port            = 443
      protocol        = "HTTPS"
      certificate_arn = module.acm.acm_certificate_arn
      action_type     = "fixed_response"
      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }
    },
  ]
  # HTTPS Listener rules
  https_listener_rules = [
    # rule-1: /app1* should go to app1 ec2 instances.
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 0
        }
      ]
      conditions = [{
        path_patterns = ["/app1*"]
      }]
    },
    # rule-2: /app2* should go to app2 ec2 instances.
    {
      https_listener_index = 0
      actions = [
        {
          type               = "forward"
          target_group_index = 1
        }
      ]
      conditions = [{
        path_patterns = ["/app2*"]
      }]
    },

  ]
  tags = local.common_tags
}
