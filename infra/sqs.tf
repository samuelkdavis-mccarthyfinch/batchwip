resource "aws_sqs_queue" "sqs" {
  name_prefix                = var.namespace
  visibility_timeout_seconds = 900 # default is 30, needs to be at least the same as the lambda timeout or you'll get the error "Queue visibility timeout: 30 seconds is less than Function timeout: 900 seconds
  max_message_size           = 2048
  message_retention_seconds  = 1209600 # 14 days
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.sqs_dead_letter_queue.arn
    maxReceiveCount     = 1
  })

  policy = data.aws_iam_policy_document.sqs_policy.json

  tags = {
    Environment = var.environment_name
  }
}

resource "aws_sqs_queue" "sqs_dead_letter_queue" {
  name_prefix               = "${var.namespace}deadletter"
  max_message_size          = 2048
  message_retention_seconds = 1209600 # 14 days

  policy = data.aws_iam_policy_document.sqs_policy.json

  tags = {
    Environment = var.environment_name
  }
}


resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn     = aws_sns_topic.sns.arn
  protocol      = "sqs"
  endpoint      = aws_sqs_queue.sqs.arn
  filter_policy = <<EOF
{
  "priority": [
    "fast"
  ]
}
EOF
}
