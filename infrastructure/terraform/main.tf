module "s3" {
  source       = "./modules/s3"
  bucket_name  = var.bucket_name
  project_name = var.project_name
  environment  = var.environment
}


module "ecr" {
  source          = "./modules/ecr"
  repository_name = "${var.project_name}-backend"
  project_name    = var.project_name
  environment     = var.environment
}


module "eks" {
  source             = "./modules/eks"
  name               = var.name
  vpc_cidr           = var.vpc_cidr
  node_instance_type = var.node_instance_type
  project_name       = var.project_name
  environment        = var.environment
}


