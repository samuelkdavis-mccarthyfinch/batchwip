resource "aws_lambda_function" "lambda" {
  filename      = var.lambda_file_name # use filename instead of s3_bucket & s3_key "AWS region where you are creating the Lambda function."
  function_name = local.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  handler       = var.lambda_handler

  timeout          = 900
  source_code_hash = filebase64sha256(var.lambda_file_name)

  runtime = "nodejs14.x"
  publish = false # published versions are only needed for provisioned concurrency

  # reserved concurrency is maximum count of lambdas to run (throttle). 
  # Provisioned concurrency is the minimum count of lambdas to run (keep warm)
  reserved_concurrent_executions = 1

  # vpc_config = {
  #   security_group_ids = var.security_group_ids
  #   subnet_ids = var.subnet_ids
  # }

  # dead_letter_config


  environment {
    variables = {
      environment_name = var.environment_name
    }
  }

  # todo
  # tags = [

  # ]
}

resource "aws_lambda_event_source_mapping" "lambda_event_source_mapping" {
  event_source_arn = aws_sqs_queue.sqs.arn
  function_name    = aws_lambda_function.lambda.arn
  batch_size       = 1
  # maximum_retry_attempts = 10 # randomly picked number
  # InvalidParameterValueException: MaximumRetryAttempts isn't supported for this event source type
}
# "Queue visibility timeout: 30 seconds is less than Function timeout: 900 seconds

module "cloudwatch" {
  source             = "./cloudwatch"
  logging_lambda_arn = "${var.logging_lambda_arn}"
  lambda_name        = "${local.lambda_function_name}"
}
