output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "cloudfront_id" {
  value = aws_cloudfront_distribution.this.id
}

output "cloudfront_arn" {
  value = aws_cloudfront_distribution.this.arn
}

output "cloudfront_status" {
  value = aws_cloudfront_distribution.this.status
}

output "cloudfront_etag" {
  value = aws_cloudfront_distribution.this.etag
}

output "cloudfront_tags" {
  value = aws_cloudfront_distribution.this.tags_all
}

output "cloudfront_origin_access_control_id" {
  value = aws_cloudfront_origin_access_control.this.id
}

output "cloudfront_origin_access_control_etag" {
  value = aws_cloudfront_origin_access_control.this.etag
}