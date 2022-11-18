variable "aws_region" {
  description = "vpc deployment region in aws."
  type        = string
  default     = "us-east-1"

}
variable "business_division" {
  description = "business division where this infra will be deployed to."
  type        = string
  default     = "SAP"

}
