module "ec2_pvt" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.0"
  # insert the 10 required variables here
  name          = "${local.owners}-${local.common_tags.environment}-ec2-pvt"
  count         = var.pvt_instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.pub_key_name
  #monitoring             = true
  subnet_id              = data.terraform_remote_state.vpc.outputs.pvt_subnet_id[count.index]
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.pvt_security_group]
  user_data              = file("../../script/app1.sh")
  tags                   = local.common_tags
}
