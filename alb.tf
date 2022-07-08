# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_alb" "cluster_alb" {
  name            = format("%s-alb", var.cluster_name)
  internal        = true
  subnets         = var.availability_zones
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name = format("%s-alb", var.cluster_name)
  }
}
