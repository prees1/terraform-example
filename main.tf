#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-f2b39792
#
# Your subnet ID is:
#
#     
#
# Your security group ID is:
#
#     sg-578da130
#
# Your Identity is:
#
#     HashiDays-2017-tf-goldfish
#

terraform {
  backend "atlas" {
    name = "prees/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

variable "num_webs" {
  default = "2"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-f2b39792"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-f4056fac"
  vpc_security_group_ids = ["sg-578da130"]

  tags = {
    "Identity" = "HashiDays-2017-tf-goldfish"
    "Foo"      = "Bar"
    "hello"    = "world"
    "name"     = "web ${count.index+1}/${var.num_webs}"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
