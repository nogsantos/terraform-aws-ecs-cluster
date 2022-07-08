# =============================================================================
# Terraform
# =============================================================================
#
# Route 53
# -----------------------------------------------------------------------------

locals {
  zone_name = format("ecs.%s-%s.internal", var.cluster_name, var.environment)
}

resource "aws_route53_zone" "this" {
  name = local.zone_name

  vpc {
    vpc_id = lookup(var.environment_data, "vpc_id", "")
  }
}

