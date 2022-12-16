resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Give the Lambda function permission to access S3
resource "aws_iam_role_policy" "lambda_exec_policy" {
  name = "lambda_exec_policy"
  role = "${aws_iam_role.lambda_exec_role.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.b.id}/*"
      ]
    }
  ]
}
EOF
}
data "aws_iam_policy_document" "apigw_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "api_gw_lambda_invoke_policy" {
  statement {
      effect = "Allow"
      actions = [
        "lambda:InvokeFunction"
      ]
      resources = [
        "arn:aws:lambda:us-east-1:476795228417:function:HelloWorldLambda:$LATEST"
      ]
  }
}

resource "aws_iam_role" "api_gw_role" {
  name = "${local.name}-api_gw_role"
  assume_role_policy = data.aws_iam_policy_document.apigw_assume_role.json
}

resource "aws_iam_role_policy" "api_gw_access" {
  name = "${local.name}-api_invoke-"
  role = aws_iam_role.api_gw_role.name
  policy = data.aws_iam_policy_document.api_gw_lambda_invoke_policy.json
}