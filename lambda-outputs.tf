output "lambda" {
  value = "${aws_lambda_function.HelloWorldLambda.qualified_arn}"
}
