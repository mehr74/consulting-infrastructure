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

  aliases = [var.url]

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

  dynamic "ordered_cache_behavior" {
    for_each = var.buckets_paths
    iterator = i

    content {
      path_pattern           = i.value.path
      target_origin_id       = aws_s3_bucket.bucket[i.value.bucket].bucket_regional_domain_name
      viewer_protocol_policy = "redirect-to-https"

      allowed_methods           = ["GET", "HEAD", "OPTIONS"]
      cached_methods            = ["GET", "HEAD"]
      compress                  = null
      field_level_encryption_id = null
      smooth_streaming          = null
      trusted_signers           = null
      trusted_key_groups        = null

      cache_policy_id            = null
      origin_request_policy_id   = null
      response_headers_policy_id = null
      realtime_log_config_arn    = null

      min_ttl     = null
      default_ttl = null
      max_ttl     = null

      forwarded_values {
        query_string = false
        query_string_cache_keys = []
        headers = []

        cookies {
          forward = "none"
          whitelisted_names = null
        }
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.acm_certificate.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1"
    ssl_support_method             = "sni-only"
  }
}
