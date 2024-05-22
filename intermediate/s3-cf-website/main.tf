# Creates a CloudFront distribution for a static website with an S3 bucket as the origin. It omits several key
# features such as logging, custom error pages, a custom domain name, WAF, and is not highly available. That can all be
# found in the advanced example.

resource "aws_s3_bucket" "primary" {
  bucket_prefix = var.bucket_name_prefix
  force_destroy = true
}

resource "aws_s3_bucket_policy" "primary" {
  bucket = aws_s3_bucket.primary.bucket
  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = {
      "Sid" = "AllowCloudFrontServicePrincipalReadOnly",
      "Effect" = "Allow",
      "Principal" = {
        "Service" = "cloudfront.amazonaws.com"
      },
      "Action" = "s3:GetObject",
      "Resource" = "${aws_s3_bucket.primary.arn}/*",
      "Condition" = {
        "StringEquals" = {
          "AWS:SourceArn": aws_cloudfront_distribution.this.arn
        }
      }
    }
  })
}

resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = aws_s3_bucket.primary.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.primary.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = var.default_root_object

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.cached_methods
    target_origin_id = aws_s3_bucket.primary.bucket_regional_domain_name

    cache_policy_id = aws_cloudfront_cache_policy.this.id

    viewer_protocol_policy = var.viewer_protocol_policy
  }

  restrictions {
    geo_restriction {
      restriction_type = var.geo_restriction_type
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name = var.tag_name
  }
}

resource "aws_cloudfront_cache_policy" "this" {
  name        = var.cache_policy_name
  comment     = var.policy_comment
  default_ttl = 50
  max_ttl     = 100
  min_ttl     = 1

  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = var.cookie_behavior
    }

    headers_config {
      header_behavior = var.header_behavior
    }

    query_strings_config {
      query_string_behavior = var.query_string_behavior
    }
  }
}

resource "aws_cloudfront_origin_access_control" "this" {
  name                              = var.oac_name
  description                       = var.oac_description
  origin_access_control_origin_type = var.oac_origin_type
  signing_behavior                  = var.oac_signing_behavior
  signing_protocol                  = "sigv4" # This is the only valid value
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.primary.bucket
  key    = "index.html"
  content = "<html><head><title>Hello, World!</title></head><body><h1>Hello, World!</h1></body></html>"
  etag = md5("<html><head><title>Hello, World!</title></head><body><h1>Hello, World!</h1></body></html>")
  content_type = "text/html"
}

