variable "region" {
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Globally-unique name for the S3 bucket that stores Terraform state (e.g. iac-python-webapp-state-<your-suffix>)"
  type        = string
}

variable "table_name" {
  description = "Name for the DynamoDB table used for Terraform state locking"
  type        = string
  default     = "terraform-locks"
}
