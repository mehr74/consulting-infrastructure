module "api-server" {
  source = "./modules/api-server"
  tags = var.tags
  region = var.region
  availability_zone = "eu-central-1a"
  instance_type = var.instance_type
  public_key = var.public_key
}