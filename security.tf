# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name        = format("%s-cluster-alb-sg", var.cluster_name)
  description = format("%s-cluster-alb-sg", var.cluster_name)
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-cluster-alb-sg", var.cluster_name)
  }
}

# Should be restricted, VPC cird
resource "aws_security_group_rule" "vpc" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = [var.vpc_ipv4_cird]
  security_group_id = aws_security_group.alb_sg.id
}

## Use only for maintenance purposes
resource "aws_security_group_rule" "ssh" {
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.alb_sg.id
  type              = "ingress"
}
