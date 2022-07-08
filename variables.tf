# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
variable "cluster_name" {}
variable "environment" {}

variable "instances_size" {
  type        = string
  description = "Defines the instances size"
}
variable "cluster_domain" {
  default = "dev"
}

variable "capacity_providers" {
  type    = list(any)
  default = ["EC2"]
}

variable "enable_container_insights" {
  type    = bool
  default = false
}

variable "vpc_id" {}
variable "vpc_ipv4_cird" {}

variable "environment_data" {
  type = object({
    vpc_id        = string
    vpc_ipv4_cird = string
    subnets       = list(string)
  })
  description = "Environment network configurations"
}

variable "listener" {
  type = map(any)
  default = {
    port            = "80"
    certificate_arn = ""
    ssl_policy      = "ELBSecurityPolicy-TLS-1-1-2017-01"
  }
}

variable "availability_zones" {
  type = list(string)
}
