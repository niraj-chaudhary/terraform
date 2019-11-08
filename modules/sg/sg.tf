resource "aws_security_group" "tf-security" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.cluster_name}"
  tags = {
    "Name" = "${var.cluster_name}"
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "tf-alb" {
  vpc_id = "${var.vpc_id}"
  name   = "${var.cluster_name}-alb"
  tags = {
    "Name" = "${var.cluster_name}-alb"
  }
  ingress {
    from_port   = "443"
    to_port     = "443"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "terraform_ec2_key" {
  key_name   = "terraform_ec2_key"
  public_key = "${file("keys/aws_terraform.pub")}"
}

output "sg_id" {
  value = "${aws_security_group.tf-security.id}"
}

output "asg_id" {
  value = "${aws_security_group.tf-alb.id}"
}

output "key_name" {
  value = "${aws_key_pair.terraform_ec2_key.id}"
}
