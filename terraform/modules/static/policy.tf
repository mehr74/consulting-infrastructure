resource "aws_s3_bucket_public_access_block" "public" {
  for_each = aws_s3_bucket.bucket
  bucket = each.value.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

data "aws_iam_policy_document" "aws_iam_policy" {
  for_each = aws_s3_bucket.bucket
  policy_id = "PolicyAllowCloudFrontServicePrincipalRead"
  statement {
    sid       = "AllowCloudFrontServicePrincipalRead"
    effect    = "Allow"
    actions   = ["s3:GetObject"]
    resources = ["${each.value.arn}/*"]
    principals {
      type = "*"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "aws_bucket_policy" {
  for_each = aws_s3_bucket.bucket
  bucket = each.value.id
  policy = data.aws_iam_policy_document.aws_iam_policy[each.key].json
}