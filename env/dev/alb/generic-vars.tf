variable "aws_region" {
  description = "alb deployment region in aws."
  type        = string
  default     = "us-east-1"

}

variable "business_division" {
  description = "business division where the resources will be deployed to."
  type        = string
  default     = "SAP"

}
