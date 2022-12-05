resource "aws_lambda_function" "HelloWorld" {
    function_name = "${var.name}-lambda"

    s3_bucket = var.s3_bucket
    
    s3_key = var.s3_content

    handler = "hello.handler"

    runtime = "python3.8"

    
}