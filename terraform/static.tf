module "static" {
  source = "./modules/static"
  tags = var.tags
  buckets_paths = var.buckets_paths
  url = var.url
  region = var.region
}