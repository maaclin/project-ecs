
resource "aws_acm_certificate" "ysolom" {
  domain_name       = var.domain_name_acm
  validation_method = var.validation_method

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "main" {
  name         = var.domain_name
  private_zone = false
}

resource "aws_route53_record" "cert_valid" {
  zone_id = data.aws_route53_zone.main.zone_id

  for_each = {
    for dvo in aws_acm_certificate.ysolom.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = var.acm_ttl
  type            = each.value.type
}

resource "aws_acm_certificate_validation" "ysolom" {
  certificate_arn         = aws_acm_certificate.ysolom.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_valid : record.fqdn]

  timeouts { create = "5m" }

}