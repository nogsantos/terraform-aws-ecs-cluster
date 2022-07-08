# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_alb_listener" "default" {
  load_balancer_arn = aws_alb.cluster_alb.arn
  port              = lookup(var.listener, "port", "")
  protocol          = lookup(var.listener, "protocol", "HTTP")
  ssl_policy        = lookup(var.listener, "ssl_policy", "")
  certificate_arn   = lookup(var.listener, "certificate_arn", "")

  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      status_code  = "403"
    }
  }
}
