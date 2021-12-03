# AWS Load Balancer controller with Public-facing ALB
resource "aws_lb" "public_alb" {
  name               = "public-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.vpc.default_security_group_id]
  subnets            = module.vpc.public_subnets # Spread traffic among 3 public subnets

  enable_deletion_protection = false
}