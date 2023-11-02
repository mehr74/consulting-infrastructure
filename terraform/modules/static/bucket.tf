resource "aws_s3_bucket" "bucket" {
  for_each = { for b in var.buckets_paths : b.bucket => b }
  bucket = each.value.bucket
  tags = var.tags
}

output "bucket_ids" {
  value = { for b in aws_s3_bucket.bucket : b.bucket => b.id }
  description = "The IDs of the buckets"
}

output "bucket_arns" {
  value = { for b in aws_s3_bucket.bucket : b.bucket => b.arn }
  description = "The ARNs of the buckets"
}