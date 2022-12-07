module "ec2_public" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.2.0"
  depends_on = [
    resource.aws_key_pair.public_instance_auth
  ]
  # insert the 10 required variables here
  name          = "${local.common_tags.environment}-ec2-public"
  count         = var.instance_count
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.pub_key_name
  #monitoring             = true
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnet_id[count.index]
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.public_security_group]
  user_data              = file("../../script/nexus.sh")
  tags                   = local.common_tags
}
resource "aws_key_pair" "public_instance_auth" {
  key_name   = var.pub_key_name
  public_key = file(var.pub_key_path)

}
