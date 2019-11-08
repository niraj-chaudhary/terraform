resource "aws_launch_configuration" "tf-launch" {
  name_prefix     = "${var.cluster_name}-lc"
  image_id        = "${lookup(var.ec2_ami, var.region)}"
  instance_type   = "${var.ins_type}"
  key_name        = "${var.key_name}"
  security_groups = ["${var.sg_id}"]
  user_data       = "${file("../modules/launch/install_custom.sh")}"
}

output "launch_name" {
  value = "${aws_launch_configuration.tf-launch.id}"
}
