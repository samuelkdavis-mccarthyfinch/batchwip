locals {
  log_group_name = "/aws/lambda/${var.lambda_name}"
}


resource "aws_cloudwatch_log_group" "log_group" {
  name = local.log_group_name
}

resource "aws_cloudwatch_log_subscription_filter" "worker_log_subscription_filter" {
  depends_on      = [aws_cloudwatch_log_group.log_group]
  role_arn        = ""
  name            = var.lambda_name
  log_group_name  = local.log_group_name
  filter_pattern  = ""
  destination_arn = var.logging_lambda_arn
}
