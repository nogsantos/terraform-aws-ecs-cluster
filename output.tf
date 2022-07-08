# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------

output "cluster_id" {
  value = aws_ecs_cluster.cluster.id
}

output "dns_name" {
  value = aws_alb.cluster_alb.dns_name
}

output "alb" {
  value = aws_alb.cluster_alb.arn
}

output "listener" {
  value = aws_alb_listener.default.arn
}

output "route_zone_id" {
  value = aws_route53_zone.this.zone_id
}

output "route_zone_name" {
  value = local.zone_name
}
