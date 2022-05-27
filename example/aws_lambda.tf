variable "aws_region" {
  default = "eu-central-1"
}

provider "aws" {
  region          = "${var.aws_region}"
}

module lambda_python_w_deps {
  source           = "github.com/makzzz1986/tf-aws-lambda-python-with-dependencies"
  script_path      = "${path.module}/test.py"
  pip_dependencies = ["pyfiglet==0.8.post1"]
}


resource aws_lambda_function hello_world {
  filename         = module.lambda_python_w_deps.package_path
  function_name    = "bucket_list"
  role             = "${aws_iam_role.iam_for_check_bucket_1.arn}"
  description      = "Lambda for testing dependencies"
  handler          = "${module.lambda_python_w_deps.handler_file_name}.handler"
  source_code_hash = module.lambda_python_w_deps.package_sha
  runtime          = "python3.8"
  timeout          = 120
  publish          = true
}



resource "aws_iam_role" "iam_for_check_bucket_1" {
  name = "iam_for_check_bucket_1"
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
