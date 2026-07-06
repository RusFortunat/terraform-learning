output "s3_bucket_name" {
  value       = aws_s3_bucket.bucket.id
  sensitive   = true
  description = "The name of the S3 bucket"
}

output "sensitive_value" {
  value = var.ec2_instance_type
  sensitive   = true
}