resource "aws_alb" "far_alb" {
  name                       = "${var.cluster_name}"
  internal                   = "false"
  load_balancer_type         = "${var.alb_type}"
  security_groups            = ["${var.sg_group}"]
  subnets                    = "${var.subnet_cidr}"
  enable_deletion_protection = true
  tags = {
    Environment = "${var.cluster_name}"
  }
}

resource "aws_lb_target_group" "tf-tg" {
  name     = "${var.cluster_name}"
  port     = "${var.front_port}"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
  #target_type 			= "ip"
}

resource "aws_alb_listener" "tf-listner" {
  load_balancer_arn = "${aws_alb.far_alb.arn}"
  port              = "${var.front_port}"
  protocol          = "HTTP"
  default_action {
    type             = "${var.back_method}"
    target_group_arn = "${aws_lb_target_group.tf-tg.arn}"
  }
}

//resource "aws_lb_target_group_attachment" "name" {

//}

output "alb_name" {
  value = "${aws_alb.far_alb.id}"
}

output "alb_arn" {
  value = "${aws_lb_target_group.tf-tg.arn}"
}
