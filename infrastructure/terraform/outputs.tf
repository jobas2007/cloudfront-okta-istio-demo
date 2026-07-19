output "frontend_bucket_name" {
  description = "Frontend S3 bucket name"
  value       = module.s3.bucket_name
}

output "frontend_bucket_arn" {
  description = "Frontend S3 bucket ARN"
  value       = module.s3.bucket_arn
}

# Outputs disabled for local minikube development
# output "ecr_repository_url" {
#   value = module.ecr.repository_url
# }

# output "eks_cluster_name" {
#   value = module.eks.cluster_name
# }


