resource "aws_security_group" "main" {
  name        = "${var.component}-${var.env}-sg"
  description = "${var.component}-${var.env}-sg"

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "-1"
    cidr_blocks = var.sg_subnets_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component}-${var.env}-sg"
  }
}


resource "aws_launch_template" "main" {
  name = "${var.component}-${var.env}"

  iam_instance_profile {
    name = aws_iam_instance_profile.instance_profile.name
  }
  image_id               = data.aws_ami.ami.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]

  tag_specifications {
    resource_type = "instance"
    tags          = merge({ Name = "${var.component}-${var.env}", Monitor = "true" }, var.tags)
  }

  user_data = templatefile("${path.module}/userdata.sh", {
    env       = var.env
    component = var.component
  })

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size = 10
      encrypted   = "true"
      kms_key_id  = var.kms_key_id
    }
  }
}

resource "aws_autoscaling_group" "main" {
  desired_capacity = var.desired_capacity
  max_size         = var.max_size
  min_size         = var.min_size

  launch_template {
    id      = aws_launch_template.main.id
    version = "$Latest"
  }
}



//resource "aws_route53_record" "dns" {
//  zone_id = "Z055331734ICV430E01P7"
//  name    = "${var.component}-dev"
//  type    = "A"
//  ttl     = 30
//  records = [aws_instance.instance.private_ip]
//}
//
