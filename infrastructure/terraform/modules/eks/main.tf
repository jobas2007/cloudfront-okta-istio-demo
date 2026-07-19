module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"
  name    = "${var.name}-vpc"
  cidr    = var.vpc_cidr

  azs = [
    "us-east-1a",
    "us-east-1b"
  ]

  private_subnets = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  public_subnets = [
    "10.0.101.0/24",
    "10.0.102.0/24"
  ]

  enable_nat_gateway         = false
  enable_dns_hostnames       = true
  enable_dns_support         = true
  map_public_ip_on_launch    = true

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}



module "eks" {
  source                         = "terraform-aws-modules/eks/aws"
  version                        = "~> 21.0"
  name                           = var.name
  kubernetes_version             = "1.31"
  vpc_id                         = module.vpc.vpc_id
  subnet_ids                     = module.vpc.public_subnets
  endpoint_public_access         = true
  enable_irsa                    = true
  
  eks_managed_node_groups = {
    demo = {
      min_size = 1
      max_size = 2
      desired_size = 1
      instance_types = [
        var.node_instance_type
      ]
      subnet_ids = module.vpc.public_subnets
    }
  }

  tags = {
    Project = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

