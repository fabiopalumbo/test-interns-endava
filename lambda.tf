resource "aws_lambda_function" "HelloWorldLambda" {
  filename         = "${data.archive_file.zip.output_path}"
  function_name    = "HelloWorldLambda"
  role             = "${aws_iam_role.lambda_exec_role.arn}"
  handler          = "py.lambda_handler"
  runtime          = "python3.8"
  source_code_hash = "${data.archive_file.zip.output_base64sha256}"
}
