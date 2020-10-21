provider "aws" {
 region = "${var.region}"
 shared_credentials_file = "${var.shared_cred_file}"
 profile = "default"
}
resource "aws_key_pair" "deployer"{
  key_name   = "deployer-key"
  public_key = "${file("${var.ssh_key}")}" # Please add the public key of the key-pair
 }

data "aws_ami" "ubuntu"{ 
   most_recent = true

   owners = ["099720109477"]

    filter {
        name   = "name"
        values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
}

data "aws_availability_zones" "all"{}

# Creating EC2 instance
resource "aws_instance" "gsk-one"{
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  source_dest_check      = false
  instance_type          = "t2.micro"

  tags = {
    Name = "gsk-testing"
  }
}

resource "aws_instance" "gsk-two"{
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.instance.id}"]
  source_dest_check      = false
  instance_type          = "t2.micro"

  tags = {
    Name = "gsk-testing" 
  }
}

# Creating Security Group for EC2
resource "aws_security_group" "instance"{
  name = "terraform-gsk"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
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

# Security Group for ELB
resource "aws_security_group" "elb"{
  name = "terraform-gsk-elb"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Creating ELB
resource "aws_elb" "example"{
  name               = "terraform-elb-gsk"
  security_groups    = ["${aws_security_group.elb.id}"]
  availability_zones = "${data.aws_availability_zones.all.names}"

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "TCP:22"
  }

  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = "80"
    instance_protocol = "http"
  }
}

resource "aws_elb_attachment" "one"{
  elb      = "${aws_elb.example.id}"
  instance = "${aws_instance.gsk-one.id}"
}

resource "aws_elb_attachment" "two"{
  elb      = "${aws_elb.example.id}"
  instance = "${aws_instance.gsk-two.id}"
}
