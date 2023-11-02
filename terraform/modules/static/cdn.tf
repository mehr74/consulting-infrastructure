resource "aws_cloudfront_origin_access_identity" "identity" {
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  dynamic "origin" {
    for_each = aws_s3_bucket.bucket
    content {
      domain_name = origin.value.bucket_regional_domain_name
      origin_id   = origin.value.bucket_regional_domain_name
    }
  }

  # aliases = [var.url]

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "S3 bucket distribution"
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.bucket[var.buckets_paths[0].bucket].bucket_regional_domain_name

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn            = null # aws_acm_certificate.acm_certificate.arn
    cloudfront_default_certificate = true # false
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = null # "sni-only"
  }
}
