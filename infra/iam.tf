### --- lambda permissions ---
resource "aws_iam_role" "lambda_role" {
  name_prefix = "${var.namespace}lambda"
  force_detach_policies = true
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "lambda_policy_document" {
  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name_prefix = "${var.namespace}lambda"
  description = "Allow lambda to poll SQS"
  policy = data.aws_iam_policy_document.lambda_policy_document.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment"{
  role = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

data "aws_iam_policy_document" "lambda_logs_policy_document" {
  statement {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "${module.cloudwatch.log_group_arn}:*"
    ]
  }
}

resource "aws_iam_role_policy" "lambda_logs" {
  role = aws_iam_role.lambda_role.name
  name = "${var.namespace}logs"

  policy = data.aws_iam_policy_document.lambda_logs_policy_document.json
}

### --- sqs permissions ---

data "aws_iam_policy_document" "sqs_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "SQS:SendMessage",
    ]

    resources = [
      "*",
    ]
  }
}

### --- sns permissions ---

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns.arn

  policy = data.aws_iam_policy_document.sns_topic_policy.json
}

data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        #"sns.amazonaws.com" InvalidParameter: Invalid parameter: Policy Error: PrincipalNotFound
        "*"
        ]
    }

    resources = [
      "*"
    ]
  }
}