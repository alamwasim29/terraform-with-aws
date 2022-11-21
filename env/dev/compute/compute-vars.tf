variable "instance_type" {
  description = "ec2 instance family type."
  type        = string
  default     = "t2.micro"
}

variable "pub_key_path" {
  description = "aws keypair to be attached with ec2 instance."
  type        = string
  default     = null
}
variable "pub_key_name" {
  description = "aws keypair to be attached with ec2 instance."
  type        = string
  default     = "ec2-access"
}

variable "instance_count" {
  description = "number of instance copy to be created."
  type        = number
  default     = 1

}
