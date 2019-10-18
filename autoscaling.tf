resource "aws_autoscaling_group" "tf-autoscaling" {
  availability_zones        = "${var.nazs}"
  force_delete              = "true"
  health_check_grace_period = "300"
  health_check_type         = "EC2"
  launch_configuration      = "${aws_launch_configuration.tf-launchconfig.name}"
  desired_capacity	    = "1"
  max_size                  = "2"
  min_size                  = "0"
  name                      = "source-consumer"
#  protect_from_scale_in     = false
  vpc_zone_identifier       = "${var.subnet_cidr}"
#  wait_for_capacity_timeout = "10m"
   tag {
       key                 = "Name"
       propagate_at_launch = true
       value               = "source consumer"
   }
}

resource "aws_autoscaling_policy" "tf-asg-policy" {
  name                   = "source-consumer-policy"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = "${aws_autoscaling_group.tf-autoscaling.name}"
  policy_type		 = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "tf-cpu-alarm" {
  alarm_name 	      = "source-consumer-cpu-alarm"
  alarm_description   = "source-consumer-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic	      = "Average"
  threshold	      = "30"

  dimensions = {
    AutoScalingGroupName = "${aws_autoscaling_group.tf-autoscaling.name}"
  }
#  actions_enabled = true
#  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions = ["${aws_autoscaling_policy.tf-asg-policy.arn}"]
}

