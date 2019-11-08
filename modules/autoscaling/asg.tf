resource "aws_autoscaling_group" "tf-autoscaling" {
  availability_zones        = "${var.nazs}"
  force_delete              = "true"
  health_check_grace_period = "300"
  health_check_type         = "ELB"
  launch_configuration      = "${var.launch_conf}"
  desired_capacity          = "1"
  max_size                  = "2"
  min_size                  = "0"
  name                      = "${var.cluster_name}"
  protect_from_scale_in     = false
  vpc_zone_identifier       = "${var.subnet_cidr}"
  #  wait_for_capacity_timeout = "10m"
  tag {
    key                 = "Name"
    propagate_at_launch = true
    value               = "${var.cluster_name}"
  }
}

resource "aws_autoscaling_policy" "tf-asg-policy" {
  name                   = "${var.cluster_name}"
  scaling_adjustment     = "1"
  adjustment_type        = "ChangeInCapacity"
  cooldown               = "300"
  autoscaling_group_name = "${var.cluster_name}"
  #autoscaling_group_name = "${aws_autoscaling_group.tf-autoscaling.name}"
  policy_type = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm" {
  alarm_name          = "${var.cluster_name}-alarm"
  alarm_description   = "${var.cluster_name}-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ELB"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tf-autoscaling.name}"
  }
  actions_enabled = true
  #  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions = ["${aws_autoscaling_policy.tf-asg-policy.arn}"]
}


resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = "${aws_autoscaling_group.tf-autoscaling.id}"
  alb_target_group_arn   = "${var.alb-arn}"
  //alb_target_group_arn = "${aws_alb_target_group.test.arn}"
}

