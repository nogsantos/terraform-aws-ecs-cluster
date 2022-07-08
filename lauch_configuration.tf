# =============================================================================
# Terraform
# =============================================================================
#
# ECS
# -----------------------------------------------------------------------------
data "aws_ami" "aws_optimized_ecs" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20220509-x86_64-ebs"]
  }
}

resource "aws_key_pair" "this" {
  key_name   = format("%s-instance-key", var.cluster_name)
  public_key = file("${path.root}/keys/security.pub")
}

resource "aws_launch_configuration" "ecs_config_launch_config" {
  name_prefix                 = format("%s-instance", var.cluster_name)
  image_id                    = data.aws_ami.aws_optimized_ecs.id
  instance_type               = var.instances_size
  security_groups             = [aws_security_group.alb_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ecs_agent.arn
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = false

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=${var.cluster_name} >> /etc/ecs/ecs.config
EOF
}
