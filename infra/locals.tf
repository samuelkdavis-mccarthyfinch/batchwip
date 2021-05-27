locals {
  visibility_timeout_seconds = 900 # sqs needs to match lambda timeout
  lambda_function_name = var.namespace
}