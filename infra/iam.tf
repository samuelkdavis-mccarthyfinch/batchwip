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


### --- sqs permissions ---
# may be needed instead of giving lambda sqs permissions. I can't find anything online around this.
# resource "aws_lambda_permission" "with_sns" {
#   statement_id  = "AllowExecutionFromSNS"
#   action        = "lambda:InvokeFunction"
#   function_name = aws_lambda_function.func.function_name
#   principal     = "sns.amazonaws.com"
#   source_arn    = aws_sns_topic.default.arn
# }

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_subscription

# SNS permissions are weird, may need to add additional permissions for the sqs/sns calls
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

# todo where to attach & how to attach
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