variable "vpc_azs" {
  description = "VPC availability zones"
  type        = list(any)
  default     = ["us-east-1a", "us-east-1b"]

}
variable "vpc_create_database_subnet_group" {
  description = "subnet group for database creation via cli."
  type        = bool
  default     = true

}
variable "vpc_create_database_subnet_route_table" {
  description = "create vpc database route table."
  type        = bool
  default     = true

}
variable "vpc_enable_nat_gateway" {
  description = "enable nat for private subnets outbound communications."
  type        = bool
  default     = false

}
variable "vpc_single_nat_gateway" {
  description = "enable only a single nat gateway."
  type        = bool
  default     = false

}
