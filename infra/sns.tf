resource "aws_sns_topic" "sns" {
  name_prefix = var.namespace

  # kms_master_key_id = var.kms_master_key_id
  # policy = ? doesn't seem to be needed
  # sqs_success_feedback_role_arn = ? is this needed along with sqs_failure_feedback_role_arn?

  delivery_policy = <<EOF
{
  "http": {
    "defaultHealthyRetryPolicy": {
      "minDelayTarget": 20,
      "maxDelayTarget": 20,
      "numRetries": 3,
      "numMaxDelayRetries": 0,
      "numNoDelayRetries": 0,
      "numMinDelayRetries": 0,
      "backoffFunction": "linear"
    },
    "disableSubscriptionOverrides": false,
    "defaultThrottlePolicy": {
      "maxReceivesPerSecond": 1
    }
  }
}
EOF
}

