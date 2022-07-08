# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
resource "aws_autoscaling_group" "ecs_cluster" {
  name_prefix               = format("%s_asg_", var.cluster_name)
  default_cooldown          = 30
  health_check_grace_period = 30
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 2
  vpc_zone_identifier       = var.environment_data.subnets
  launch_configuration      = aws_launch_configuration.ecs_config_launch_config.name

  termination_policies = [
    "OldestInstance"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}
