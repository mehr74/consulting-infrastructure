module "static" {
  source = "./modules/static"
  tags = var.tags
  buckets_paths = var.buckets_paths
  root_url = var.root_url
  url = var.url
  region = var.region
}