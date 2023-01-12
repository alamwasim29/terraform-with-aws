variable "app1_dns_name" {
  description = "App1 DNS name"
}
variable "app2_dns_name" {
  description = "App1 DNS name"
}

variable "headers" {
  type        = list(any)
  description = "various header value to be used with domain name."

}
