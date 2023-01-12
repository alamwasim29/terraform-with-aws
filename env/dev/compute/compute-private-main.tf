module "ec2_pvt" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.0"
  # insert the 10 required variables here
  name          = contains([for i in range(0, var.pvt_instance_count / 2) : i], count.index) ? "${local.common_tags.environment}-${count.index}-app1" : "${local.common_tags.environment}-${count.index}-app2"
  count         = var.pvt_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.pub_key_name
  #monitoring             = true
  subnet_id              = contains([for i in range(0, var.pvt_instance_count, 2) : i], count.index) ? data.terraform_remote_state.vpc.outputs.pvt_subnet_id[0] : data.terraform_remote_state.vpc.outputs.pvt_subnet_id[1]
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.pvt_security_group]
  user_data              = contains([for i in range(0, var.pvt_instance_count / 2) : i], count.index) ? file("../../script/app1.sh") : file("../../script/app2.sh")
  tags                   = local.common_tags
}

resource "null_resource" "reboo_instance" {
  count = var.pvt_instance_count
  provisioner "local-exec" {
    on_failure = fail
    # interpreter = ["/bin/sh", "-c"]
    command = <<-EOF
        aws ec2 start-instances --instance-ids ${module.ec2_pvt[count.index].id} --profile terraform --region ${var.aws_region}
        EOF
  }
  #   this setting will trigger script every time,change it something needed
  triggers = {
    always_run = "${timestamp()}"
  }
}
