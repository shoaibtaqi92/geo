resource "aws_route53_zone" "private" {
  name = var.zone_name

  vpc {
    vpc_id = var.vpc_id
  }
}


resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.private.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 300
  records = var.records
}