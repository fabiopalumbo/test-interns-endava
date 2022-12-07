resource "aws_iam_role" "lambda_role" {
   name = "role_lambda"

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

#Define a policy which will allow APIGW to Assume an IAM Role
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

# Define a policy which will allow APIGW to access your s3
data "aws_iam_policy_document" "api_gw_lambda_invoke_policy" {
  statement {
      effect = "Allow"
      actions = [
        "lambda:InvokeFunction"
      ]
      resources = [
        "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*"
      ]
  }
}

resource "aws_iam_role" "api_gw_role" {
  name  = "${local.name}-api-gw-role"
  assume_role_policy = data.aws_iam_policy_document.apigw_assume_role.json
}

resource "aws_iam_role_policy" "api_gw_access_s3_policy" {
  name = "${local.name}-api-inovoke"
  role = aws_iam_role.api_gw_role.name
  policy = data.aws_iam_policy_document.api_gw_lambda_invoke_policy.json
}

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.HelloWorldLambda.function_name
   principal     = "apigateway.amazonaws.com"

   # The "/*/*" portion grants access from any method on any resource
   # within the API Gateway REST API.
   source_arn = "${aws_api_gateway_rest_api.apiLambda.execution_arn}/*/*"
}