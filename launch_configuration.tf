resource "aws_launch_configuration" tf-launchconfig {
  name_prefix   = "source-consumer"
  image_id      = "${lookup(var.ec2_ami,var.region)}"
  instance_type = "${var.ins_type}"
#  key_name     = "${aws_key_pair.tf-key.key_name}"
  key_name     = "${var.key_name}"
  #security_groups = ["${aws_security_group.tf-security.id}"]
  security_groups = ["sg-06498d55277b9d9eb"]
  user_data	= "${file("install_custom.sh")}" 
  ebs_block_device { 
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
  }
}
