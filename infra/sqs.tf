resource "aws_sqs_queue" "sqs" {
  name_prefix                = var.namespace
  # delay_seconds              = 90
  visibility_timeout_seconds = 900 # default is 30, "Queue visibility timeout: 30 seconds is less than Function timeout: 900 seconds
  max_message_size           = 2048
  message_retention_seconds  = 86400
  receive_wait_time_seconds  = 10
  # redrive_policy = jsonencode({
  #   deadLetterTargetArn = aws_sqs_queue.terraform_queue_deadletter.arn
  #   maxReceiveCount     = 4
  # })

  policy = data.aws_iam_policy_document.sqs_policy.json
  #redrive_policy

  tags = {
    Environment = var.environment_name
  }
}


resource "aws_sns_topic_subscription" "user_updates_sqs_target" {
  topic_arn = aws_sns_topic.sns.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.sqs.arn
  filter_policy =  <<EOF
{
  "priority": [
    "fast"
  ]
}
EOF
}