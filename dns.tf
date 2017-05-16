provider "dnsimplei" {
  token   = "asdf"
  account = "asdf"
}

resource "dnsimple_record" "awesome" {
  domain = "awesome.com"
  type   = "A"
  name   = ""
  value  = "${aws_instance.web.0.public_ip}"
}
